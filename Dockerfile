FROM python:3.13-slim AS build

# Set environment variables to prevent Python from writing .pyc files and buffering output
ENV PYTHONUNBUFFERED=1

#Set working dir within container
WORKDIR /app

#Copy requirements.txt and app, pip install requirements
COPY requirements.txt app.py .
RUN pip install --no-cache-dir -r requirements.txt

#Pin build container to latest release digest
FROM python:3.13-slim@sha256:ae9f9ac89467077ed1efefb6d9042132d28134ba201b2820227d46c9effd3174

#Set working dir within container
WORKDIR /app

#Add user to run as instead of root
RUN groupadd -g 1000 python && useradd -u 1000 -g python python

#Copy installed dependencies from build stage
COPY --from=build /usr/local/lib/python3.13/site-packages /usr/local/lib/python3.13/site-packages
COPY --from=build /usr/local/bin /usr/local/bin

#Copy app into working dir
COPY --from=build /app /app

#Change ownership to running user
RUN chown -R python:python /app

#Run as non-root user
USER python

#Expose Flask port
EXPOSE 5000

# gunicorn command to run the application with 2 workers
CMD ["gunicorn", "app:app", "-b", "0.0.0.0:5000", "-w", "2"]
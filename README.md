# Dockerfile
This Dockerfile uses a multi-stage build to create a secure and efficient image for a Python
application. The first stage installs dependencies in a python:3.13-slim environment. The second 
stage builds the production image, based on a specific digest of python:3.13-slim for immutability. 
It creates a non-root user (python) for security, copies only the necessary dependencies and 
application code from the build stage, and starts the application with Gunicorn for production-level 
performance. This approach minimizes image size, enhances security, and ensures reproducibility.

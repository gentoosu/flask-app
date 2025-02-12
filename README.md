# Dockerfile
This Dockerfile uses a multi-stage build to create a secure and efficient image for a Python
application. The first stage installs dependencies in a python:3.13-slim environment. The second 
stage builds the production image, based on a specific digest of python:3.13-slim for immutability. 
It creates a non-root user (python) for security, copies only the necessary dependencies and 
application code from the build stage, and starts the application with Gunicorn for production-level 
performance. This approach minimizes image size, enhances security, and ensures reproducibility.

# Github Action workflow
The GitHub Actions workflow automates the process of building, testing, and publishing a Docker image 
to Amazon Elastic Container Registry. The workflow is triggered on push and pull requests to ensure 
validation before deployment. It starts by checking out the repository using actions/checkout, followed 
by setting up AWS credentials with aws-actions/configure-aws-credentials to authenticate with ECR. The 
pipeline then logs into ECR using aws-actions/amazon-ecr-login, ensuring access to push the container. 
Next, it builds the Docker image using docker build, tagging it dynamically based on CalVer with an 
incrementing value. Before publishing, the workflow runs unit tests using pytest within the container to 
validate functionality. If tests pass, the image is pushed to ECR using docker push. The workflow ensures 
best practices, including multi-stage builds in the Dockerfile, and runs on GitHub-hosted Ubuntu runners 
for efficiency. 

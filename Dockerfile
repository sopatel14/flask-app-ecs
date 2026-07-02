# Base image (OS)
FROM python:3.14-slim

# Update and upgrade system packages to fix vulnerabilities
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Working directory
WORKDIR /app

# Copy src code to container
COPY . .

# Run the build commands
RUN pip install -r requirements.txt

# Expose port 80
EXPOSE 80

# Serve the app / run the app (keep it running)
CMD ["python", "run.py"]
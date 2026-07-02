# Base image (OS) - Switch to Alpine for better security
FROM python:3.14-alpine

# Install only essential packages
RUN apk add --no-cache \
    gcc \
    musl-dev \
    libffi-dev \
    && apk upgrade --no-cache

# Working directory
WORKDIR /app

# Copy src code to container
COPY . .

# Run the build commands
RUN pip install --no-cache-dir -r requirements.txt

# Expose port 80
EXPOSE 80

# Serve the app / run the app (keep it running)
CMD ["python", "run.py"]
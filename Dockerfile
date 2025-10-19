# Use latest stable Python image (Debian 12 Bookworm)
FROM python:3.12-slim-bookworm

# Prevent interactive prompts
ENV DEBIAN_FRONTEND=noninteractive

# Update & install dependencies
RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y git curl ffmpeg && \
    rm -rf /var/lib/apt/lists/*

# Install latest Node.js (LTS)
RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash - && \
    apt-get install -y nodejs && \
    npm install -g npm@latest

# Set up app directory
WORKDIR /app
COPY . /app/

# Install Python dependencies
RUN pip install --upgrade pip && pip install -r requirements.txt

# Start the bot
CMD ["python", "main.py"]

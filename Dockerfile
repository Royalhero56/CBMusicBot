# ✅ Latest stable Python with active Debian version
FROM python:3.12-slim-bookworm

# Disable interactive mode
ENV DEBIAN_FRONTEND=noninteractive

# ✅ Update & install all required system dependencies
RUN apt-get update && apt-get install -y \
    git curl ffmpeg gcc g++ make \
    libssl-dev libffi-dev python3-dev \
    && rm -rf /var/lib/apt/lists/*

# ✅ Install Node.js (LTS version)
RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash - && \
    apt-get install -y nodejs && \
    npm install -g npm@latest

# ✅ Set up app directory
WORKDIR /app
COPY . /app/

# ✅ Upgrade pip and install Python packages
RUN pip install --upgrade pip setuptools wheel
RUN pip install -r requirements.txt

# ✅ Optional: clean cache to reduce image size
RUN apt-get clean && rm -rf /root/.cache/pip

# ✅ Start the bot automatically
CMD ["python", "main.py"]

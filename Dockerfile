# Use official Ubuntu as base image
FROM ubuntu:20.04

# Set timezone and non-interactive mode
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Asia/Kolkata

# Create working directory
RUN mkdir /app && chmod 777 /app
WORKDIR /app

# Copy all project files
COPY . .

# Install necessary packages
RUN apt update && apt install -y --no-install-recommends \
    git wget aria2 curl busybox python3 python3-pip \
    p7zip-full p7zip-rar unzip mkvtoolnix ffmpeg \
    && apt clean && rm -rf /var/lib/apt/lists/*

# Install Python packages
RUN pip3 install --no-cache-dir -r requirements.txt

# Set script permissions
RUN chmod +x extract run.sh

# Expose port 8000 (dummy server)
EXPOSE 8000

# Start both the bot and dummy server
CMD bash -c "python3 -m http.server 8000 & bash run.sh"

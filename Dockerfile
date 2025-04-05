# Import Ubuntu
FROM ubuntu:20.04

# Set timezone and environment flags
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Asia/Kolkata

# Create app directory
RUN mkdir /app && chmod 777 /app
WORKDIR /app

# Copy project files into container
COPY . .

# Install required apt packages
RUN apt update && apt install -y --no-install-recommends \
    git wget aria2 curl busybox python3 python3-pip \
    p7zip-full p7zip-rar unzip mkvtoolnix ffmpeg

# Install Python requirements
RUN pip3 install --no-cache-dir -r requirements.txt

# Set permissions for scripts
RUN chmod +x extract run.sh

# Start bot
CMD ["bash", "run.sh"]

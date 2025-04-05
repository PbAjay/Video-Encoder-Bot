FROM python:3.10-slim

WORKDIR /app

# Install system dependencies
RUN apt update && apt install -y ffmpeg git mediainfo gcc

# Install pip packages
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the bot code
COPY . .

# Git identity fix
RUN git config --global user.email "pbajay475@gmail.com" && \
    git config --global user.name "PbAjay"

# Expose port for Koyeb health checks
EXPOSE 8000

# Health check endpoint (simple one using Python)
RUN echo 'from http.server import BaseHTTPRequestHandler, HTTPServer\nclass Handler(BaseHTTPRequestHandler):\n    def do_GET(self):\n        self.send_response(200)\n        self.end_headers()\n        self.wfile.write(b"OK")\nHTTPServer(("0.0.0.0", 8000), Handler).serve_forever()' > healthcheck.py

# Start health check in background + bot
CMD python3 healthcheck.py & python3 -m VideoEncoder

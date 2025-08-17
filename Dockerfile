# Vulnerable Dockerfile for testing security workflows
FROM ubuntu:18.04

# Running as root (vulnerability)
USER root

# Installing packages without version pinning (vulnerability)
RUN apt-get update && apt-get install -y \
    curl \
    wget \
    openssh-server \
    telnet

# Exposing unnecessary ports (vulnerability)
EXPOSE 22 23 80 443 8080

# Adding secrets in environment variables (vulnerability)
ENV API_KEY=sk-1234567890abcdef
ENV DATABASE_PASSWORD=admin123
ENV SECRET_TOKEN=super_secret_token_123

# Copying files with overly permissive permissions (vulnerability)
COPY . /app
RUN chmod 777 /app

# Running SSH daemon (vulnerability)
RUN service ssh start

# Using ADD instead of COPY for URLs (vulnerability)
ADD https://example.com/script.sh /tmp/

WORKDIR /app

# Running application as root (vulnerability)
CMD ["python", "app.py"]
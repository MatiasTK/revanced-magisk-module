# ReVanced Magisk Module Builder
# Dockerfile for building ReVanced modules and APKs

FROM ubuntu:24.04

LABEL maintainer="ReVanced Magisk Module Builder"
LABEL description="Docker image for building ReVanced Magisk modules and APKs"

# Prevent interactive prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Install required dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    openjdk-17-jre-headless \
    jq \
    zip \
    unzip \
    curl \
    wget \
    git \
    ca-certificates \
    dos2unix \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Set Java environment
ENV JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64
ENV PATH="$JAVA_HOME/bin:$PATH"

# Create working directory
WORKDIR /app

# Copy all project files
COPY . .

# Convert Windows CRLF line endings to Unix LF and make scripts executable
RUN dos2unix *.sh sig.txt && chmod +x build.sh build-termux.sh utils.sh

# Set default command
CMD ["./build.sh"]

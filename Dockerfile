FROM ubuntu:24.04

# Prevent interactive prompts during installation
ENV DEBIAN_FRONTEND=noninteractive

# Update system and install base packages + Ubuntu utilities
RUN apt-get update && apt-get install -y \
    curl \
    sudo \
    git \
    wget \
    build-essential \
    python3 \
    python3-pip \
    && rm -rf /var/lib/apt/lists/*

# Install the latest version of code-server using the official Ubuntu script
RUN curl -fsSL https://code-server.dev/install.sh | sh

# Give the built-in 'ubuntu' user (UID 1000) passwordless sudo rights
RUN echo "ubuntu ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Prepare safe workspace directories inside the default ubuntu profile
RUN mkdir -p /home/ubuntu/workspace && chown -R ubuntu:ubuntu /home/ubuntu

USER ubuntu
WORKDIR /home/ubuntu/workspace

# Hugging Face app port
EXPOSE 7860

# Start code-server
CMD ["code-server", "--bind-addr", "0.0.0.0:7860", "--auth", "password"]

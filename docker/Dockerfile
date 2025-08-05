# Multi-architecture compatible Dockerfile
FROM python:3.9-slim

# Build arguments for multi-arch
ARG TARGETPLATFORM
ARG BUILDPLATFORM

# Set working directory
WORKDIR /app

# Install system dependencies including antiword for .doc conversion and LibreOffice for .ppt conversion
RUN apt-get update && apt-get install -y \
    gcc \
    g++ \
    libxml2-dev \
    libxslt1-dev \
    zlib1g-dev \
    libjpeg-dev \
    libpng-dev \
    libfreetype6-dev \
    libmagic1 \
    curl \
    antiword \
    catdoc \
    unzip \
    libreoffice-core \
    libreoffice-impress \
    libreoffice-common \
    libreoffice-java-common \
    default-jre \
    fontconfig \
    pandoc \
    && rm -rf /var/lib/apt/lists/*

# Copy requirements and install Python dependencies
COPY ../requirements.txt .
RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt

# Create non-root user
RUN groupadd -r appuser && useradd -r -g appuser -m appuser

# Create necessary directories for LibreOffice with proper permissions
RUN mkdir -p /home/appuser/.config/libreoffice/4/user \
    && mkdir -p /home/appuser/.cache/dconf \
    && mkdir -p /home/appuser/.local/share/fonts \
    && mkdir -p /tmp/uploads \
    && chown -R appuser:appuser /home/appuser /tmp/uploads /app

# Initialize LibreOffice as root to create system-wide configuration
RUN libreoffice --headless --terminate_after_init

# Copy application files
COPY ../src/ ./

# Fix ownership after copying files
RUN chown -R appuser:appuser /app

# Switch to non-root user
USER appuser

# Initialize LibreOffice for the appuser to create user-specific configuration
RUN libreoffice --headless --terminate_after_init

# Expose port
EXPOSE 8000

# Environment variables
ENV PYTHONPATH=/app
ENV PYTHONUNBUFFERED=1

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=40s --retries=3 \
    CMD curl -f http://localhost:8000/ || exit 1

# Run application
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000", "--workers", "2"]
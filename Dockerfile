# Use an official Python runtime as a parent image
FROM python:3.10-slim

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1
ENV PYTHONPATH=/app/src

# Set the working directory in the container
WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Install Python dependencies
COPY requirements_docker.txt .
RUN pip install --no-cache-dir -r requirements_docker.txt

# Copy the rest of the application code
COPY . .

# Expose ports (if any of the agents host a server, e.g., FastMCP)
# For the MCP server, it usually runs over stdio but FastMCP can use HTTP.
EXPOSE 8000

# Default command (can be overridden in docker-compose)
CMD ["python", "-m", "vpp.agents.grid_agent"]

#!/bin/bash

set -e

# Define environment variables
VENV_DIR=".venv"
REQUIREMENTS_FILE="requirements.txt"

echo "Setting up the Python virtual environment..."

# Check for python3 and pip3
if ! command -v python3 &> /dev/null; then
    echo "Python3 is not installed. Please install Python3 and try again."
    exit 1
fi

# Create environment if it doesn't exist
if [ ! -d "$VENV_DIR" ]; then
    echo "Creating virtual environment in $VENV_DIR..."
    python3 -m venv "$VENV_DIR"
else
    echo "Virtual environment already exists in $VENV_DIR."
fi

# Activate the virtual environment and install dependencies
echo "Activating virtual environment and installing dependencies..."
source "$VENV_DIR/bin/activate"
pip install --upgrade pip
pip install -r "$REQUIREMENTS_FILE"

echo "Setup complete. To activate the virtual environment, run 'source $VENV_DIR/bin/activate'."
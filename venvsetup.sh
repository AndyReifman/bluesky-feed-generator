#!/bin/sh

PYTHON_EXECUTABLE=$(which python)


# Set the virtual environment name (change this if needed)
VENV_NAME=".venv"

# Function to create the virtual environment
create_venv() {
    if [ -d "$VENV_NAME" ]; then
        echo "Deleting existing virtual environment..."
        rm -rf "$VENV_NAME"
    fi
    $PYTHON_EXECUTABLE -m venv "$VENV_NAME"
    if [ $? -ne 0 ]; then
        echo "Error: Failed to create virtual environment!"
        exit 1
    fi
}

# Function to install project requirements
install_requirements() {
  poetry install
}

create_venv && install_requirements
source .venv/bin/activate

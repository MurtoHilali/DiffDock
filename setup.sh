#!/bin/bash

# Check if Conda is installed
if ! command -v conda &> /dev/null; then
    echo "conda not found. Please install Conda before running this script."
    exit 1
fi

# Initialize Conda
source $(conda info --base)/etc/profile.d/conda.sh

# Create the Conda environment
conda env create --file environment.yml || { echo "Environment creation failed"; exit 1; }

# Activate the environment
conda activate diffdock || { echo "Environment activation failed"; exit 1; }

# Install PyTorch and PyTorch Geometric dependencies
pip install --extra-index-url https://download.pytorch.org/whl/cu117 \
    --find-links https://pytorch-geometric.com/whl/torch-1.13.1+cu117.html \
    torch==1.13.1+cu117 || { echo "PyTorch installation failed"; exit 1; }

# Install additional dependencies
pip install -r requirements.txt || { echo "Requirements installation failed"; exit 1; }

echo "Environment setup complete."


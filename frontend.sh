#!/bin/bash

# Install Git and Python
sudo yum install git python3 -y   # For Amazon Linux, RHEL, or CentOS

# Define the URL of the Git repository you want to clone
repo_url="https://github.com/charity-bit/Eduford"

# Directory where you want to clone the repository
repo_dir="/home/ec2-user/Eduford"

# Clone the Git repository
git clone "$repo_url" "$repo_dir"

# Change to the repository directory
cd "$repo_dir"

# Start a Python HTTP server on port 80 to serve the content
nohup python3 -m http.server 80 > /dev/null 2>&1 &
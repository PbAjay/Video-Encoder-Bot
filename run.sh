#!/bin/bash

# Load env vars from config.env
set -a
source VideoEncoder/config.env
set +a

# Run update.py and start the bot
python3 update.py && python3 -m VideoEncoder

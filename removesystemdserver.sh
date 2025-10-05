#!/bin/bash
set -e

SERVICE_NAME="rathole-server"
SERVICE_FILE="/etc/systemd/system/${SERVICE_NAME}.service"

echo "Stopping ${SERVICE_NAME} service..."
sudo systemctl stop "${SERVICE_NAME}"

echo "Disabling ${SERVICE_NAME} service..."
sudo systemctl disable "${SERVICE_NAME}"

echo "Removing systemd service file..."
sudo rm -f "${SERVICE_FILE}"

echo "Reloading systemd daemon..."
sudo systemctl daemon-reload

echo "Done."

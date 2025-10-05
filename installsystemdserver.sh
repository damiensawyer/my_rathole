#!/bin/bash
set -e

SERVICE_NAME="rathole-server"
SERVICE_FILE="/etc/systemd/system/${SERVICE_NAME}.service"
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

echo "Creating systemd service file for rathole-server..."

sudo tee "${SERVICE_FILE}" > /dev/null <<EOF
[Unit]
Description=Rathole Server Service
After=network.target

[Service]
Type=simple
User=$(whoami)
WorkingDirectory=${SCRIPT_DIR}
ExecStart=${SCRIPT_DIR}/run_server.sh
Restart=on-failure
RestartSec=5s

[Install]
WantedBy=multi-user.target
EOF

echo "Reloading systemd daemon..."
sudo systemctl daemon-reload

echo "Enabling ${SERVICE_NAME} service..."
sudo systemctl enable "${SERVICE_NAME}"

echo "Starting ${SERVICE_NAME} service..."
sudo systemctl start "${SERVICE_NAME}"

echo "Done."

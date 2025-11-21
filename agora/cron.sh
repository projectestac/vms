#!/bin/bash

SCRIPT="/dades/html/config/sync.sh"
TIMER_NAME="agora_cron"
EXEC_USER="vagrant"
INTERVAL="10min"

SERVICE_FILE="/etc/systemd/system/${TIMER_NAME}.service"
TIMER_FILE="/etc/systemd/system/${TIMER_NAME}.timer"

# Check if the script exists and is executable
if [ ! -f "$SCRIPT" ]; then
  echo "Cron: Error: Cannot find the script $SCRIPT"
  exit 1
fi

if [ ! -x "$SCRIPT" ]; then
  echo "Cron: The script is not executable. Making it executable..."
  chmod +x "$SCRIPT"
fi

echo "Cron: Creating file .service $SERVICE_FILE..."
sudo tee "$SERVICE_FILE" > /dev/null <<EOF
[Unit]
Description=Update Àgora cache file for database connections

[Service]
Type=oneshot
User=$EXEC_USER
ExecStart=$SCRIPT
EOF

echo "Cron: Creating file .timer $TIMER_FILE..."
sudo tee "$TIMER_FILE" > /dev/null <<EOF
[Unit]
Description=Execute $TIMER_NAME every ten minutes

[Timer]
OnBootSec=2min
OnUnitActiveSec=$INTERVAL
Persistent=true

[Install]
WantedBy=timers.target
EOF

echo "Cron: Reload systemd and enable the timer..."
sudo systemctl daemon-reload
sudo systemctl enable --now "${TIMER_NAME}.timer" > /dev/null 2>&1
sudo systemctl start "${TIMER_NAME}"

echo "Cron: Timer created and enabled."

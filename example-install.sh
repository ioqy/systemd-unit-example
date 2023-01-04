#!/bin/bash

# For root put unit files into /etc/systemd/system

# Service as root
sudo systemctl daemon-reload
sudo systemctl start example.service
sudo systemctl enable example.service
systemctl status example.service

# Timer as root
sudo systemctl daemon-reload
sudo systemctl enable --now example.timer
systemctl status automated-backup.timer

# List timers for root
systemctl list-timers --all

# For user put unit files into /home/user/.config/systemd/user

# Service as user
systemctl --user daemon-reload
systemctl --user start example.service
systemctl --user enable example.service
systemctl --user status example.service

# Timer as user
systemctl --user daemon-reload
systemctl --user enable --now example.timer
systemctl --user status automated-backup.timer

# List timers for user
systemctl --user list-timers --all

# Syntax check
systemd-analyze [--user] verify example.service

# Escape strings for usage in systemd mount unit names
systemd-escape mnt/example

# Calculate the next 10 elapses of a OnCalendar expression for a timer
systemd-analyze calendar --iterations=10
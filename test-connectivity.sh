#!/usr/bin/env bash
# Run this on a Linux EC2 instance after routes and security rules are configured.
# Update TARGET_IP to the private IP of the peer instance.
set -u

if [ "${1:-}" = "" ]; then
  echo "Usage: $0 <peer-private-ip>"
  exit 2
fi

TARGET_IP="$1"
echo "Testing ICMP connectivity to ${TARGET_IP}"
ping -c 4 "$TARGET_IP"
status=$?

if [ "$status" -eq 0 ]; then
  echo "Ping command completed successfully."
else
  echo "Ping failed. Check routes, security groups, network ACLs, host firewall, and instance status."
fi
exit "$status"

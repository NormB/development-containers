#!/bin/bash
set -e

echo "Container's IP address: `awk 'END{print $1}' /etc/hosts`"
IP=$(awk 'END{print $1}' /etc/hosts)

sed \
  -e "s|{log_level}|4|g" \
  -e "s|{xlog_level}|3|g" \
  -e "s|{log_stderror}|yes|g" \
  -e "s|{log_facility}|LOG_LOCAL0|g" \
  -e "s|{udp_workers}|4|g" \
  -e "s|{tcp_workers}|4|g" \
  -e "s|0.0.0.0|$IP|g" \
  -e "s|/run/opensips|/usr/local/etc/opensips|g" \
  -i /usr/local/etc/opensips/opensips.cfg

exec "$@"

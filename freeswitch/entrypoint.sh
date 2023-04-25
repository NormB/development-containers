#!/bin/bash
set -e

echo "Container's IP address: `awk 'END{print $1}' /etc/hosts`"
IP=$(awk 'END{print $1}' /etc/hosts)

if [ ! -f "/usr/local/freeswitch/freeswitch.xml" ]; then
    mkdir -p /usr/local/freeswitch
    cp -varf /usr/local/src/freeswitch/conf/vanilla/* /usr/local/freeswitch/
fi

sed \
  -e "s|{{BROKER1_HOST}}|${BROKER1_HOST}|g" \
  -e "s|{{BROKER1_USERNAME}}|${BROKER1_USERNAME}|g" \
  -e "s|{{BROKER1_PASSWORD}}|${BROKER1_PASSWORD}|g" \
  -e "s|{{BROKER2_HOST}}|${BROKER2_HOST}|g" \
  -e "s|{{BROKER2_USERNAME}}|${BROKER2_USERNAME}|g" \
  -e "s|{{BROKER2_PASSWORD}}|${BROKER2_PASSWORD}|g" \
  -i /usr/local/freeswitch/conf/autoload_configs/mosquitto.conf.xml

sed \
  -e "s|external_rtp_ip=stun:stun.freeswitch.org|external_rtp_ip=$IP|g" \
  -e "s|external_sip_ip=stun:stun.freeswitch.org|external_sip_ip=$IP|g" \
  -e "s|internal_sip_port=5060|internal_sip_port=6060|g" \
  -e "s|internal_tls_port=5061|internal_tls_port=6061|g" \
  -e "s|external_sip_port=5080|external_sip_port=6080|g" \
  -e "s|external_tls_port=5081|external_tls_port=6081|g" \
  -i /usr/local/freeswitch/conf/vars.xml

sed \
  -e "s|::|0.0.0.0|g" \
  -e "s|ClueCon|go-away!|g" \
  -i /usr/local/freeswitch/conf/autoload_configs/event_socket.conf.xml

chown -R freeswitch:freeswitch /usr/local/freeswitch

exec "$@"

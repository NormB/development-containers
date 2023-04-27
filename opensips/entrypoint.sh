#!/bin/bash
set -e

echo "Container's IP address: `awk 'END{print $1}' /etc/hosts`"
IP=$(awk 'END{print $1}' /etc/hosts)

sed \
  -e "s|{log_level}|3|g" \
  -e "s|{xlog_level}|3|g" \
  -e "s|{log_stderror}|yes|g" \
  -e "s|{log_facility}|LOG_LOCAL0|g" \
  -e "s|{udp_workers}|4|g" \
  -e "s|{tcp_workers}|4|g" \
  -e "s|0.0.0.0|$IP|g" \
  -e "s|/run/opensips|/usr/local/etc/opensips|g" \
  -i /usr/local/etc/opensips/opensips.cfg

if [[ ! -e opensips.sqlite ]]; then
  sqlite3 opensips.sqlite < /usr/local/src/opensips/scripts/sqlite/standard-create.sql
  sqlite3 opensips.sqlite < /usr/local/src/opensips/scripts/sqlite/acc-create.sql
  sqlite3 opensips.sqlite < /usr/local/src/opensips/scripts/sqlite/alias_db-create.sql
  sqlite3 opensips.sqlite < /usr/local/src/opensips/scripts/sqlite/auth_db-create.sql
  sqlite3 opensips.sqlite < /usr/local/src/opensips/scripts/sqlite/authjwt-create.sql
  sqlite3 opensips.sqlite < /usr/local/src/opensips/scripts/sqlite/avpops-create.sql
  sqlite3 opensips.sqlite < /usr/local/src/opensips/scripts/sqlite/b2b-create.sql
  sqlite3 opensips.sqlite < /usr/local/src/opensips/scripts/sqlite/b2b_sca-create.sql
  sqlite3 opensips.sqlite < /usr/local/src/opensips/scripts/sqlite/cachedb_sql-create.sql
  sqlite3 opensips.sqlite < /usr/local/src/opensips/scripts/sqlite/call_center-create.sql
  sqlite3 opensips.sqlite < /usr/local/src/opensips/scripts/sqlite/carrierroute-create.sql
  sqlite3 opensips.sqlite < /usr/local/src/opensips/scripts/sqlite/closeddial-create.sql
  sqlite3 opensips.sqlite < /usr/local/src/opensips/scripts/sqlite/clusterer-create.sql
  sqlite3 opensips.sqlite < /usr/local/src/opensips/scripts/sqlite/cpl-create.sql
  sqlite3 opensips.sqlite < /usr/local/src/opensips/scripts/sqlite/dialog-create.sql
  sqlite3 opensips.sqlite < /usr/local/src/opensips/scripts/sqlite/dialplan-create.sql
  sqlite3 opensips.sqlite < /usr/local/src/opensips/scripts/sqlite/dispatcher-create.sql
  sqlite3 opensips.sqlite < /usr/local/src/opensips/scripts/sqlite/domain-create.sql
  sqlite3 opensips.sqlite < /usr/local/src/opensips/scripts/sqlite/domainpolicy-create.sql
  sqlite3 opensips.sqlite < /usr/local/src/opensips/scripts/sqlite/drouting-create.sql
  sqlite3 opensips.sqlite < /usr/local/src/opensips/scripts/sqlite/emergency-create.sql
  sqlite3 opensips.sqlite < /usr/local/src/opensips/scripts/sqlite/fraud_detection-create.sql
  sqlite3 opensips.sqlite < /usr/local/src/opensips/scripts/sqlite/freeswitch_scripting-create.sql
  sqlite3 opensips.sqlite < /usr/local/src/opensips/scripts/sqlite/group-create.sql
  sqlite3 opensips.sqlite < /usr/local/src/opensips/scripts/sqlite/imc-create.sql
  sqlite3 opensips.sqlite < /usr/local/src/opensips/scripts/sqlite/load_balancer-create.sql
  sqlite3 opensips.sqlite < /usr/local/src/opensips/scripts/sqlite/msilo-create.sql
  sqlite3 opensips.sqlite < /usr/local/src/opensips/scripts/sqlite/permissions-create.sql
  sqlite3 opensips.sqlite < /usr/local/src/opensips/scripts/sqlite/presence-create.sql
  sqlite3 opensips.sqlite < /usr/local/src/opensips/scripts/sqlite/qrouting-create.sql
  sqlite3 opensips.sqlite < /usr/local/src/opensips/scripts/sqlite/ratecacher-create.sql
  sqlite3 opensips.sqlite < /usr/local/src/opensips/scripts/sqlite/registrant-create.sql
  sqlite3 opensips.sqlite < /usr/local/src/opensips/scripts/sqlite/rls-create.sql
  sqlite3 opensips.sqlite < /usr/local/src/opensips/scripts/sqlite/rtpengine-create.sql
  sqlite3 opensips.sqlite < /usr/local/src/opensips/scripts/sqlite/rtpproxy-create.sql
  sqlite3 opensips.sqlite < /usr/local/src/opensips/scripts/sqlite/smpp-create.sql
  sqlite3 opensips.sqlite < /usr/local/src/opensips/scripts/sqlite/speeddial-create.sql
  sqlite3 opensips.sqlite < /usr/local/src/opensips/scripts/sqlite/tcp_mgm-create.sql
  sqlite3 opensips.sqlite < /usr/local/src/opensips/scripts/sqlite/tls_mgm-create.sql
  sqlite3 opensips.sqlite < /usr/local/src/opensips/scripts/sqlite/tracer-create.sql
  sqlite3 opensips.sqlite < /usr/local/src/opensips/scripts/sqlite/userblacklist-create.sql
  sqlite3 opensips.sqlite < /usr/local/src/opensips/scripts/sqlite/usrloc-create.sql
fi

exec "$@"

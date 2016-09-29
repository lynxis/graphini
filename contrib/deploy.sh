#!/bin/sh

set -e

HOSTS=~/vcfb_16/pssh/all_hosts
PSSH_OPTS="-p 30 -l root -h $HOSTS -e pssh_err -o pssh_out"

echo "create plugins dir"
parallel-ssh $PSSH_OPTS mkdir -p /usr/lib/graphini/plugins/

echo "copy bin graphini"
parallel-scp $PSSH_OPTS ./graphini /usr/sbin/

echo "copy plugins"
parallel-scp -r $PSSH_OPTS ./plugins/* /usr/lib/graphini/plugins/

echo "configure crontab"
parallel-ssh $PSSH_OPTS sh -c "\"echo '* * * * * /usr/sbin/graphini' | crontab -u root -\""

echo "enable crontab"
parallel-ssh $PSSH_OPTS /etc/init.d/cron enable || true

echo "restart crontab"
parallel-ssh $PSSH_OPTS /etc/init.d/cron restart || true

### Vladimir Cvjetkovic
# Remove Wildfly logs older than 5 days
# Added to cron every 1st of month at 00:00

find /opt/wildfly/standalone/log* -mtime +5 -exec rm {} \;

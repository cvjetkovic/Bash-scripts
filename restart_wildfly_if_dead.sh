### Vladimir Cvjetkovic
# Restart wildfly if dead

STATUS="$(systemctl show -p ActiveState --value wildfly)"
if [ "${STATUS}" != "active" ]; then
   systemctl restart wildfly
fi

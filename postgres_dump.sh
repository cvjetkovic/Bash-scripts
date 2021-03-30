### Vladimir Cvjetkovic
# Postgres dump

now="$(date +'%d.%m.%Y_%T')"
db_name='database'
dump_location='/backups/'

pg_dump -U postgres -F p $db_name > $dump_location/$db_name'_'$now.sql

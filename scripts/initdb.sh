# wait for db to come up
control_c()
{
echo goodbye
kill -SIGINT $(jobs -p)
exit #$
}

trap control_c SIGINT

while true; do
    pg_isready -h localhost
    if [ $? -eq 0 ]; then
        break
    fi
    sleep 1 &
    wait
done

psql -h localhost -U postgres -a -f /scripts/db.sql

FROM alpine:3.7
RUN apk --no-cache add postgresql-client
COPY init_pg.sql .
CMD psql "$POSTGRES_URL" -v username="$USERNAME" -v dbname="$DBNAME" -f init_pg.sql

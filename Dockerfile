FROM alpine:3.7
RUN apk --no-cache add postgresql-client
COPY init_pg.sh .
CMD sh init_pg.sh

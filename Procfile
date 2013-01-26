postgres: postgres -D /usr/local/var/postgres
web:      bundle exec puma -p $PORT
elasticsearch: elasticsearch -f -D es.config=/usr/local/opt/elasticsearch/config/elasticsearch.yml
redis: redis-server /usr/local/etc/redis.conf
sidekiq: sidekiq -q carrierwave

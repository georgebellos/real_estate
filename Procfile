postgres: postgres -D /usr/local/var/postgres
web: bundle exec rails server puma -p $PORT -e $RACK_ENV
elasticsearch: elasticsearch -f -D es.config=/usr/local/opt/elasticsearch/config/elasticsearch.yml
redis: redis-server /usr/local/etc/redis.conf
sidekiq: bundle exec sidekiq -q carrierwave

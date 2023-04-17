# config/initializers/redis_session_store.rb

Rails.application.config.session_store :redis_store,
                                       key: '_chat_app_session',
                                       redis: { host: 'localhost', port: 6379, db: 1 },
                                       expire_after: 90.minutes

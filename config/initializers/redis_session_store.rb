# config/initializers/redis_session_store.rb

Rails.application.config.session_store :redis_store,
                                       servers: [ENV.fetch("REDIS_URL_SESSION")],
                                       expire_after: 90.minutes,
                                       key: "_#{ENV.fetch("APP_NAME")}_session"


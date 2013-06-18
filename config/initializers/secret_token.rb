Katikia::Application.config.secret_token = if Rails.env.development? || Rails.env.test?
                                             'g' * 30
                                           else
                                             ENV['SESSION_SECRET_TOKEN']
                                           end

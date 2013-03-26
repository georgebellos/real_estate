CarrierWave.configure do |config|
  config.fog_credentials = {
    provider:                'AWS',
    aws_access_key_id:       ENV['S3_ACCESS_KEY'],
    aws_secret_access_key:   ENV['S3_SECRET_ACCESS_KEY'],
    region:                  'eu-west-1'
  }

  config.fog_directory  = 'ekatikia'
end

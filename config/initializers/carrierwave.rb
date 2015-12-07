CarrierWave.configure do |config|
                         # required
  config.fog_credentials = {
    provider:              'AWS',                        # required
    aws_access_key_id:     'AKIAINFORP2S2VK6HIJQ',                        # required
    aws_secret_access_key: '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',                        # required
    region:                'us-west-2',                  # optional, defaults to 'us-east-1'
  #  host:                  's3.example.com',             # optional, defaults to nil
  #  endpoint:              'https://s3.example.com:8080' # optional, defaults to nil
  }

   config.cache_dir = "#{Rails.root}/tmp/uploads"
  config.fog_directory  = 'cearasteel'                          # required
end

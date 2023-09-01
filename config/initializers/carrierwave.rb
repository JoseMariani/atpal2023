CarrierWave.configure do |config|
  config.fog_credentials = {
      provider:              'AWS',                        # required
      aws_access_key_id:     'AKIAJCSUHP6TE4ERB7XQ',                        # required
      aws_secret_access_key: '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',    # required
      region:                'us-east-2',                  # optional, defaults to 'us-east-1'
  }
  config.fog_directory  = 'school-management-system-develop'                          # required
end
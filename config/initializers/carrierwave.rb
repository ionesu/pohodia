require 'carrierwave/storage/abstract'
require 'carrierwave/storage/file'
require 'carrierwave/storage/fog'

CarrierWave.configure do |config|
  config.storage = :fog
  config.fog_provider = 'fog/aws'
  config.fog_directory  = 'pohodia-bucket'
  config.fog_credentials = {
      provider:              'AWS',
      aws_access_key_id:     'AKIAUAERLSTIFDLHTC73',
      aws_secret_access_key: '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',
      region:                'eu-central-1'
  }
  #password = H#9GLR4ekA2^
end
require 'aws-sdk'
# Too dangerous !! save credentials in variable envirnoment in the future
Aws.config.update({
                      region: 'London',
                      credentials: Aws::Credentials.new('AKIAIQ5SK3NMZ63SWSUQ', 'ldrHxeCbQeqCyNfST3JfzK0uM0rirTX0lDFRdYMP/t'),
                  })

S3_BUCKET = Aws::S3::Resource.new.bucket('score-party')
require 'base64'
require 'securerandom'
require 'aws-sdk'
require 'net/http'
require 'uri'
require 'json'


module GlobalHelper

  ################## Facebook Graph Api ####################

  def self.get_facebook_friends(access_token)
    user_friends = URI.parse('https://graph.facebook.com/me/friends?&access_token=' + access_token.to_s)
    friends_response = Net::HTTP.get_response(user_friends)
    friends = JSON.parse(friends_response.body)
  end

  ################## Amazon web service ####################

  #split base 64 image to get information
  def self.split_base64(uri_str)
    if uri_str.match(%r{^data:(.*?);(.*?),(.*)$})
      uri = Hash.new
      uri[:type] = $1
      uri[:encoder] = $2
      uri[:data] = $3
      uri[:extension] = $1.split('/')[1]
      return uri
    else
      return nil
    end
  end

  # prepare data to upload
  def self.upload_to_s3_from_base64(base64_img, ext = 'png')
    id = SecureRandom.urlsafe_base64(nil, false)

    image_data = self.split_base64(base64_img)
    image_data_string = image_data[:data]
    image_data_binary = Base64.decode64(image_data_string)
    destination =   id + '.' + image_data[:extension]
    self.do_upload(image_data_binary, destination)
  end

  # upload file to aws
  def self.do_upload(file_content, destination)
    self.configure_client

    s3 = Aws::S3::Client.new
    resp = s3.put_object(
        :bucket => 'score-party',
        :key => destination,
        :body => file_content,
        :acl => 'public-read'
    )

    return destination
  end

  # configure_client (DANGEROUS !!!! NEVER SAVE credentials in a committed file)
  def self.configure_client
    Aws.config.update({
                          region: 'eu-west-2',
                          credentials: Aws::Credentials.new('AKIAIQ5SK3NMZ63SWSUQ', 'ldrHxeCbQeqCyNfST3JfzK0uM0rirTX0lDFRdYMP'),
                      })
  end

  # retreive image
  def self.get_s3_url(destination)
    return 'https://s3.eu-west-2.amazonaws.com/score-party/' + destination
  end

end

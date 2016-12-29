Rails.application.config.middleware.use OmniAuth::Builder do
  # too dirty id secret key are clear :S ...
  provider :facebook, '369861260034247', 'b95f00015877da31146acf962ce01640'
end
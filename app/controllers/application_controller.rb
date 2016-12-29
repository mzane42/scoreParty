class ApplicationController <  ActionController::Base
  include DeviseTokenAuth::Concerns::SetUserByToken
=begin
  protect_from_forgery with: :exception, if: Proc.new { |c| c.request.format != 'application/json' }
  protect_from_forgery with: :null_session, if: Proc.new { |c| c.request.format == 'application/json' }
=end
end
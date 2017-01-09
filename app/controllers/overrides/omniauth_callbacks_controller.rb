module Overrides
  class OmniauthCallbacksController  < DeviseTokenAuth::OmniauthCallbacksController

    # overide omniauthCallBacks to get Facebook friend !

    def omniauth_success
      get_resource_from_auth_hash
      create_token_info
      set_token_on_resource
      create_auth_params
      if resource_class.devise_modules.include?(:confirmable)
        # don't send confirmation email!!!
        @resource.skip_confirmation!
      end

      sign_in(:user, @resource, store: false, bypass: false)

      @resource.save!
      # Add friends to user
      # **** terrible code (should call method other than new and find ... later ... )****
      if @resource.provider == 'facebook'
        fb_token = @_auth_hash[:credentials][:token]
        @facebook = GlobalHelper::get_facebook_friends(fb_token)
        user = User.find_by(uid: @resource.uid)
        if user.friends.size < @facebook['data'].size
          buddy = Friend.where(:uid => @facebook['id'], :user_id => user.id).first
          if buddy.blank?
            @facebook['data'].each do |friend|
              f = User.find_by(uid: friend['id'])
              friend = Friend.new(uid: friend['id'], name: friend['name'], 	friend_id: 	f.id, user_id: user.id)
              friend.save
            end
          end
        end
      end
      # ***** end terrible code ****
      yield @resource if block_given?

      render_data_or_redirect('deliverCredentials', @auth_params.as_json, @resource.as_json)
    end

  end
end

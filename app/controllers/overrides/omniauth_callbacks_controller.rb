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
        if user.present? && @facebook.present? && user.friends.size < @facebook['data'].size
          @facebook['data'].each do |friend|
            buddy = Friend.where(:uid => friend['id'], :user_id => user.id).first
            if buddy.blank?
              f = User.find_by(uid: friend['id'])
              if f.present?
                friend = Friend.new(uid: friend['id'], name: friend['name'], 	friend_id: 	f.id, user_id: user.id)
                friend.save
              end
            end
          end
        end
      end

      # ***** end terrible code ****
      yield @resource if block_given?

      render_data_or_redirect('deliverCredentials', @auth_params.as_json, @resource.as_json)

    end

    def render_data_or_redirect(message, data, user_data = {})

      # We handle inAppBrowser and newWindow the same, but it is nice
      # to support values in case people need custom implementations for each case
      # (For example, nbrustein does not allow new users to be created if logging in with
      # an inAppBrowser)
      #
      # See app/views/devise_token_auth/omniauth_external_window.html.erb to understand
      # why we can handle these both the same.  The view is setup to handle both cases
      # at the same time.
      if ['inAppBrowser', 'newWindow'].include?(omniauth_window_type)
        render_data(message, user_data.merge(data))

      elsif auth_origin_url # default to same-window implementation, which forwards back to auth_origin_url

        # build and redirect to destination url
        redirect_to GlobalHelper::generate(auth_origin_url, data.merge(blank: true))
      else

        # there SHOULD always be an auth_origin_url, but if someone does something silly
        # like coming straight to this url or refreshing the page at the wrong time, there may not be one.
        # In that case, just render in plain text the error message if there is one or otherwise
        # a generic message.
        fallback_render data[:error] || 'An error occurred'
      end
    end



  end
end


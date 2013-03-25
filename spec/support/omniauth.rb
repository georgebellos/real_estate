module OmniAuthSpecHelpers

  def set_omniauth(provider=:twitter)
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[provider] = OmniAuth::AuthHash.new({
      :provider => 'twitter',
      :uid => '123545',
      info: { email: 'georgbellos@mail.com',
              nickname: 'georgebellos',
              name: 'George Bellos' }
    })
  end

  def set_invalid_omniauth(opts = {})
    credentials = { :provider => :twitter,
                    :invalid  => :invalid_crendentials
    }.merge(opts)

    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[credentials[:provider]] = credentials[:invalid]
  end
end

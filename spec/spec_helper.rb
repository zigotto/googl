$LOAD_PATH.unshift(File.join(File.dirname(__FILE__)))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

require "rubygems"
require "rspec"
require 'webmock/rspec'
require 'googl'

require 'shared_examples'

def load_fixture(name)
  File.new(File.join(File.expand_path(File.dirname(__FILE__)), '/fixtures', name))
end

def fake_urls?(status)

  if status
    # Shorten
    url_shorten = "https://www.googleapis.com/urlshortener/v1/url"
    params = "{\"longUrl\":\"http://www.zigotto.com\"}" #json
    stub_request(:post, url_shorten).
      with(:body => params,
           :headers => {'Content-Type'=>'application/json'}).
           to_return(load_fixture('shorten.json'))

    # Shorten Unsupported content with type
    url_shorten = "https://www.googleapis.com/urlshortener/v1/url"
    params = "{\"longUrl\":\"http://www.uol.com\"}" #json
    stub_request(:post, url_shorten).
      with(:body => params).
      to_return(load_fixture('shorten_invalid_content_type.json'))

    # Shorten with user_ip
    url_shorten = "https://www.googleapis.com/urlshortener/v1/url"
    params = "{\"longUrl\":\"http://www.zigotto.com\",\"userIp\":\"54.154.97.74\"}" #json
    stub_request(:post, url_shorten).
        with(:body => params,
             :headers => {'Content-Type'=>'application/json'}).
        to_return(load_fixture('shorten.json'))

    # Shorten with api_key
    url_shorten_with_key = "https://www.googleapis.com/urlshortener/v1/url?key=Abc123"
    params = "{\"longUrl\":\"http://www.zigotto.com\"}" #json
    stub_request(:post, url_shorten_with_key).
        with(:body => params,
             :headers => {'Content-Type'=>'application/json'}).
        to_return(load_fixture('shorten.json'))

    # Shorten with user_ip and api_key
    url_shorten_with_key = "https://www.googleapis.com/urlshortener/v1/url?key=Abc123"
    params = "{\"longUrl\":\"http://www.zigotto.com\",\"userIp\":\"54.154.97.74\"}" #json
    stub_request(:post, url_shorten_with_key).
        with(:body => params,
             :headers => {'Content-Type'=>'application/json'}).
        to_return(load_fixture('shorten.json'))

    # Expand
    url_expand = "https://www.googleapis.com/urlshortener/v1/url?shortUrl=http://goo.gl/7lob"
    stub_request(:get, url_expand).to_return(load_fixture('expand.json'))

    # Expand with projection FULL
    url_expand = "https://www.googleapis.com/urlshortener/v1/url?projection=full&shortUrl=http://goo.gl/DWDfi"
    stub_request(:get, url_expand).to_return(load_fixture('expand_projection_full.json'))

    # Expand with projection ANALYTICS_CLICKS
    url_expand = "https://www.googleapis.com/urlshortener/v1/url?projection=analytics_clicks&shortUrl=http://goo.gl/DWDfi"
    stub_request(:get, url_expand).to_return(load_fixture('expand_projection_clicks.json'))

    # Expand with projection ANALYTICS_TOP_STRINGS
    url_expand = "https://www.googleapis.com/urlshortener/v1/url?projection=analytics_top_strings&shortUrl=http://goo.gl/DWDfi"
    stub_request(:get, url_expand).to_return(load_fixture('expand_projection_strings.json'))

    # Expand error 404
    url_expand = "https://www.googleapis.com/urlshortener/v1/url?shortUrl=http://goo.gl/blajjddkksijj"
    stub_request(:get, url_expand).to_return(load_fixture('expand_404.json'))

    # Expand REMOVED
    url_expand = "https://www.googleapis.com/urlshortener/v1/url?shortUrl=http://goo.gl/R7f68"
    stub_request(:get, url_expand).to_return(load_fixture('expand_removed.json'))

    # Authentication
    url_login = "https://www.google.com/accounts/ClientLogin"

    # ClientLogin valid
    stub_request(:post, url_login).
       with(:body => {"accountType"=>"HOSTED_OR_GOOGLE", "service"=>"urlshortener", "Email"=>"my_user@gmail.com", "source"=>"gem-googl-ruby", "Passwd"=>"my_valid_password"},
            :headers => {'Content-Type'=>'application/x-www-form-urlencoded'}).
            to_return(load_fixture('client_login_valid.json'))

    # ClientLogin invalid
    stub_request(:post, url_login).
       with(:body => {"Email"=>"my_invalid_gmail", "Passwd"=>"my_invalid_passwod", "source"=>"gem-googl-ruby", "service"=>"urlshortener", "accountType"=>"HOSTED_OR_GOOGLE"},
            :headers => {'Authorization'=>'GoogleLogin auth=DQAAAK8AAAC9ahL-o7g', 'Content-Type'=>'application/x-www-form-urlencoded'}).
       to_return(load_fixture('client_login_invalid.json'))

    # Shorten authenticated
    params = "{\"longUrl\":\"http://www.zigotto.net\"}"
    stub_request(:post, url_shorten).
      with(:body => params, 
           :headers => {'Authorization'=>'GoogleLogin auth=DQAAAK8AAAC9ahL-o7g', 'Content-Type'=>'application/json'}).
           to_return(load_fixture('shorten_authenticated.json'))

    # History for ClientLogin
    stub_request(:get, "https://www.googleapis.com/urlshortener/v1/url/history").
      with(:headers => {'Authorization'=>'GoogleLogin auth=DQAAAK8AAAC9ahL-o7g'}).
      to_return(load_fixture('history.json'))

    # History with projection ANALYTICS_CLICKS
    stub_request(:get, "https://www.googleapis.com/urlshortener/v1/url/history?projection=analytics_clicks").
      with(:headers => {'Authorization'=>'GoogleLogin auth=DQAAAK8AAAC9ahL-o7g'}).
      to_return(load_fixture('history_projection_clicks.json'))

    # OAuth 2.0 for native applications
    stub_request(:post, "https://accounts.google.com/o/oauth2/token").
      with(:body => "code=4/SuSud6RqPojUXsPpeh-wSVCwnmTQ&client_id=185706845724.apps.googleusercontent.com&client_secret=DrBLCdCQ3gOybHrj7TPz/B0N&redirect_uri=urn:ietf:wg:oauth:2.0:oob&grant_type=authorization_code", 
           :headers => {'Content-Type'=>'application/x-www-form-urlencoded'}).
           to_return(load_fixture('oauth2/native.json'))    
    
    # OAuth 2.0 for native applications (invalid token)
    stub_request(:post, "https://accounts.google.com/o/oauth2/token").
      with(:body => "code=my_invalid_code&client_id=185706845724.apps.googleusercontent.com&client_secret=DrBLCdCQ3gOybHrj7TPz/B0N&redirect_uri=urn:ietf:wg:oauth:2.0:oob&grant_type=authorization_code", 
           :headers => {'Content-Type'=>'application/x-www-form-urlencoded'}).
           to_return(load_fixture('oauth2/native_invalid.json'))

    # OAuth 2.0 for native applications (expired token)
    stub_request(:post, "https://accounts.google.com/o/oauth2/token").
      with(:body => "code=4/JvkEhCtr7tv1A60ENmubQT-cosRl&client_id=185706845724.apps.googleusercontent.com&client_secret=DrBLCdCQ3gOybHrj7TPz/B0N&redirect_uri=urn:ietf:wg:oauth:2.0:oob&grant_type=authorization_code", 
           :headers => {'Content-Type'=>'application/x-www-form-urlencoded'}).
           to_return(load_fixture('oauth2/native_token_expires.json'))

    # OAuth 2.0 for native applications (history)
    stub_request(:get, "https://www.googleapis.com/urlshortener/v1/url/history").
       with(:headers => {'Authorization'=>'OAuth 1/YCzoGAYT8XUuOifjNh_KqA', 'Content-Type'=>'application/x-www-form-urlencoded'}).
      to_return(load_fixture('history.json'))

    # OAuth 2.0 for server-side web applications
    stub_request(:post, "https://accounts.google.com/o/oauth2/token").
      with(:body => "code=4/z43CZpNmqd0IO3dR1Y_ouase13CH&client_id=438834493660.apps.googleusercontent.com&client_secret=8i4iJJkFTukWhNpxTU1b2Zhi&redirect_uri=http://gooogl.heroku.com/back&grant_type=authorization_code", 
           :headers => {'Content-Type'=>'application/x-www-form-urlencoded'}).
           to_return(load_fixture('oauth2/server.json'))

    # OAuth 2.0 for server-side web applications (invalid token)
    stub_request(:post, "https://accounts.google.com/o/oauth2/token").
      with(:body => "code=my_invalid_code&client_id=438834493660.apps.googleusercontent.com&client_secret=8i4iJJkFTukWhNpxTU1b2Zhi&redirect_uri=http://gooogl.heroku.com/back&grant_type=authorization_code", 
           :headers => {'Content-Type'=>'application/x-www-form-urlencoded'}).
           to_return(load_fixture('oauth2/server_invalid.json'))

    # OAuth 2.0 for server-side web applications (expired token)
    stub_request(:post, "https://accounts.google.com/o/oauth2/token").
      with(:body => "code=4/JvkEhCtr7tv1A60ENmubQT-cosRl&client_id=438834493660.apps.googleusercontent.com&client_secret=8i4iJJkFTukWhNpxTU1b2Zhi&redirect_uri=http://gooogl.heroku.com/back&grant_type=authorization_code", 
           :headers => {'Content-Type'=>'application/x-www-form-urlencoded'}).
           to_return(load_fixture('oauth2/server_token_expires.json'))    

    # OAuth 2.0 for server-side web applications (history)
    stub_request(:get, "https://www.googleapis.com/urlshortener/v1/url/history").
      with(:headers => {'Authorization'=>'OAuth 1/9eNgoHDXi-1u1fDzZ2wLLGATiaQZnWPB51nTvo8n9Sw'}).
      to_return(load_fixture('history.json'))

  else
    WebMock.allow_net_connect!
  end

end

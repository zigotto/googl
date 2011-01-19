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

def fake_urls

  # Shorten
  url_shorten = "https://www.googleapis.com/urlshortener/v1/url"
  params = {"longUrl" => "http://www.zigotto.com"}.inspect
  stub_request(:post, url_shorten).
    with(:body => params,
         :headers => {'Content-Type'=>'application/json'}).
         to_return(load_fixture('shorten.json'))

  # Shorten Unsupported content with type
  url_shorten = "https://www.googleapis.com/urlshortener/v1/url"
  params = {"longUrl" => "http://www.uol.com"}.inspect
  stub_request(:post, url_shorten).
    with(:body => params).
         to_return(load_fixture('shorten_invalid_content_type.json'))

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
  params = "Passwd=my_valid_password&service=urlshortener&accountType=HOSTED_OR_GOOGLE&Email=my_user%40gmail.com&source=gem-googl-ruby"
  stub_request(:post, url_login).
    with(:body => params,
         :headers => {'Content-Type'=>'application/x-www-form-urlencoded'}).
         to_return(load_fixture('client_login_valid.json'))

  # ClientLogin invalid
  params = "Passwd=my_invalid_passwod&service=urlshortener&accountType=HOSTED_OR_GOOGLE&Email=my_invalid_gmail&source=gem-googl-ruby"
  stub_request(:post, url_login).with(:body => params).to_return(load_fixture('client_login_invalid.json'))

  # Shorten authenticated
  params = {"longUrl" => "http://www.zigotto.net"}.inspect
  stub_request(:post, url_shorten).
    with(:body => params, 
         :headers => {'Authorization'=>'GoogleLogin auth=DQAAAK8AAAC9ahL-o7g', 'Content-Type'=>'application/json'}).
         to_return(load_fixture('shorten_authenticated.json'))

  # History
  stub_request(:get, "https://www.googleapis.com/urlshortener/v1/url/history").
    with(:headers => {'Authorization'=>'GoogleLogin auth=DQAAAK8AAAC9ahL-o7g'}).
         to_return(load_fixture('history.json'))

  # History with projection ANALYTICS_CLICKS
  stub_request(:get, "https://www.googleapis.com/urlshortener/v1/url/history?projection=analytics_clicks").
    with(:headers => {'Authorization'=>'GoogleLogin auth=DQAAAK8AAAC9ahL-o7g'}).
         to_return(load_fixture('history_projection_clicks.json'))

end

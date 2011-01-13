$LOAD_PATH.unshift(File.join(File.dirname(__FILE__)))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

require "rubygems"
require "rspec"
require 'webmock/rspec'
require 'googl'

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

  # Expand
  url_expand = "https://www.googleapis.com/urlshortener/v1/url?shortUrl=http://goo.gl/7lob"
  stub_request(:get, url_expand).to_return(load_fixture('expand.json'))

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

end

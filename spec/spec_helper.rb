require "rubygems"
require "rspec"
require 'fakeweb'

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__)))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

require 'googl'

def load_fixture(name)
  File.join(File.expand_path(File.dirname(__FILE__)), '/fixtures', name)
end

def fake_urls

  FakeWeb.allow_net_connect = false

  # Shorten
  url = "https://www.googleapis.com/urlshortener/v1/url"
  options = {"longUrl" => "http://www.zigotto.com"}.inspect
  FakeWeb.register_uri(:post, url, :response => load_fixture('shorten.json'), :body => options)

  # Expand
  url = "https://www.googleapis.com/urlshortener/v1/url?shortUrl=http://goo.gl/7lob"
  FakeWeb.register_uri(:get, url, :response => load_fixture('expand.json'))

end

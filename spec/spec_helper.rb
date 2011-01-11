require "rubygems"
require "rspec"
require 'fakeweb'

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__)))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

require 'googl'

def load_fixture(name)
  File.join(File.expand_path(File.dirname(__FILE__)), '/fixtures', name)
end

def fake_web(url, fixture, status=200)
  FakeWeb.register_uri(:any, url, :body => load_fixture(fixture), :status => status)
end

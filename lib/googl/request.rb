class Request
  include HTTParty
  base_uri 'https://www.googleapis.com'
  headers 'Content-Type' => 'application/json'
  headers "Content-length" => "0"
end

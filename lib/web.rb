require 'nokogiri'
require 'open-uri'

class WebTest
  attr_reader :url, :uri
  def initialize(url)
    @url = url
    @uri = URI.open(url)
  end
  def reset_uri
    @uri = URI.open(url)
  end
  def set_params(params)
    @uri.query = URI.encode_www_form(params)
  end
  def get
    url = @uri.to_s
    charset = nil

    html = open(url) do |f|
      charset = f.charset
      f.read
    end

    Nokogiri::HTML.parse(html, nil, charset)
  end
end

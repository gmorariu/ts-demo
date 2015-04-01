# encoding: UTF-8
require 'json'
require 'net/smtp'
require 'oauth'
require 'nokogiri'

get '/' do
  uri = Addressable::URI.parse(request.url)
  uri.scheme = settings.scheme
  result = {
    :links => { 
      :get_register => uri.site + settings.prefix + uri.path + 'register',
      :get_admin => uri.site + settings.prefix + uri.path + 'admin',
      :get_client => uri.site + settings.prefix + uri.path + 'client',
    }
  }
  result.to_json
end



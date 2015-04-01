# encoding: UTF-8

require 'sinatra/base'
require 'bcrypt'

module Sinatra
  module ParentURI
    def parent_uri
      uri = Addressable::URI.parse(request.url)
      uri.scheme = settings.scheme
      url = uri.site + settings.prefix + uri.path
      url[0..-(uri.basename.length + 2)]
    end
  end
  helpers ParentURI
end

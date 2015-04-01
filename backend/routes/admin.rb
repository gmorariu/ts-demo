# encoding: UTF-8

enable :sessions

get '/admin' do
  content_type :json
  uri = Addressable::URI.parse(request.url)
  uri.scheme = settings.scheme
  links = {
    :links => { 
      :get_users => uri.site + settings.prefix + uri.path + '/users',
      :get_trips => uri.site + settings.prefix + uri.path + '/trips',
      :parent => parent_uri,
    }
  }.to_json
end

get '/admin/trips' do
  content_type :json
  include_docs = params[:include_docs]
  rows = Array.new
  uri = Addressable::URI.parse(request.url)
  uri.scheme = settings.scheme
  Trip.all.each do |trip|
    if include_docs
      rows << trip
    else
      rows << uri.site + settings.prefix + uri.path + '/' + trip.id.to_s
    end
  end
  
  result = {
    :rows => rows, 
    :links => { 
      :parent => parent_uri,
    }
  }
  result.to_json
end

get '/admin/trips/:id' do
  content_type :json
  
  trip = Trip.get(params[:id])
  if trip.nil?
    halt 404, "Not found\n"
  end
  uri = Addressable::URI.parse(request.url)
  uri.scheme = settings.scheme
  links = {
    :links => { 
      :parent => parent_uri,
    }
  }
  trip.attributes.merge(links).to_json
end

delete '/admin/trips/:id' do
  content_type :json
  
  trip = Trip.get(params[:id])
  if trip.nil?
    halt 404, "Not found\n"
  end
  trip.destroy
  uri = Addressable::URI.parse(request.url)
  uri.scheme = settings.scheme
  links = {
    :links => { 
      :parent => parent_uri,
    }
  }.to_json
end

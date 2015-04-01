# encoding: UTF-8

require 'json'

enable :sessions

get '/register' do
  uri = Addressable::URI.parse(request.url)
  uri.scheme = settings.scheme
  result = {
    :links => { 
      :post_client => uri.site + settings.prefix + uri.path + '/client',
      :post_lawyer => uri.site + settings.prefix + uri.path + '/host',
      :parent => parent_uri,
    }
  }
  result.to_json
end

post '/register/client' do
  uri = Addressable::URI.parse(request.url)
  uri.scheme = settings.scheme
  status 201
  {:links => { :client => uri.site + settings.prefix + '/client'}}.to_json
end

get '/client' do
  uri = Addressable::URI.parse(request.url)
  uri.scheme = settings.scheme
  {:links => { :post_trips => uri.site + settings.prefix + uri.path + '/trips'}}.to_json
end

post '/client/trips' do
  content_type :json
  body = JSON.parse(request.body.read)
  
  uri = Addressable::URI.parse(request.url)
  uri.scheme = settings.scheme
    
  #The user_id will be determined from the session - for now a random mock
  user_id = Random.rand(10) + 1
  
  Trip.raise_on_save_failure = true   
  trip = Trip.create(
    :destination_country         =>   body['destination_country'],
    :destination_city            =>   body['destination_city'],
    :destination_prefered_date   =>   body['destination_prefered_date'],
    :destination_alternate_dates =>   body['destination_alternate_dates'],
    :guests_number               =>   body['guests_number'],
    :guests_number_drinking      =>   body['guests_number_drinking'],
    :type                        =>   body['type'],
    :pefered_time                =>   body['pefered_time'],
    :restrictions                =>   body['restrictions'],
    :spice                       =>   body['spice'],
    :user_id                     =>   user_id
  )
  
  if trip.nil?
    halt 500
  end
  
  status 201
  {:links => { :trip => uri.site + settings.prefix + '/trips/' + trip.id.to_s}}.to_json
end


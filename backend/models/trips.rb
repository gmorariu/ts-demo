# encoding: UTF-8
class Trip
  include DataMapper::Resource
  property :id,                          Serial
  property :destination_country,         String, :required => true
  property :destination_city,            String, :required => true
  property :destination_prefered_date,   String, :required => true
  property :destination_alternate_dates, String, :length => 250
  property :guests_number,               Integer, :default => 1, :required => true
  property :guests_number_drinking,      Integer, :default => 0, :required => true
  property :type,                        Enum[:meal, :cooking_class, :tour], :default => :meal
  property :pefered_time,                Enum[:lunch, :dinner]
  property :restrictions,                String, :length => 250
  property :spice,                       Enum[:mild, :medium, :hot], :required => true, :default => :mild
    
  property :created_at,                  DateTime
  #This will be a FK once the Users table is created
  property :user_id,                     Integer
end 

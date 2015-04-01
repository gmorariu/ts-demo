require 'sinatra'
require 'json'
require 'data_mapper'
require 'dm-core'
require 'dm-geokit'
require 'dm-mysql-adapter'
require 'dm-migrations'
require 'dm-timestamps'
require 'addressable/uri'
require 'uri'
require 'carrierwave'
require 'carrierwave/datamapper'
#require 'RMagick'
require 'geocoder'
require 'scrypt'
require 'securerandom'

require './config'

require './models/init'
DataMapper.finalize

require './helpers/init'
require './routes/init'






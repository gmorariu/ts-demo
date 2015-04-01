configure do
  DataMapper.setup(
    :default,
    'mysql://<username>:<password>@<ip_address>:<port>/ts'
  )
end

enable :sessions
set :session_secret, '<secret>'

set :prefix, '/api'
set :scheme, 'http'
  

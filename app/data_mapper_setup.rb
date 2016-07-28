require 'data_mapper'
require 'dm-postgres-adapter'

require_relative 'models/tag.rb'
require_relative 'models/link.rb'
require_relative 'models/user.rb'


#Database connection setup
DataMapper.setup(:default, ENV['DATABASE_URL'] || "postgres://localhost/bookmark_manager_#{ENV['RACK_ENV']}")

#verification
DataMapper.finalize

#build new columns/tables
DataMapper.auto_upgrade!

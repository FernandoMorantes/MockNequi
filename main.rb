require 'rubygems'
require 'bundler/setup'
require 'mysql2'
require 'digest'
require_relative 'DB/DBOperator'
require_relative 'Models/account'
require_relative 'Models/goal'
require_relative 'Models/mattress'
require_relative 'Models/pocket'
require_relative 'Models/user'
require_relative 'App/menu_option'
require_relative 'App/menusUI'
require_relative 'App/mock_nequi'
require_relative 'App/session'
require_relative 'App/user_Input'
require_relative 'App/user_menu'

mock_nequi = MockNequi.new
mock_nequi.run

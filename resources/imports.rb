require 'rubygems'
require 'bundler/setup'
require 'mysql2'
require 'digest'
require 'io/console'
require 'date'
require_relative 'console_print'
require_relative '../DB/DBOperator'
require_relative '../Models/account'
require_relative '../Models/goal'
require_relative '../Models/mattress'
require_relative '../Models/pocket'
require_relative '../Models/user'
require_relative '../App/menu_option'
require_relative '../App/menus_ui'
require_relative '../App/mock_nequi'
require_relative '../App/session'
require_relative '../App/user_input'
require_relative '../App/user_menu'
require_relative '../controller/account_controller'
require_relative '../controller/goal_controller'
require_relative '../controller/mattress_controller'
require_relative '../controller/pocket_controller'
require_relative '../controller/transaction_controller'
require_relative '../views/account_form'
require_relative '../views/goal_form'
require_relative '../views/mattress_form'
require_relative '../views/pocket_form'
require_relative '../views/transaction_view'
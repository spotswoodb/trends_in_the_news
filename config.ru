require './config/environment'


use Rack::MethodOverride
use ArticlesController
use UsersController
run ApplicationController

require './config/environment'


use Rack::MethodOverride
use ArticlesController
use CommentsController
use UsersController
run ApplicationController

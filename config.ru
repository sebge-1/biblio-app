require './config/environment'

use Rack::MethodOverride
use UsersController
run ApplicationController
use BooksController
use BooknotesController

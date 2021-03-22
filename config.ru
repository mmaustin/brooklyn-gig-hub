require './config/environment'

use Rack::MethodOverride
use PlayersController
use GigsController
use UsersController
run ApplicationController

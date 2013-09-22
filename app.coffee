coffeescript = require('connect-coffee-script')
lessCompiler = require('less-middleware')
jadeCompiler = require('connect-jade-html')
express      = require('express')
http         = require('http')
path         = require('path')

app = express()

# all environments
app.set 'port', process.env.PORT or 3000
app.set 'views', __dirname + '/views'
app.set 'view engine', 'jade'

app.use express.favicon()
app.use express.logger('dev')
app.use express.bodyParser()
app.use app.router

# compile Jade and Coffee files from the src directory, exposing under public_cache/lib
app.use '/lib', coffeescript
  src: __dirname + '/src'
  dest: __dirname + '/public_cache/lib'
  bare: true

app.use '/lib', jadeCompiler
  src: __dirname + '/src'
  dest: __dirname + '/public_cache/lib'

# compile LESS files from public/css
app.use '/css', lessCompiler
  src: __dirname + '/public/css'
  dest: __dirname + '/public_cache/css'

app.use express.static(path.join(__dirname, 'public'))
app.use express.static(path.join(__dirname, 'public_cache'))

# development only
app.use express.errorHandler()  if app.get('env') is 'development'

app.get '/', (req, res) ->
  res.render "index"

server = http.createServer(app)
server.listen app.get('port')

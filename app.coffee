
###
Module dependencies.
###
express = require("express")
routes = require("./routes/index")
http = require("http")
path = require("path")
app = express()

# all environments
app.set "port", process.env.PORT or 3000
app.set "views", path.join(__dirname, "views")
app.set "view engine", "jade"
app.use express.favicon()
app.use express.logger("dev")
app.use express.json()
app.use express.urlencoded()
app.use express.methodOverride()
app.use express.cookieParser("your secret here")
app.use express.session()
app.use app.router
app.use require("stylus").middleware(path.join(__dirname, "public"))
app.use(express.compress())
app.use express.static(path.join(__dirname, "public"))

# development only
app.use express.errorHandler() if "development" is app.get("env")


# one of these need to be in front
app.post "/createForm", routes.create_form
app.post "/submitVote", routes.submit_vote

app.get "/results/:url_id", routes.render_results
app.get "/result/:url_id", routes.render_results

app.post "/polls/submitVote", routes.submit_vote
app.post "/poll/submitVote", routes.submit_vote

app.all "/polls/:url_id", routes.render_poll
app.all "/poll/:url_id", routes.render_poll
#app.get "/polls/:url_id/:poll_question", routes.render_poll
#app.get "/poll/:url_id/:poll_question", (req, res, next) -> next()

app.get "/", routes.index

http.createServer(app).listen app.get("port"), ->
  console.log "Express server listening on port " + app.get("port")


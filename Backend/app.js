const express = require('express')
const app = express()
const userRouter = require('./src/router/user/user.router')
const bodyParser = require('body-parser')
const cookieParser = require('cookie-parser')
const messageRouter = require('./src/router/message/message.router')
const postRouter = require('./src/router/post/post.router')
const tymRouter = require('./src/router/tym/tym.router')
const authRouter = require('./src/router/auth/auth.router')
const cors = require("cors");
const passport = require('passport')
require('./src/auth/passport.auth')
require('./src/utils/sendOTP').transporter


app.use(
  cors({
    origin: "http://localhost:55228",
    credentials: true,
    exposedHeaders: ["Access-Control-Allow-Origin"],
  })
);


const PORT_SOCKET = 2000
const PORT_SERVER = 2001

app.use(bodyParser.urlencoded({ extended: false }))
// parse application/json
app.use(bodyParser.json())
app.use('./src/public', express.static('./src/public'))
app.use(express.static('./src/public'));

var server = require('http').createServer(app);
var io = require('socket.io')(server);

server.listen(PORT_SOCKET, () => {
  console.log('socket io connected ' + PORT_SOCKET);
});
var consumer = require('./src/server/socket.server');
const session = require('express-session')
consumer.start(io);

app.use(bodyParser.json())
app.use(bodyParser.urlencoded({ extended: false }))
app.use(express.urlencoded({ extended: true }))
app.listen(PORT_SERVER, () => {
  console.log('server listen at port: ' + PORT_SERVER);
})

app.use(session({secret: 'cat'}))
app.use(passport.initialize())
app.use(passport.session())

app.use(cookieParser())
app.use('/user', userRouter)
app.use('/messages', messageRouter)
app.use('/post', postRouter)
app.use('/tym', tymRouter)
app.use('/auth', authRouter)




const express = require('express')
const app = express()
const userRouter = require('./src/router/user/user.router')
const bodyParser = require('body-parser')
const cookieParser = require('cookie-parser')
const messageRouter = require('./src/router/message/message.router')
const postRouter = require('./src/router/post/post.router')
const path = require('path')
app.use(bodyParser.urlencoded({ extended: false }))
// parse application/json
app.use(bodyParser.json())
app.use('./src/public', express.static('./src/public'))
app.use(express.static('./src/public'));

var server = require('http').createServer(app);
var io = require('socket.io')(server);

server.listen(3001, () => {
     console.log('socket io connected 3001');
});
var consumer = require('./src/server/socket.server');
consumer.start(io);

app.use(bodyParser.json())
app.use(bodyParser.urlencoded({ extended: false }))
app.use(express.urlencoded({ extended: true }))
app.listen(3000, () => {
     console.log('server listen at port: 3000');
})

app.use(cookieParser())
app.use('/user', userRouter)
app.use('/messages', messageRouter)
app.use('/post', postRouter)


const express = require('express')
const app = express()
const userRouter = require('./src/router/user/user.router')
const bodyParser = require('body-parser')
const cookieParser = require('cookie-parser')
const courseRouter = require('./src/router/course/course.router')
const messageRouter = require('./src/router/message/message.router')


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
app.use('/course', courseRouter)
app.use('/messages', messageRouter)


const { insertMessage } = require("../controller/sockets/message.socket.controller");

var users = [];
module.exports = {
     start: function (io) {
          io.on('connection', socket => {
               const { id } = socket
               users.push({
                    id: socket.id
               })

               console.log(`online: `, users);

               socket.on('messageFromClient', (data) => {
                    const message =
                    {
                         idUserSend: data.idUserSend,
                         idUserGet: data.idUserGet,
                         message: data.message,
                    }
                    console.log(message);
                    // insertMessage(message)
                    // socket.broadcast.emit("messageFromServer", data)
                    console.log(JSON.stringify(data));
                    io.to(socket.id).emit('messageFromServer', data)
               })
               socket.on('disconnect', () => {
                    users = users.filter(e => {
                         return e.id != id
                    })
                    console.log(`online: `, users);
               })
          });
     }
}
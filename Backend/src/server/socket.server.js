const { insertMessage } = require("../controller/sockets/message.socket.controller");

var users = [];
module.exports = {
     start: function (io) {
          io.on('connection', socket => {
               const { id } = socket
               const idDbUser = socket.handshake.query.myId;
               console.log("MYID: ", idDbUser);
               if(idDbUser != 0){
                    users.push({
                         idSocket: socket.id,
                         idDb: idDbUser
                    })
               }
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
                    console.log(data.idUserGet);
                    // users.find
                    
                    // io.to(socket.id).emit('messageFromServer', data)

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
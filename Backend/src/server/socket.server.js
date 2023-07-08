const { insertMessage } = require("../controller/sockets/message.socket.controller");

var users = [];
module.exports = {
     start: function (io) {
          io.on('connection', socket => {
               const { id } = socket
               const idDbUser = socket.handshake.query.myId;
               console.log("user connected: ", id);

               let isAxist = false;
               users.forEach(e => {
                    if(e.idDb == idDbUser){
                         e.idSocket = id
                         isAxist = true;
                    }
               })
               if (idDbUser != 0 && isAxist == false) {
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
                    const idTarget = users.find(obj => {
                         return obj.idDb == data.idUserGet;
                    });
                    console.log("idTarget: ",idTarget);
                    if (idTarget) {
                         console.log("send to: ", idTarget.idSocket);
                         console.log("data", JSON.stringify(data));
                         io.to(idTarget.idSocket).emit('messageFromServer', data)
                    }
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
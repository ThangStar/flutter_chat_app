const { insertMessage, getMessagesById } = require("../controller/sockets/message.socket.controller");

var users = [];
module.exports = {
     start: function (io) {
          io.on('connection', socket => {
               const { id } = socket
               const idDbUser = socket.handshake.query.myId;
               console.log("user connected: ", id);

               let isAxist = false;
               users.forEach(e => {
                    if (e.idDb == idDbUser) {
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


               //when client open chat screen => server send data chat to client
               //1: client on messages 
               //2: client emit requestMessagesFromClient
               //3: server get data message from Db and emit messages to client
               //4: client has data and fill to UI

               socket.on('requestMessagesFromClient', data => {
                    console.log(data);
                    getMessagesById(data, (rs) => {
                         console.log("DATA", rs);
                         io.to(id).emit('messages', rs)
                    })
               })

               socket.on('messageFromClient', (data) => {

                    console.log("data send", data);
                    const message =
                    {
                         idUserSend: data.idUserSend,
                         idUserGet: data.idUserGet,
                         message: data.message,
                    }
                    insertMessage(message)
                    // socket.broadcast.emit("messageFromServer", data)
                    const idTarget = users.find(obj => {
                         return obj.idDb == data.idUserGet;
                    });
                    console.log("idTarget: ", idTarget);
                    if (idTarget) {
                         console.log("send to: ", idTarget.idSocket);
                         io.to(idTarget.idSocket).emit('messageFromServer', data)
                    }
               })

               socket.on('imageFromClient', data => {
                    console.log("data from client: " + data);
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
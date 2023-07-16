const conn = require("../../API/mySql.api");
const { getMessagesByIdQuery } = require("../../utils/queryCommand");

const insertMessage = ({ idUserSend, idUserGet, message, dateTime } = message) => {
     const queryString = `INSERT INTO MESSAGES (idUserSend, idUserGet, message) VALUES (?, ?, ?)`
     console.log("queryString: ", queryString);

     conn.query(queryString, [idUserSend, idUserGet, message], (err, rs, field) => {
          if (err) {
               console.log('failure');
          } else {
               console.log('success');

          }
     })
}

const insertImage = (req, res) => {

}

const getMessagesById = (data, callback = Function(response)) => {
     const { idUserSend, idUserGet } = data

     console.log("idUserSend - idUserGet", idUserSend, idUserGet);
     try {
          
          conn.query(getMessagesByIdQuery, [idUserSend, idUserGet, idUserSend, idUserGet], (err, rs, field) => {
               if (err) {
                    callback(err)
               } else {
                    callback(rs)
               }
          })
     } catch (error) {
          console.log("error request message by id", error);
          callback(error)

     }
}

module.exports = {
     insertMessage,
     getMessagesById
}
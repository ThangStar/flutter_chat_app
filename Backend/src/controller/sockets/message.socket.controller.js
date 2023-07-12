const conn = require("../../API/mySql.api");

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

module.exports = {
     insertMessage,

}
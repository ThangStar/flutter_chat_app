module.exports = {
     messageOfUser: 'SELECT messages.id, message, users.username, messages.dateTime FROM messages INNER JOIN users on' +
          ' messages.idUserSend = users.id WHERE messages.idUserSend = ? OR messages.idUserGet = ?'
}
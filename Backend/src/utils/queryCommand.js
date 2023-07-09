module.exports = {
     messageOfUser: 'SELECT users.id, users.username, messages.message, messages.dateTime ' +
          'FROM users JOIN messages on messages.idUserSend = users.id OR messages.idUserGet = users.id  WHERE messages.idUserSend = ? OR messages.idUserGet = ? GROUP by users.id',
     addAPost: 'INSERT INTO posts(idUser, title, content) VALUES (?,?,?)'
}
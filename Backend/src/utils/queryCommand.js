module.exports = {
     messageOfUser: 'SELECT users.avatar, users.id, users.username, messages.message, messages.dateTime ' +
          'FROM users JOIN messages on messages.idUserSend = users.id OR messages.idUserGet = users.id  WHERE messages.idUserSend = ? OR messages.idUserGet = ? GROUP by users.id',
     addAPost: 'INSERT INTO posts(idUser, title, content) VALUES (?,?,?)',
     getAllPost: 'SELECT users.id, posts.title, posts.content, posts.dateTime, users.username FROM posts JOIN users ON users.id = posts.idUser ORDER BY posts.dateTime DESC',
}
module.exports = {
     messageOfUser: 'SELECT users.avatar, users.id, users.username, messages.message, messages.dateTime ' +
          'FROM users JOIN messages on messages.idUserSend = users.id OR messages.idUserGet = users.id  WHERE messages.idUserSend = ? OR messages.idUserGet = ? GROUP by users.id',
     addAPost: 'INSERT INTO posts(idUser, title, content, style_color) VALUES (?,?,?,?)',
     getAllPost: 'SELECT posts.id AS "id_post", users.id, posts.title, posts.content, posts.dateTime, posts.style_color, users.username FROM posts JOIN users ON users.id = posts.idUser ORDER BY posts.dateTime DESC LIMIT ?, ?',
     getTymByIdPostCommand: 'SELECT * FROM DETAIL_TYM WHERE IDPOST = ?',
     getMessagesByIdQuery: "SELECT * FROM messages WHERE idUserSend = ? AND idUserGet = ? OR idUserGet = ? AND idUserSend = ?",
     searchUserMyUsernameQuery: "SELECT * FROM USERS WHERE users.username LIKE ?"
}
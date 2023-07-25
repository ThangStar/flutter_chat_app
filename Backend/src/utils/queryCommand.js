module.exports = {
     messageOfUser: 'SELECT users.avatar, users.id, users.username, messages.message, messages.dateTime ' +
          'FROM users JOIN messages on messages.idUserSend = users.id OR messages.idUserGet = users.id  WHERE messages.idUserSend = ? OR messages.idUserGet = ? GROUP by users.id',
     addAPost: 'INSERT INTO posts(idUser, title, content, style_color) VALUES (?,?,?,?)',
     getAllPost: `
     SELECT COUNT(detail_tym.idUser) as "total_tym",
     posts.id AS "id_post", 
     users.id,
     posts.title,
     posts.content,
     posts.dateTime,
     posts.style_color,
     users.username 
     FROM posts 
     JOIN users ON users.id = posts.idUser
     LEFT JOIN detail_tym ON detail_tym.idPost = posts.id
     GROUP BY  posts.id, detail_tym.idPost
     ORDER BY posts.dateTime DESC
     LIMIT ?,?`,
     getTymByIdPostCommand: 'SELECT * FROM DETAIL_TYM WHERE IDPOST = ?',
     getMessagesByIdQuery: "SELECT * FROM messages WHERE idUserSend = ? AND idUserGet = ? OR idUserGet = ? AND idUserSend = ?",
     searchUserMyUsernameQuery: "SELECT * FROM USERS WHERE users.username LIKE ?",
     incrementTymQuery: "INSERT INTO detail_tym(idUser,idPost) VALUES (?,?)",
     tymPostQuery: "INSERT INTO `detail_tym`(`idUser`, `idPost`) VALUES (?,?)",
}

// SELECT detail_tym.idUser as "total_like",
// posts.id AS "id_post",
// users.id,
// posts.title,
// posts.content,
// posts.dateTime,
// posts.style_color,
// users.username
// FROM posts
// JOIN users ON users.id = posts.idUser
// LEFT JOIN detail_tym ON detail_tym.idPost = posts.id
// ORDER BY posts.dateTime DESC
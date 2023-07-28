module.exports = {
     messageOfUser: 'SELECT users.avatar, users.id, users.username, users.fullname as full_name, messages.message, messages.dateTime ' +
          'FROM users JOIN messages on messages.idUserSend = users.id OR messages.idUserGet = users.id  WHERE messages.idUserSend = ? OR messages.idUserGet = ? GROUP by users.id',
     addAPost: 'INSERT INTO posts(idUser, title, content, style_color) VALUES (?,?,?,?)',
     getAllPost: `
     SELECT COUNT(detail_tym.idUser) as "total_tym",
     (
          SELECT COUNT(*) FROM comments WHERE posts.id = comments.idPost
     ) total_comment,
     GROUP_CONCAT(users.avatar) avatar_liked,
     posts.id AS "id_post", 
     users.id,
     users.avatar,
     posts.title,
     posts.content,
     posts.dateTime,
     posts.style_color,
     users.fullname as full_name,
     users.username,
     
     CASE WHEN EXISTS (SELECT 1 FROM detail_tym 
          WHERE detail_tym.idPost = posts.id 
          AND detail_tym.idUser = ?) 
          THEN 'true'  ELSE 'false'  	
     END AS isLiked 
     FROM posts 
     JOIN users ON users.id = posts.idUser
     LEFT JOIN detail_tym ON detail_tym.idPost = posts.id
     GROUP BY  posts.id, detail_tym.idPost
     ORDER BY posts.dateTime DESC
     LIMIT ?, ?`,
     getMessagesByIdQuery: "SELECT * FROM messages WHERE idUserSend = ? AND idUserGet = ? OR idUserGet = ? AND idUserSend = ?",
     searchUserMyUsernameQuery: "SELECT users.fullname as full_name, username, id, password, avatar FROM USERS WHERE users.fullname LIKE ?",
     incrementTymQuery: "INSERT INTO detail_tym(idUser,idPost) VALUES (?,?)",
     tymPostQuery: "INSERT INTO `detail_tym`(`idUser`, `idPost`) VALUES (?,?)",
     getCountTymByIdPostQuery: 'SELECT COUNT(detail_tym.idPost) as `count` FROM `detail_tym` WHERE idPost = ?',
     unMyTymByIdUserAndIdPostQuery: 'DELETE FROM `detail_tym` WHERE idUser = ? AND idPost = ?',
     getIsLiked: 'SELECT detail_tym.idUser, detail_tym.idPost  FROM detail_tym WHERE detail_tym.idUser = ?',
     getCommentByIdPost:
          `SELECT comments.id, users.username,  
          users.fullname as full_name,
          users.avatar, content, dateTime,
          IF(idUser = ?, "true", "false") my_comment,
          users.id as "idUser" FROM comments 
          JOIN users 
          ON idUser = users.id 
          WHERE idPost = ?
          ORDER BY comments.dateTime DESC`,
     insertCommentQuery: `INSERT INTO comments
     (idUser, idPost, content) 
     VALUES (?, ?, ?)`,
     deleteCommentQuery: 'DELETE FROM `comments` WHERE id = ?',

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
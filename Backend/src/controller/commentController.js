const conn = require("../API/mySql.api");
const toJson = require("../utils/ToJson");

const { getCommentByIdPost, insertCommentQuery, deleteCommentQuery } = require("../utils/queryCommand");

const getByidPost = (req, res) => {
     try {
          const {idUser, idPost } = req.query
          console.log(idPost);
          conn.query(getCommentByIdPost, [idUser, idPost], (err, rs, field) => {
               err ? res.send(toJson({
                    result: 'error request comment'
               })).status(400)
                    :
                    res.send(toJson(rs)).status(200)
          })
     } catch (error) {
          res.send(toJson({
               result: 'error request comment'
          })).status(400)
     }
}

const insert = (req, res) => {
     var response = []
     try {
     const { idUser, idPost, content } = req.body
          conn.beginTransaction(err => {
               if (err) conn.rollback()
               else
                    conn.query(insertCommentQuery, [idUser, idPost, content], (err, rs, field) => {
                         if (err) return conn.rollback()

                    })
               conn.query(getCommentByIdPost, [idUser, idPost], (err, rs, field) => {
                    if (err) return conn.rollback()
                    else response = rs
               })

               conn.commit(err => {
                    if (err) return conn.rollback()
                    else return res.send(toJson(response)).status(200)
               })
          })
          console.log(req.body);

     } catch (error) {
          console.log(error);
          res.send(toJson({
               result: 'error insert comment'
          })).status(400)
     }
}

const deleteOne = (req, res) => {
     var response = []
     try {
          const {idUser, idPost, idComment } = req.body
          console.log(req.body);
          conn.beginTransaction(err => {
               if (err) conn.rollback()
               else
                    conn.query(deleteCommentQuery, [idComment], (err, rs, field) => {
                         if (err) return conn.rollback()

                    })
               conn.query(getCommentByIdPost, [idUser, idPost], (err, rs, field) => {
                    if (err) return conn.rollback()
                    else response = rs
               })

               conn.commit(err => {
                    if (err) return conn.rollback()
                    else return res.send(toJson(response)).status(200)
               })
          })

     } catch (error) {
          console.log(error);
          res.send(toJson({
               result: 'error delete comment'
          })).status(400)
     }
}

module.exports = { getByidPost, insert, deleteOne }
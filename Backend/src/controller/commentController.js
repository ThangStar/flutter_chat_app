const conn = require("../API/mySql.api");
const toJson = require("../utils/ToJson");

const { getCommentByIdPost } = require("../utils/queryCommand");

const getByidPost = (req, res) => {
     try {
          const { idPost } = req.query
          console.log(idPost);
          conn.query(getCommentByIdPost, [idPost], (err, rs, field) => {
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

module.exports = { getByidPost }
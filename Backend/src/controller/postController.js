const conn = require("../API/mySql.api");
const toJson = require("../utils/ToJson");
const { addAPost, getAllPost } = require("../utils/queryCommand");

const addPost = async (req, res) => {
     const title = await req.body.title
     const content = await req.body.content
     const idUser = await req.body.idUser
     conn.query(addAPost, [idUser, title, content], (err, rs, field) => {
          if (err) {
               res.status(400)
               res.send(toJson({
                    status: 'ERROR'
               }))
          } else {
               res.status(200)
               res.send(toJson(rs))
          }
     })
}

const getPostById = (req, res) => {
     conn.query(getAllPost, (err, rs, field) => {
          if(err){
               res.status(400)
               res.send(toJson({
                    result: 'error'
               }))
          }else{
               res.status(200)
               res.send(toJson(rs))
          }
     })
}

module.exports = { addPost, getPostById }
const conn = require("../API/mySql.api");
const toJson = require("../utils/ToJson");
const { addAPost } = require("../utils/queryCommand");

const addPost =  async(req, res) => {
     const title = await req.body.title
     const content = await req.body.content
     const idUser = await req.body.idUser
     conn.query(addAPost, [idUser, title, content], (err, rs, field) => {
          if(err){
               res.status(400)
               res.send(toJson({
                    status
               }))
          }else{
               res.status(200)
               res.send(toJson(rs))
          }
     })
}

module.exports = { addPost }
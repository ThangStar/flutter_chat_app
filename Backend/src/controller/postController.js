const conn = require("../API/mySql.api");
const toJson = require("../utils/ToJson");
const NodeCache = require("node-cache");

const { addAPost, getAllPost, getTymByIdPostCommand } = require("../utils/queryCommand");
const {myCache, KEY_CACHE} = require("../utils/nodeCache");


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
          if (err) {
               res.status(400)
               res.send(toJson({
                    result: 'error'
               }))
          } else {
               res.status(200)
               res.send(toJson(rs))
          }
     })
}

const getTymByIdPost = (req, res) => {
     const cache = myCache.get(KEY_CACHE.TYM_POST)
     if (cache) {
          console.log('data from CACHE');
          res.send(cache)
     } else {
          const idPost = req.query.idPost
          console.log(idPost);
          conn.query(getTymByIdPostCommand, [idPost], (err, rs, field) => {
               if (err) {

               } else {
                    myCache.set(KEY_CACHE.TYM_POST, JSON.stringify(rs))
                    res.send(JSON.stringify(rs))
                    console.log('data from DB');
               }
          })
     }
}

module.exports = { addPost, getPostById, getTymByIdPost }
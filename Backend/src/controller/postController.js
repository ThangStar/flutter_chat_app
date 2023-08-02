const conn = require("../API/mySql.api");
const toJson = require("../utils/ToJson");
const NodeCache = require("node-cache");

const { addAPost, getAllPost, getTymByIdPostCommand, tymPostQuery } = require("../utils/queryCommand");
const { myCache, KEY_CACHE } = require("../utils/nodeCache");
const pathCache = require("../storage/cache.storage");


const addPost = async (req, res) => {
     const { title, content, idUser, style_color } = req.body
     console.log("POST VALUE", req.body);
     const images = req.files.map(e => e.filename).join(',')
     conn.query(addAPost, [idUser, title, images, content, style_color], (err, rs, field) => {
          if (err) {
     res.status(400).send(toJson({
          status: 'ERROR'
     }))
          } else {
               res.status(200).send(toJson(rs))
          }
     })
}

const getPostById = (req, res) => {
     try {
          console.log(req.originalUrl);
          console.log(req.query);
          const { idUser } = req.query
          const _page = Number(req.query._page) || 0
          const _perpage = Number(req.query._perpage) || 10
          var cache = myCache.get(pathCache.PostData)
          const cacheParams = myCache.get(pathCache.PostUrl)

          if (cache != undefined && cacheParams == req.originalUrl) {
               console.log('data from cache');
               res.status(200)
               res.send(cache)
          } else {
               myCache.set(pathCache.PostUrl, req.originalUrl)
               console.log('data from DB');
               conn.query(getAllPost, [idUser, _page, _perpage], (err, rs, field) => {
                    err ?
                         res.json(err)
                         :
                         myCache.set(pathCache.PostData, toJson(rs))
                    res.status(200)
                    res.send(JSON.stringify(rs))
               })
          }
     } catch (error) {
          res.status(400)
          res.json(error)
          console.log(error);
     }

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
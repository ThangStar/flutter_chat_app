const conn = require("../API/mySql.api");
const toJson = require("../utils/ToJson");
const NodeCache = require("node-cache");

const { addAPost, getAllPost, getTymByIdPostCommand, tymPostQuery } = require("../utils/queryCommand");
const { myCache, KEY_CACHE } = require("../utils/nodeCache");
const pathCache = require("../storage/cache.storage");


const addPost = async (req, res) => {
     const { title, content, idUser, style_color } = req.body
     console.log("POST VALUE", req.body);
     conn.query(addAPost, [idUser, title, content, style_color], (err, rs, field) => {
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
     console.log(req.originalUrl);
     try {
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
               conn.query(getAllPost, [_page, _perpage], (err, rs, field) => {
                    err ?
                         res.json(err)
                         :
                         myCache.set(pathCache.PostData, toJson(rs))
                    res.status(200)
                    console.log("RS");
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

const addTymPost = (req, res) => {
     try {
          const { idUser, idPost } = req.query
          var response = []

          conn.beginTransaction((err) => {
               err ?
                    res.send(toJson({
                         result: 'error tym post'
                    })).status(400)
                    :
                    //step1: insert tym
                    conn.query(tymPostQuery, [idUser, idPost], (err, rs, fields) => {
                         if (err) {
                              return conn.rollback(() => {
                                   res.send(toJson({
                                        result: 'error tym post'
                                   })).status(400)
                              })
                         }
                    })
               //step2: get tym by id post
               conn.query(getTymByIdPostCommand, [idPost], (err, rs, field) => {
                    if (err) {
                         conn.rollback(() => {
                              res.send(toJson({
                                   result: 'error get tym post'
                              })).status(400)
                         })
                    } else {
                         response = rs
                    }
               })
               conn.commit((err) => {
                    if (err) {
                         res.send(toJson({
                              result: 'error get tym post'
                         })).status(400)
                    } else {
                         res.send(toJson(response))
                    }
               })
          })

     } catch (error) {

     }


}

module.exports = { addPost, getPostById, getTymByIdPost, addTymPost }
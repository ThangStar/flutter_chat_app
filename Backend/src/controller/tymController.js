const conn = require("../API/mySql.api")
const toJson = require("../utils/ToJson")
const { tymPostQuery, getTymByIdPostCommand, getCountTymByIdPostQuery, unMyTymByIdUserAndIdPostQuery } = require("../utils/queryCommand")
const incTym = (req, res) => {
     try {
          const { idUser, idPost } = req.query
          console.log(req.query);
          var response = []

          conn.beginTransaction((err) => {
               err ?
                    console.log('err')
                    :
                    //step1: insert tym
                    conn.query(tymPostQuery, [idUser, idPost], (err, rs, fields) => {
                         if (err) {
                              return conn.rollback(() => {
                                   //  res.send(toJson({
                                   //      result: 'error tym post'
                                   // })).status(400)
                              })
                         }
                    })
               //step2: get tym by id post
               conn.query(getCountTymByIdPostQuery, [idPost], (err, rs, field) => {
                    if (err) {
                         return conn.rollback(() => {
                              //  res.send(toJson({
                              //      result: 'error tym post'
                              // })).status(400)
                         })
                    } else {
                         response = rs
                    }
               })
               conn.commit((err) => {
                    if (err) {
                         return conn.rollback(() => {
                              console.log("ERRRRRRRRORRRRRRRRRRR", err);
                              // res.send(toJson({
                              //      result: 'error get tym post'
                              // })).status(400)
                         })
                    }
                    console.log("finish");
                    return res.send(toJson(response))
               })
          })

     } catch (error) {
          conn.rollback()
          res.send(toJson({
               result: 'error'
          })).status(400)
     }
}

const decTym =(req, res) => {
     try {
          const { idUser, idPost } = req.body
          console.log(req.body);
          var response = []

          conn.beginTransaction((err) => {
               err ?
                    console.log('err')
                    :
                    //step1: insert tym
                    conn.query(unMyTymByIdUserAndIdPostQuery, [idUser, idPost], (err, rs, fields) => {
                         if (err) {
                              return conn.rollback(() => {
                                   //  res.send(toJson({
                                   //      result: 'error tym post'
                                   // })).status(400)
                              })
                         }
                    })
               //step2: get tym by id post
               conn.query(getCountTymByIdPostQuery, [idPost], (err, rs, field) => {
                    if (err) {
                         return conn.rollback(() => {
                              //  res.send(toJson({
                              //      result: 'error tym post'
                              // })).status(400)
                         })
                    } else {
                         response = rs
                    }
               })
               conn.commit((err) => {
                    if (err) {
                         return conn.rollback(() => {
                              console.log("ERRRRRRRRORRRRRRRRRRR", err);
                              // res.send(toJson({
                              //      result: 'error get tym post'
                              // })).status(400)
                         })
                    }
                    console.log("finish");
                    return res.send(toJson(response))
               })
          })

     } catch (error) {
          console.log(error);
          conn.rollback()
          res.send(toJson({
               result: 'error'
          })).status(400)
     }
}

module.exports = { incTym, decTym }
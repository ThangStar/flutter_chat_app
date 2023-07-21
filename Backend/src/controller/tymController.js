const conn = require("../API/mySql.api")
const toJson = require("../utils/ToJson")
const { incrementTymQuery } = require("../utils/queryCommand")

const incrementTym = (req, res) => {

     const body = req.body
     console.log(body);
     conn.query(incrementTymQuery, [req.body.idUser, req.body.idPost], (err, rs, field) => {
          err ? res.send(toJson({
               result: 'error increment tym',
               error: rs
          })).status(400)
          :
          res.send(toJson(rs)).status(200)
     })
}

module.exports = { incrementTym }
const conn = require("../API/mySql.api");
const toJson = require("../utils/ToJson");
const { messageOfUser } = require('../utils/queryCommand')
const getMessageOfUser = (req, res) => {
     console.log(req.query.myId);
     conn.query(messageOfUser, [req.query.myId, req.query.myId], (err, rs, field) => {
          err ?
               res.send('error')
               :    
               res.status(200)
          res.send(toJson(rs))
     })
}
module.exports = { getMessageOfUser }
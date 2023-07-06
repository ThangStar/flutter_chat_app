const router = require('express').Router()
const conn = require('../../API/mySql.api')
router.get('/course', (req, res) => {
     conn.query('SELECT * FROM word', (err, rs, fields)=> {
          err ? 
          res.send([])
          :
          res.send(rs)

     })
})

module.exports = router
const toJson = require("../../utils/ToJson");
const conn = require("../API/mySql.api")


const getAllUser = (req, res) => {
     const page = parseInt(req.query._page);
     const perpage = parseInt(req.query._perpage);

     const queryString = `SELECT * FROM USER LIMIT ${perpage * page - perpage}, ${perpage}`
     console.log("queryString: ", queryString);

     if (page && perpage) {
          conn.query(queryString, (err, rs, field) => {
               res.send(rs)
          })
     } else {
          conn.query('SELECT * FROM USER', (err, rs, field) => {
               res.send(rs)
          })
     }
}

const getUserById = (req, res) => {
     res.send(req.params.id)
}
const addUser = (req, res) => {
     const username = req.query.username;
     const password = req.query.password;

     const queryString = `INSERT INTO USERS (username, password) VALUES (?, ?)`
     if (username.length > 5 && username.length < 12) {
          conn.query(queryString, [username, password], (err, rs, field) => {
               if (err) {
                    res.send(toJson({
                         status: false
                    }))
               } else {
                    res.send(toJson({
                         status: true
                    }))
               }
          })
     } else {
          res.status(400)
          res.send(toJson(
               {
                    status: false,
                    message: 'username or password require > 5 and < 12 char'
               }
          ))
     }

}
const login = (req, res) => {
     const username = req.query.username;
     const password = req.query.password;

     const queryString = `SELECT * FROM USERS WHERE USERNAME = ? AND PASSWORD = ?`
     conn.query(queryString, [username, password], (err, rs, field) => {
          if (err) {
               res.send(toJson({
                    status: false,
                    message: 'login failure err '+err.message
               }))
          } else {
               console.log(rs);
               if(rs.length === 1){
                    res.status(200)
                    res.send(toJson({
                         status: true,
                         message: 'login success',
                         profile: rs[0]
                    }))
               }else {
                    res.send(toJson({
                         status: false,
                         message: 'wrong username or password!'
                    }))
               }
          }
     })
}

const userController = { getAllUser, getUserById, addUser, login }
module.exports = userController
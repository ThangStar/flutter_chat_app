const toJson = require("./../utils/ToJson");
const conn = require("../API/mySql.api");
const upload = require("../utils/upload");
const { searchUserMyUsernameQuery, updateAvatarQuery } = require("../utils/queryCommand");


const getAllUser = (req, res) => {
     const page = parseInt(req.query._page);
     const perpage = parseInt(req.query._perpage);

     const queryString = `SELECT * FROM USERS LIMIT ${perpage * page - perpage}, ${perpage}`
     console.log("queryString: ", queryString);

     if (page && perpage) {
          conn.query(queryString, (err, rs, field) => {
               res.send(rs)
          })
     } else {
          conn.query('SELECT * FROM USERS', (err, rs, field) => {
               console.log(err);
               res.send(toJson(rs))
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
     const username = req.body.username;
     const password = req.body.password;
     console.log('query login: ', req.body);
     const queryString = `SELECT username, password, id, avatar, fullname as full_name FROM USERS WHERE USERNAME = ? AND PASSWORD = ?`
     conn.query(queryString, [username, password], (err, rs, field) => {
          if (err) {
               res.send(toJson({
                    status: false,
                    message: 'login failure err ' + err.message
               }))
          } else {
               if (rs.length === 1) {
                    res.status(200)
                    res.send(toJson({
                         status: true,
                         message: 'login success',
                         profile: rs[0]
                    }))
               } else {
                    res.status(400)
                    res.send(toJson({
                         status: false,
                         message: 'wrong username or password!'
                    }))
               }
          }
     })
}

const uploadAvatar = (req, res) => {
     try {
          const { idUser } = req.body
          console.log(req.file.filename);
          console.log(req.body);
          if (req.file.filename && idUser) {
               conn.query(updateAvatarQuery, [req.file.filename, idUser], (err, rs, field) => {
                    err ? res.status(400).send(toJson({
                         results: "error update avatar"
                    })) : res.status(200).send(toJson({
                         results: [{
                              avatar: req.file.filename
                         }]  
                    })); console.log(rs);
               })
          }
     } catch (error) {

     }
}

const searchByUsername = (req, res) => {
     const query = req.query.query

     console.log('query', query);

     conn.query(searchUserMyUsernameQuery, [`%${query}%`], (err, rs, field) => {
          err ?
               res.send(toJson({
                    "result": rs
               })).status(400)
               :
               res.send(toJson(rs)).status(200)
     })
}
module.exports = { getAllUser, getUserById, addUser, login, uploadAvatar, searchByUsername }
const mysql = require('mysql')



const conn = mysql.createConnection({
     host: 'localhost',
     user: 'root',
     password: '',
     database: 'social_app'
})
conn.connect((err)=> {
     err ? console.log('error: ',err) : console.log('connect success!');;
})
module.exports = conn
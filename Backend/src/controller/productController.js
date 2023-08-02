const conn = require("../API/mySql.api");
const toJson = require("../utils/ToJson");
const insert = (req, res) => {
     try {
          const { name, price, amount, category, size, colors, isOnline } = req.body
          const images = req.files.map(e => e.filename);
          conn.query(`INSERT INTO products(name, price, amount, category,
                    size, image, colors, isOnline)VALUES(?,?,?,?,?,?,?,?)`,
               [name, price, amount, category, size, images.join(','), colors, isOnline], (err, rs, field) => {
                    if (err) {
                         res.status(400).send(toJson({
                              result: "error add product" + err
                         }))
                         console.log(err);
                    }
                    else res.send(toJson(rs)).status(200)
               })
     } catch (error) {
          console.log('error add product');
     }
}

const getAll = (req, res) => {
     console.log('aaaaaaaa');
     try {
          conn.query(`SELECT * FROM products`,
               (err, rs, field) => {
                    if (err) {
                         res.status(400).send(toJson({
                              result: "error add product" + err
                         }))
                         console.log(err);
                    }
                    else res.status(200).send(toJson(rs))
               })
     } catch (error) {

     }
}
module.exports = { insert, getAll }
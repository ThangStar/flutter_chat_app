const express = require('express')
const router = express.Router()
const { getAllUser, getUserById, addUser, login } = require('../../controller/userController')


router.get('/', getAllUser)
router.get('/getId/:id', getUserById)
router.post('/add', addUser)
router.post('/login', login) 


module.exports = router
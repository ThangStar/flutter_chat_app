const express = require('express')
const router = express.Router()
const userController = require('../../controller/userController')

const { getAllUser, getUserById, addUser, login } = userController

router.get('/', getAllUser)
router.get('/getId/:id', getUserById)
router.post('/add', addUser)
router.post('/login', login) 


module.exports = router
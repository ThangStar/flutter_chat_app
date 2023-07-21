const express = require('express')
const router = express.Router()
const { getAllUser, getUserById, addUser, login, uploadAvatar, searchByUsername } = require('../../controller/userController')
const {uploadFile} = require('../../utils/upload')


router.get('/', getAllUser)
router.get('/getId/:id', getUserById)
router.post('/add', addUser)
router.post('/login', login) 
router.post('/avatar', uploadFile, uploadAvatar) 
router.get('/search', searchByUsername)
 

module.exports = router
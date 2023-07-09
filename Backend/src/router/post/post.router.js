const express = require('express')
const { addPost } = require('../../controller/postController')
const router = express.Router()

router.post('/add', addPost)

module.exports = router
const express = require('express')
const { getByidPost } = require('../../controller/commentController')
const router = express.Router()

router.get('/', getByidPost)
// router.post('/add', addPost)


module.exports = router
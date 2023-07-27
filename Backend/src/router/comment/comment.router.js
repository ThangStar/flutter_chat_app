const express = require('express')
const { getByidPost, insert } = require('../../controller/commentController')
const router = express.Router()

router.get('/', getByidPost)
router.post('/add', insert)


module.exports = router
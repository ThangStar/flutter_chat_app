const express = require('express')
const { getByidPost, insert, deleteOne } = require('../../controller/commentController')
const router = express.Router()

router.get('/', getByidPost)
router.post('/add', insert)
router.post('/deleteOne', deleteOne)


module.exports = router
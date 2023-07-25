const express = require('express')
const { addPost, getPostById , getTymByIdPost, addTymPost} = require('../../controller/postController')
const router = express.Router()

router.post('/add', addPost)
router.get('/', getPostById)
router.get('/tym', getTymByIdPost)
router.get('/tym/add', addTymPost)



module.exports = router
const express = require('express')
const { addPost, getPostById , getTymByIdPost} = require('../../controller/postController')
const router = express.Router()

router.post('/add', addPost)
router.get('/', getPostById)
router.get('/tym', getTymByIdPost)



module.exports = router
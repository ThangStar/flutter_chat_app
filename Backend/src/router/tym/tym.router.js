const express = require('express')
const { addPost, getPostById , getTymByIdPost} = require('../../controller/postController')
const { incrementTym } = require('../../controller/tymController')
const router = express.Router()

router.post('/increment', incrementTym)


module.exports = router
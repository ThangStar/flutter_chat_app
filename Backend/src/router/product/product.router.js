const express = require('express')
const { uploadMultiImage } = require('../../utils/uploadMultiImage')
const { insert, getAll } = require('../../controller/productController')
const router = express.Router()

router.get('/', getAll)
router.post('/add', uploadMultiImage, insert)

module.exports = router
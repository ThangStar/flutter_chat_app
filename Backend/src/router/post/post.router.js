const express = require('express')
const { addPost, getPostById, getTymByIdPost, deleteById,update } = require('../../controller/postController')
const router = express.Router()
const { uploadMultiImage } = require('../../utils/uploadMultiImage')

const checkHasFile = (req, res, next) => {
     if (req.files) {
          uploadMultiImage(req, res)
     } else {
          next()
     }
}
router.post('/add', uploadMultiImage, addPost)
router.get('/', getPostById)
router.post('/delete', deleteById);
router.post('/update', uploadMultiImage, update);


module.exports = router
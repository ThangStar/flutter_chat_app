const express = require('express')
const router = express.Router()
const { getMessageOfUser } = require('../../controller/messageController')

router.get('/messageOfUser', getMessageOfUser)


module.exports = router
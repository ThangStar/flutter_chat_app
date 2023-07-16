const express = require('express')
const router = express.Router()
const { getMessageOfUser, getMessageBroadCast } = require('../../controller/messageController')

router.get('/messageOfUser', getMessageOfUser)

module.exports = router
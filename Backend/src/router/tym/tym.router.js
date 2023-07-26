const express = require('express')
const { incTym, decTym } = require('../../controller/tymController')
const router = express.Router()

router.get('/inc', incTym)
router.post('/dec', decTym)
// router.get('/pre', PreController)

module.exports = router
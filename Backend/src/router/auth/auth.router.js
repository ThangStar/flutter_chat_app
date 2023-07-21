const express = require('express')
const { loginSuccess, loginError } = require('../../controller/auth/loginGooleController')
const passport = require('../../auth/passport.auth')
const { sendOTP } = require('../../utils/sendOTP')

const router = express.Router()

const isLogin = (req, res, next) => {
     req.user ? next() : res.status(401).send('bạn chưa đăng nhập')
}

const sendOTPMiddle = (req, res, next) => {
     const otpRandom = Math.floor(100000 + Math.random() * 900000)
     sendOTP('quocthinh84264@gmail.com', otpRandom)
     next()
}
router.get('/login', passport.authenticate('google', {
     scope:
          ['email', 'profile']
}))
router.get('/google/callback', passport.authenticate('google', {
     successRedirect: '/auth/google/protected',
     failureRedirect: '/auth/google/failure'
}))
router.get('/google/failure', loginError)
router.get('/google/protected', isLogin, loginSuccess)

router.get('/password/change', sendOTPMiddle, (req, res)=> {
     res.send('email đã được gửi đi')
})

module.exports = router
const passport = require('../../auth/passport.auth')

const loginSuccess = (req, res) => {
     console.log(req.user);
     res.send(`
     <img src=${req.user.photos[0].value}></img>
     </br> Chào ${req.user.displayName} </br> Email: ${req.user.emails[0].value}`)
}

const loginError = (req, res) => {
     res.send("LOGIN ERROR")


}
module.exports = {loginSuccess, loginError}
var nodemailer = require('nodemailer');
require('dotenv').config()
var transporter = nodemailer.createTransport({
	service: 'gmail',
	host: 'localhost:2001',
	port: 2001,
	auth: {
		user: process.env.EMAIL_SEND_OTP,			//email ID
		pass: process.env.PASSWORD_SEND_OTP,				//Password 
	}
});

function sendOTP(to, otp) {
	var details = {
		from: process.env.EMAIL_SEND_OTP, // sender address same as above
		to: to, 					// Receiver's email id
		subject: 'Đổi mật khẩu', // Subject of the mail.
		html: `<p>${otp} là mã OTP đổi mật khẩu của bạn</p>`
	};


	transporter.sendMail(details, function (error, data) {
		if (error)
			console.log(error)
		else
			console.log(data);
	});
}

module.exports = {transporter, sendOTP}


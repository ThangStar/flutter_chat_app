const multer = require("multer");

const storage = multer.diskStorage({
     destination: function (req, file, cb) {
          const folder = "./src/public/images";
          cb(null, folder);
     },
     filename: function (req, file, cb) {
          const uniqueSuffix = Date.now() + '-' + Math.round(Math.random() * 1E9)
          const typeFile = file.originalname.split('.')
          console.log(file);
          cb(null, file.fieldname + '-' + uniqueSuffix + '.' + typeFile[typeFile.length - 1]);
     },
});

var upload = multer({ storage: storage });
module.exports = upload.single("avatar");

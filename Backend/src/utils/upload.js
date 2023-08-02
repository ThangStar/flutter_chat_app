const multer = require("multer");
const fs = require("fs");
function deleteFile(file, callBack) {
     return new Promise((resolve, reject) => {
          fs.unlink(file, callBack
          )
     })
}

const storage = multer.diskStorage({
     destination: function (req, file, cb) {
          const folder = "./src/public/images";
          cb(null, folder);
     },
     filename: function (req, file, cb) {
          const uniqueSuffix = Date.now() + '-' + Math.round(Math.random() * 1E9)
          const typeFile = file.originalname.split('.')
          const fileName = file.fieldname + '-' + uniqueSuffix + '.' + typeFile[typeFile.length - 1]
          cb(null, fileName);
     },
});


var multerFilter = (req, file, cb) => {
     try {
          cb(null, true);
     } catch (error) {
          cb(new Error('Type require is jpg, gif, png'), false);
     }
};

var upload = multer({
     limits: {
          fieldSize: 544.288
     },
     storage: storage, fileFilter: multerFilter,

}).single("avatar");

const uploadFile = async function (req, res, next) {
     upload(req, res, async function (err) {
          if (err) {
               return res.end("Error uploading file." + err);
          }
          try {
               next()
          } catch (error) {
               res.end("its not image");

          }
     });
};



module.exports = { uploadFile }

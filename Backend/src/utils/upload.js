const multer = require("multer");
var sizeOf = require('image-size');
const path = require("path");
const fs = require("fs");
const resizeImage = require("./resizePicture");
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
          console.log(file);
          const fileName = file.fieldname + '-' + uniqueSuffix + '.' + typeFile[typeFile.length - 1]
          console.log('file name', fileName);
          cb(null, fileName);
     },
});


var multerFilter = (req, file, cb) => {
     const memeT = file.mimetype.split('/')[1];
     const restrictToMemeType = ['jpg', 'png', 'gif'];

     if (restrictToMemeType.includes(memeT)) {
          cb(null, true);
     } else {
          console.log("error upload");
          cb(new Error('sorry invalid meme type'), false);
     }
};

var upload = multer({
     limits: {
          fieldSize: 524.288
     },
     storage: storage, fileFilter: multerFilter,

}).single("avatar");

const uploadFile = function (req, res) {
     upload(req, res, async function (err) {
          if (err) {
               return res.end("Error uploading file." + err);
          }
          try {
               var dimensions = sizeOf('./src/public/images/' + res.req.file.filename);
               const filePath = path.join(__dirname, "../public/images", res.req.file.filename);
               if (dimensions.width < 50) {
                    try {
                         console.log("path: ", filePath);
                         await deleteFile(filePath, () => {
                              res.end("width file require > 50 px")
                         })
                         res.end("width file require > 50 px")

                    } catch (error) {
                         console.log('error delete', err);
                    }
                    await resizeImage(filePath, () => {
                         res.end("File is uploaded");
                    })
                    res.end("width file require > 50 px")
               }
               res.end("File is uploaded");
          } catch (error) {
               console.log("err any", error);
          }
     });
};



module.exports = uploadFile

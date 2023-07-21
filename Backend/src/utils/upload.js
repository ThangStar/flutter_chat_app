const multer = require("multer");
var sizeOf = require('image-size');
const path = require("path");
const fs = require("fs");
const resizeImage = require("./resizePicture");
const changeQuality = require("./changeQuality");
const checkIsImage = require("./checkIsImage");
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
          const currentType = file.mimetype.split('/')[1];
          const typeRequire = ['jpg', 'png', 'gif'];

          if (typeRequire.includes(currentType)) {

               //check is image

               cb(null, true);
          } else {
               console.log("error type file");
               cb(new Error('Type require is jpg, gif, png'), false);
          }
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

const uploadFile = async function (req, res) {
     upload(req, res, async function (err) {
          if (err) {
               return res.end("Error uploading file." + err);
          }
          try {
               var dimensions = sizeOf('./src/public/images/' + res.req.file.filename);
               const filePath = path.join(__dirname, "../public/images", res.req.file.filename);
               var waterMarkPath = path.join(__dirname, "../public/images/water_mark.png");

               if (dimensions.width < 50) {
                    try {
                         console.log("path: ", filePath);
                         await deleteFile(filePath, () => {
                              res.end("width file require > 50 px")
                         })
                    } catch (error) {
                         console.log('error delete', err);
                    }
                    res.end("width file require > 50 px")

               }

               //resizeImage
               await resizeImage(filePath, res, () => deleteFile(filePath, () => {
                    res.end("error delete")
               }), waterMarkPath)

               // change quality
               // await changeQuality(filePath, res, () => deleteFile(filePath, () => {
               //      res.end("error delete")
               // }))
               res.end("File is uploaded");
          } catch (error) {
               res.end("its not image");

          }
     });
};



module.exports = {uploadFile}

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
          const fileName = file.fieldname + '-' + uniqueSuffix + '.' + typeFile[typeFile.length - 1]
          cb(null, fileName);
     },
});


var multerFilter = (req, file, cb) => {
     try {
          console.log(file);
          //check is image
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

}).array("images");

const uploadMultiImage = async function (req, res, next) {
     upload(req, res, async function (err) {
          console.log("req.files", req.files);
          if (err) {
               return res.end("Error uploading file." + err);
          }
          try {
               var dimensions = sizeOf('./src/public/images/' + req.files[0].filename);
               const filePath = path.join(__dirname, "../public/images", req.files[0].filename);
               var waterMarkPath = path.join(__dirname, "../public/images/water_mark.png");

               // if (dimensions.width < 50) {
               //      try {
               //           console.log("path: ", filePath);
               //           await deleteFile(filePath, () => {
               //                res.end("width file require > 50 px")
               //           })
               //      } catch (error) {
               //           console.log('error delete', err);
               //      }
               //      res.end("width file require > 50 px")

               // }

               //resizeImage
               // await resizeImage(filePath, res, () => deleteFile(filePath, () => {
               //      res.end("error delete")
               // }), waterMarkPath)

               // change quality
               // await changeQuality(filePath, res, () => deleteFile(filePath, () => {
               //      res.end("error delete")
               // }))
               next()
          } catch (error) {
               console.log("not image: ", error);
               res.end("its not image");

          }
     });
};



module.exports = { uploadMultiImage }

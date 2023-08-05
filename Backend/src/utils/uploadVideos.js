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
          const folder = "./src/public/videos";
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
          cb(null, true);
     } catch (error) {
          cb(new Error('Type require is mp4'), false);
     }
};

var upload = multer({
     limits: {
          fieldSize: 5442.880
     },
     storage: storage, fileFilter: multerFilter,

}).array("video");

const uploadVideos = async function (req, res, next) {
     upload(req, res, async function (err) {
          try {
               console.log("req.files", req.files);
               if (err) {
                    return res.end("Error uploading video." + err);
               }
          } catch (error) {
               console.log("not video: ", error);
               res.end("its not video");
          }
     });
};



module.exports = { uploadVideos }

const Jimp = require("jimp");
const fs = require("fs");

const changeQuality = async (path, res, cbDel) => {
     console.log('current path', path);
     await Jimp.read(path, async (err, lenna) => {

          if (err) throw err;
          try {
               const pathArr = path.split('.');
               const currentPath  = pathArr[0] + "changeQualitied.jpg"
               console.log('current path', pathArr[0]);

               lenna
                    .quality(60) // set JPEG quality

                    // .greyscale() // set greyscale
                    .write(currentPath)

          } catch (error) {
               console.log('error change quality', error);
          } finally {
               await fs.unlink(path, ()=> {

               })
          }
     });
}

module.exports = changeQuality
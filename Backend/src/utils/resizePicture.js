var fs = require('fs');
var im = require('imagemagick');
const sharp = require('sharp');
const changeQuality = require('./changeQuality');

const resizeImage = async (path, res, cbDel, waterMarkPath) => {
     const pathArr = path.split('.');
     console.log(pathArr);
     const pathChanged = pathArr[0] + "resized.jpg"
     try {
          sharp(path)
               .composite([
                    {
                         input: waterMarkPath,
                         top: 5,
                         left: 5
                    }
               ])
               .resize({
                    width: 500,
                    height: 200
               }).toFile(pathChanged, async (err) => {
                    if (err) {
                         console.log("ERROR", err)
                         await changeQuality(path, res, cbDel)
                    } else {
                         await changeQuality(pathChanged, res, cbDel)
                         cbDel()
                    }
               })

          // await sharp(pathChanged).metadata()
     } catch (error) {
          await cbDel()
          console.log("ERROR", 'its not image')
     }
}
module.exports = resizeImage
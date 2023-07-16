var fs = require('fs');
var im = require('imagemagick');

const resizeImage = (path, cb) => {
     return new Promise(() => {
          im.resize({
               srcData: fs.readFileSync(path, 'binary'),
               width: 200,
               height: 500
          }, function (err, stdout, stderr) {
               if (err) throw err
               fs.writeFileSync('kittens-resized.jpg', stdout, 'binary');
               console.log('resized kittens.jpg to fit within 200x500px')
               cb()
          });
     })
}
module.exports = resizeImage
const path = require('path');

function checkIsImage(filename) {
    const ext = path.extname(filename).toLowerCase();
    return ext === '.png' || ext === '.jpg' || ext === '.gif';
}

module.exports = checkIsImage
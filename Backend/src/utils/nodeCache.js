const NodeCache = require("node-cache");
const myCache = new NodeCache({ stdTTL: 10 });


const KEY_CACHE = {
     TYM_POST: 'TYM_POST'
}
module.exports = {
     KEY_CACHE, myCache
}

const NodeCache = require("node-cache");
const myCache = new NodeCache( { stdTTL: Math.floor(Math.random() * 100), checkperiod: Math.floor(Math.random() * 100) } );



const pathCache = {
     PostData: "POST_DATA",
     PostUrl: "POST_URL"
}
module.exports = myCache
module.exports = pathCache
//Set up mongoose connection
const mongoose = require('mongoose');
const mongoDB = 'mongodb://localhost/asdasd';
mongoose.connect(mongoDB,{ useNewUrlParser: true });
mongoose.Promise = global.Promise;
module.exports = mongoose;
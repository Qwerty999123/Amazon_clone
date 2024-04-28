// Similar to IMPORTS in flutter
const express = require("express");
const auth = require("./routes/auth.js");
const mongoose = require("mongoose");
const adminRouter = require("./routes/admin.js");
const product = require("./routes/products.js");

// Initialization
const PORT = 3000;
const app = express();
const DB = "mongodb+srv://Qwerty:qwerty999@cluster0.quvxdms.mongodb.net/?retryWrites=true&w=majority";

// Middleware
app.use(express.json());
app.use(auth);
app.use(adminRouter);
app.use(product);

mongoose.connect(DB).then(() => {
    console.log("Connection successful");
}).catch((e) => {
    console.log(e);
});

// app.get("/", (req, res) => {
//     res.json({hi: "Hello World"});
// })

app.listen(PORT, "0.0.0.0" ,() => {
    console.log(`Connected at port ${PORT} hello`);
});



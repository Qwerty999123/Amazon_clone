const express = require('express');
const admin = require('../middlewares/admin.js');
const {Product} = require('../models/product');

const adminRouter = express.Router();

adminRouter.post("/admin/add-product", admin, async (req, res) => {
    try{
        const {name, description, images, quantity, price, category} = req.body;

        let product = new Product({
            name,
            description,
            images,
            quantity,
            price,
            category
        });

        product = await product.save();
        res.json(product);

    }catch(e){
        res.status(500).json({msg: e.message});
    }
});

adminRouter.get('/admin/get-products', admin, async (req, res) => {
    try {
        const product = await Product.find({});
        res.json(product);
    }catch (e) {
        res.status(500).json({msg: e.message});   
    }

});

adminRouter.post('/admin/delete-product', admin, async(req, res) => {
    try{
        const {id} = req.body;
        let product = await Product.findByIdAndDelete(id);
        res.json(product);
    }catch(e){
        res.status(500).json({msg: e.message});
    }
});

module.exports = adminRouter;

const express = require("express");
const {Product} = require("../models/product");
const auth = require("../middlewares/auth");
const User = require("../models/user");

const userRouter = express.Router();

userRouter.post("/api/add-to-cart", auth, async (req, res) => {
    try{
        const {id} = req.body;
        const product = await Product.findById(id);
        let user = await User.findById(req.user);

        if(user.cart.length == 0){
            user.cart.push({ product, quantity: 1});
        }else{
            let productFound = false;
            for(let i=0; i<user.cart.length; i++){
                if(user.cart[i].product._id.equals(product._id)){
                    user.cart[i].quantity += 1;
                    productFound = true;
                    break;
                }
            }

            if(!productFound){
                user.cart.push({ product, quantity: 1});
            }
        }
        user = await user.save();
        res.json(user);
    }catch(e){
        res.status(500).json({"error": e.message});
    }
});

module.exports = userRouter;

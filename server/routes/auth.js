const express = require('express');
const User = require('../models/user');
const bcryptjs = require("bcryptjs");
const jwt = require("jsonwebtoken");
const auth = require("../middlewares/auth");

const authRouter = express.Router();

authRouter.post('/api/signup', async (req, res) => {
    try {
        const {name, email, password} = req.body;
        
        const existingUser = await User.findOne({ email });
        // In javascript if key and value is same (like email: email), then we can write it as above(email)
        // Its a shortcut in javascript
        if(existingUser){
            return res.status(400).json({msg: 'User with same email already exists'});
        }

        const hashedPassword = await bcryptjs.hash(password, 8);

        let user = new User({
            name,
            email,
            password: hashedPassword
        });
        
        user = await user.save();
        res.json(user);
    } catch (e) {
        res.status(500).json({"error": e.message});
    }


});

authRouter.post('/api/signin', async (req, res) => {
    try{
        const {email, password} = req.body;
        
        const existingUser = await User.findOne({ email });
        if(!existingUser){
            return res.status(400).json({msg: 'User does not exist'});
        }
        
        const checkPass = await bcryptjs.compare(password, existingUser.password);
        if(!checkPass){
            return res.status(400).json({msg: 'Password entered is incorrect'});
        }

        const token = jwt.sign({id: existingUser._id}, 'passwordKey');
        res.json({token, ...existingUser._doc});

    }catch(e){
        return res.status(500).json({msg: e.message});
    }
});

authRouter.post('/isTokenValid', async (req, res) => {
    const token = req.header('x-auth-token');
    if(!token) return res.json(false);

    const isVerified = jwt.verify(token, 'passwordKey');
    if(!isVerified) return res.json(false);

    const isUserExist = await User.findById( isVerified.id );
    if(!isUserExist) return res.json(false);

    res.json(true);
});

authRouter.get('/', auth, async (req, res) => {
    const user =  await User.findById(req.user);
    res.json({...user._doc, token: req.token});
});

module.exports = authRouter;

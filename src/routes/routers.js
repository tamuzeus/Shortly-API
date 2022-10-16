import express from 'express';
import signRouter from './sign.routers.js';
import urlRouter from './urls.routers.js';


const router = express.Router()
router.use(signRouter)
router.use(urlRouter)


export default router;
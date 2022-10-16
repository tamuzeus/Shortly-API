import express from 'express';
import cors from 'cors'
import router from './routes/routers.js';
import dotenv from 'dotenv';

dotenv.config()
const app = express()
app.use(express.json())
app.use(cors());
app.use(router);

app.get('/status', async (req, res) => {
  res.send('Ok')
})

app.listen(process.env.PORT, () => {
  console.log(`KABUM!!! PORT ${process.env.PORT}!!!`)
})
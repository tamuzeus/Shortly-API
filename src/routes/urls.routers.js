import express from "express";
import { getUrlId, getOpenShortUrl, urlShorten, deleteUrl } from "../controllers/url.controllers.js"

const router = express.Router()
router.get("/urls/:id", getUrlId)
router.get("/urls/open/:shortUrl", getOpenShortUrl)
router.post("/urls/shorten", urlShorten)
router.delete("/urls/:id", deleteUrl)

export default router
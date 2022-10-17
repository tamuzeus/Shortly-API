import joi from 'joi'
import { nanoid } from 'nanoid';
import connection from "../database/db.js";

async function getUrlId(req, res) {
    const { id } = req.params

    try {
        const findId = await connection.query('SELECT id, "shortUrl", url FROM links WHERE id = $1', [id])

        if (findId.rows[0].shortUrl === null || findId.rows[0].shortUrl === undefined) {
            res.sendStatus(404)
        }

        res.send(findId.rows[0]).status(200)
    } catch (error) {
        console.log(error)
        res.sendStatus(500)
    }
}

const urlSchema = joi.object({
    url: joi.string().pattern(/^https?:\/\/(?:www\.)?[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b(?:[-a-zA-Z0-9()@:%_\+.~#?&\/=]*)$/, 'html').required()
});

async function urlShorten(req, res) {
    const { url } = req.body
    const { authorization } = req.headers

    try {
        const validation = urlSchema.validate(req.body, { abortEarly: false })
        if (validation.error) {
            const err = validation.error.details.map(detail => detail.message);
            return res.status(422).send(err);
        }

        const token = authorization.replace('Bearer ', '')
        const headerConfirmation = await connection.query("SELECT hash FROM sessions WHERE hash = $1;", [token]);

        if (!headerConfirmation.rows[0]) {
            res.sendStatus(401)
        }

        const getuserId = await connection.query('SELECT users.id, sessions.hash FROM sessions JOIN users ON sessions."userId" = users.id WHERE hash = $1;', [token])
        const userId = getuserId.rows[0].id

        const shortUrl = nanoid(10)

        await connection.query('INSERT INTO links (url, "shortUrl", "userId") VALUES ($1, $2, $3)', [url, shortUrl, userId])

        res.send(`shortUrl: ${shortUrl}`).status(201)
    } catch (error) {
        console.log(error)
        res.sendStatus(500)
    }
}

async function getOpenShortUrl(req, res) {
    const { shortUrl } = req.params

    try {
        const findshortUrl = await connection.query('SELECT id, "shortUrl", url, "visitCount" FROM links WHERE "shortUrl" = $1', [shortUrl])
        const linkOrignal = findshortUrl.rows[0].url

        if (findshortUrl.rows[0].shortUrl === null || findshortUrl.rows[0].shortUrl === undefined) {
            res.sendStatus(404)
        }

        const visitCount = findshortUrl.rows[0].visitCount + 1
        const shortUrlId = findshortUrl.rows[0].id
        console.log(shortUrlId)
        const updateVisitCount = await connection.query('UPDATE links SET "visitCount" = $1 WHERE id = $2', [visitCount, shortUrlId])

        res.redirect(linkOrignal)
    } catch (error) {
        console.log(error)
        res.sendStatus(500)
    }
}

async function deleteUrl(req, res) {
    const { id } = req.params
    const { authorization } = req.headers

    try {
        const token = authorization.replace('Bearer ', '')
        const headerConfirmation = await connection.query("SELECT hash FROM sessions WHERE hash = $1;", [token]);
        const findshortUrl = await connection.query('SELECT * FROM links WHERE id = $1', [id])

        const getToken = headerConfirmation.rows[0].hash
        const getId = findshortUrl.rows[0].id

        if (!headerConfirmation.rows[0]) {
            res.sendStatus(401)
        }

        const verify = await connection.query('SELECT users.name, links.id, links.url, links."shortUrl", sessions.hash FROM sessions JOIN users ON sessions."userId" = users.id JOIN links ON links."userId" = users.id WHERE links.id = $1 and sessions.hash = $2;', [id, getToken])

        if (verify.rows[0].shortUrl === null || verify.rows[0].shortUrl === undefined) {
            res.sendStatus(401)
        }

        if (findshortUrl.rows[0].shortUrl === null || findshortUrl.rows[0].shortUrl === undefined) {
            res.sendStatus(404)
        }

        await connection.query('DELETE FROM links WHERE id = $1', [getId])

        res.send('DELETED!').status(204)
    } catch (error) {
        console.log(error)
        res.sendStatus(500)
    }
}

async function urlMe(req, res) {
    const { authorization } = req.headers

    try {
        const token = authorization.replace('Bearer ', '')
        const headerConfirmation = await connection.query("SELECT * FROM sessions WHERE hash = $1;", [token]);
        if (!headerConfirmation.rows[0]) {
            res.sendStatus(401)
        }
        const getToken = headerConfirmation.rows[0].hash

        const getInfos = await connection.query('SELECT users.id, users.name, links."shortUrl", links.url, links."visitCount" FROM sessions JOIN users ON sessions."userId" = users.id JOIN links ON links."userId" = users.id WHERE sessions.hash = $1;', [getToken])

        if(!getInfos.rows[0].name){
            res.sendStatus(404)
        }

        const getInfosExceptName = await connection.query('SELECT links.id, links."shortUrl", links.url, links."visitCount" FROM sessions JOIN users ON sessions."userId" = users.id JOIN links ON links."userId" = users.id WHERE sessions.hash = $1;', [getToken])
        const sums = await connection.query('SELECT SUM("visitCount") FROM sessions JOIN users ON sessions."userId" = users.id JOIN links ON links."userId" = users.id WHERE sessions.hash = $1;', [getToken])

        const objectMont = {
            id: getInfos.rows[0].id,
            name: getInfos.rows[0].name,
            visitCount: sums.rows[0].sum,
            shortenedUrls: getInfosExceptName.rows
        }

        res.send(objectMont).status(200)

    } catch (error) {
        console.log(error)
        res.sendStatus(500)
    }
}


async function raking(req, res){
    try {
        const list = await connection.query( 'SELECT users.id, users.name, COUNT(links.id) AS "linksCount", COALESCE(SUM(links."visitCount"), 0) AS "visitCount" FROM users LEFT JOIN links ON links."userId" = users.id GROUP BY users.id ORDER BY "visitCount" DESC, "linksCount" DESC LIMIT 10;')

        res.send(list.rows).status(200)
    } catch (error) {
        console.log(error)
        res.sendStatus(500)
    }
}

export { getUrlId, getOpenShortUrl, urlShorten, deleteUrl, urlMe, raking }
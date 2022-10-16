import connection from "../database/db.js";
import joi from "joi";
import bcrypt from "bcrypt";
import jwt from "jsonwebtoken";
import dotenv from 'dotenv';

dotenv.config()

const signInSchema = joi.object({
    email: joi.string().email({ tlds: { allow: false } }).empty(' ').required().trim(),
    password: joi.string().empty(' ').required(),
})

async function signIn(req, res) {
    const { email, password } = req.body

    try {
        const validation = signInSchema.validate(req.body, { abortEarly: false })
        if (validation.error) {
            const err = validation.error.details.map(detail => detail.message);
            return res.status(422).send(err);
        }

        const getEmail = await connection.query('SELECT * FROM users WHERE email = $1', [email]);
        if (getEmail.rows.length === 0) {
            return res.sendStatus(401)
        }

        const getPassword = await connection.query('SELECT password FROM passwords JOIN users ON passwords.id = users."passwordId" WHERE email = $1', [email]);
        const cryptPassword = getPassword.rows[0].password

        if (cryptPassword && bcrypt.compareSync(password, cryptPassword)) {
            console.log('OK!')
        } else {
            return res.sendStatus(401)
        }

        const getId = await connection.query('SELECT id FROM users WHERE email = $1', [email]);
        const hash = jwt.sign(
            {
                token: getId.rows[0].id
            }, process.env.TOKEN_SECRET
        );

        console.log(jwt.verify(hash, process.env.TOKEN_SECRET))

        await connection.query('INSERT INTO sessions (hash, "userId") VALUES ($1, $2);', [hash, getEmail.rows[0].id])

        res.send(`token: ${hash}`).status(200)
    } catch (error) {
        console.log(error)
        res.sendStatus(500)
    }
}

const signUpSchema = joi.object({
    name: joi.string().empty(' ').required().trim(),
    email: joi.string().email({ tlds: { allow: false } }).empty(' ').required().trim(),
    password: joi.string().empty(' ').required(),
    confirmPassword: joi.string().required().valid(joi.ref('password'))
})

async function signUp(req, res) {
    const { name, email, password } = req.body

    try {
        const validation = signUpSchema.validate(req.body, { abortEarly: false })
        if (validation.error) {
            const err = validation.error.details.map(detail => detail.message);
            return res.status(422).send(err);
        }
        const cryptPassword = bcrypt.hashSync(password, 10);

        const getEmail = await connection.query('SELECT * FROM users WHERE email = $1', [email]);
        if (getEmail.rows.length !== 0) {
            return res.sendStatus(409)
        }

        await connection.query('INSERT INTO passwords (password) VALUES ($1);', [cryptPassword])
        const passwordId = await connection.query('SELECT id FROM passwords WHERE password = $1', [cryptPassword])
        await connection.query('INSERT INTO users (name, email, "passwordId") VALUES ($1, $2, $3);', [name, email, passwordId.rows[0].id])
        res.sendStatus(201)
    } catch (error) {
        console.log(error)
        res.sendStatus(500)
    }
}

export { signIn, signUp }
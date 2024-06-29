import express from 'express';
import session from 'express-session';
import {createClient} from "redis";
import RedisStore from "connect-redis";

const app = express();
const port = 3000;

const redisClient = createClient({
    legacyMode: true,
    socket: {
        host: process.env.REDIS_HOST,
        port: process.env.REDIS_PORT,
    }
});
console.log('redisClient', process.env.REDIS_PORT, process.env.REDIS_HOST);
console.log('redisClient:instance', redisClient);

redisClient.connect().catch(console.error); // Needed

// Initialize store.
const redisStore = new RedisStore({
    client: redisClient,
    prefix: "myapp:",
});


// Set up session management
app.use(session({
    store: redisStore,
    secret: 'your-secret-key', // Replace with your own secret key
    resave: false,
    saveUninitialized: false,
    cookie: { secure: false } // Set to true if using HTTPS
}));

app.get('/', (req, res) => {
    if (req.session.views) {
        req.session.views++;
        res.send(`Number of views: ${req.session.views}`);
    } else {
        req.session.views = 1;
        res.send('Welcome to the session demo. Refresh page!');
    }
});

app.listen(port, () => {
    console.log(`Example app listening at http://localhost:${port}`);
});

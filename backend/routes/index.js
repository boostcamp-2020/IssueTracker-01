import express from 'express';
import passport from 'passport';
import jwt from 'jsonwebtoken';
import milestone from './api/milestone';
import githubRouter from './oauth/github';
import apiComment from './api/comment';

const router = express.Router();

router.use('/oauth/github', githubRouter);
router.use('/api/milestone', passport.authenticate('jwt', { session: false }), milestone);
router.use('/api/comment', passport.authenticate('jwt', { session: false }), apiComment);

router.get('/', (req, res) => {
  return res.send('ok');
});

router.get('/validate/jwt', passport.authenticate('jwt', { session: false }), (req, res) => {
  res.sendStatus(200);
});

export default router;

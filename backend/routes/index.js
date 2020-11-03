import express from 'express';
import passport from 'passport';
import jwt from 'jsonwebtoken';
import milestone from './api/milestone';
import githubRouter from './oauth/github';

const router = express.Router();

router.get('/', (req, res) => {
  return res.send('ok');
});

router.get('/validate/jwt', passport.authenticate('jwt', { session: false }), (req, res) => {
  res.sendStatus(200);
});

router.use('/oauth/github', githubRouter);
router.use('/milestone', milestone);

export default router;

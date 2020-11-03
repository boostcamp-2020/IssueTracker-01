import express from 'express';
import passport from 'passport';
import jwt from 'jsonwebtoken';
<<<<<<< HEAD
import milestone from './api/milestone';
import githubRouter from './oauth/github';
=======
import apiComment from './api/comment';
>>>>>>> feature/comment

const router = express.Router();

router.use('/api/comment', passport.authenticate('jwt', { session: false }), apiComment);
router.get('/', (req, res) => {
  return res.send('ok');
});

router.get('/validate/jwt', passport.authenticate('jwt', { session: false }), (req, res) => {
  res.sendStatus(200);
});

<<<<<<< HEAD
router.use('/oauth/github', githubRouter);
router.use('/milestone', milestone);
=======
router.get('/test/jwt', passport.authenticate('jwt', { session: false }), (req, res) => {
  console.log(req.user);
  console.log('성공');
});
>>>>>>> feature/comment

export default router;

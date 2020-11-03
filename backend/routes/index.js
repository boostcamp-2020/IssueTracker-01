import express from 'express';
import passport from 'passport';
import githubRouter from './oauth/github';

const router = express.Router();

router.get('/', (req, res) => {
  return res.send('ok');
});

router.use('/oauth/github', githubRouter);
router.get('/validate/jwt', passport.authenticate('jwt', { session: false }), (req, res) => {
  res.sendStatus(200);
});

export default router;

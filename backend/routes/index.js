import express from 'express';
import passport from 'passport';
import milestone from './api/milestone';
import githubRouter from './oauth/github';
import apiComment from './api/comment';
import labelRouter from './api/label';
import issueRouter from './api/issue';
import userRouter from './api/user';

const router = express.Router();

router.use('/oauth/github', githubRouter);
router.use('/api/milestone', passport.authenticate('jwt', { session: false }), milestone);
router.use('/api/comment', passport.authenticate('jwt', { session: false }), apiComment);
router.use('/api/label', passport.authenticate('jwt', { session: false }), labelRouter);
router.use('/api/issue', passport.authenticate('jwt', { session: false }), issueRouter);
router.use('/api/user', passport.authenticate('jwt', { session: false }), userRouter);

router.get('/', (req, res) => {
  return res.send('ok');
});

router.get('/isLogin', passport.authenticate('jwt', { session: false }), (req, res) => {
  res.status(200).json({ userId: req.user.dataValues.userId });
});

export default router;

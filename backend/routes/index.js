import express from 'express';
import passport from 'passport';
import jwt from 'jsonwebtoken';

const router = express.Router();

router.get('/', (req, res) => {
  return res.send('ok');
});

router.get('/github', passport.authenticate('github'));

router.get('/github/callback', (req, res) => {
  passport.authenticate('github', { failureRedirect: '/' }, (err, user) => {
    const [User] = user;
    const token = jwt.sign({ userId: User.dataValues.userId }, process.env.JWT_SECERT);
    if (req.headers['user-agent'].includes('iPhone')) {
      return res.redirect(`issuetracker://${token}`);
    }
    res.cookie('jwt', token);
    return res.redirect('/');
  })(req, res);
});

router.get('/test/jwt', passport.authenticate('jwt', { session: false }), (req, res) => {
  console.log('성공');
});

module.exports = router;

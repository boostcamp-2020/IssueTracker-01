import passport from 'passport';
import jwt from 'jsonwebtoken';
import Config from '@config';

const githubOAuthLogin = (req, res) => {
  passport.authenticate('github', { failureRedirect: '/' }, (err, user) => {
    const [User] = user;
    const token = jwt.sign({ userId: User.dataValues.userId }, Config.JWT_SECRET);
    if (req.headers['user-agent'].includes('iPhone')) {
      return res.redirect(`issuetracker://${token}`);
    }
    res.cookie('jwt', token, { httpOnly: true });
    return res.redirect('/');
  })(req, res);
};

export default { githubOAuthLogin };

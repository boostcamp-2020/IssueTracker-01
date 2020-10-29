import passport from 'passport';
const GitHubStrategy = require('passport-github').Strategy;
const { Strategy: JwtStrategy } = require('passport-jwt');
import User from '../models/userModel';
require('dotenv').config();

module.exports = () => {
  passport.use(
    new GitHubStrategy(
      {
        clientID: process.env.GITHUB_CLIENT_ID,
        clientSecret: process.env.GITHUB_CLIENT_SECRET,
        callbackURL: 'http://127.0.0.1:3000/github/callback',
      },
      async (accessToken, refreshToken, profile, done) => {
        const user = await User.findOrCreate({
          where: { userId: profile.username },
          defaults: {
            password: 'test',
          },
        });
        done(null, user);
      },
    ),
  );

  const cookieExtractor = (req) => {
    let token = undefined;
    if (req && req.cookies) {
      token = req.cookies.jwt;
    }
    return token;
  };
  passport.use(
    new JwtStrategy(
      {
        jwtFromRequest: cookieExtractor,
        secretOrKey: process.env.JWT_SECERT,
      },
      async (payload, done) => {
        const user = await User.findOne({ where: { userId: payload.userId } });
        if (user) {
          done(null, user);
        } else {
          done(null, false);
        }
      },
    ),
  );
};

import passport from 'passport';
import User from '@models/userModel';
import { Strategy as GitHubStrategy } from 'passport-github';
import { Strategy as JwtStrategy } from 'passport-jwt';
import Config from '@config';

const passportConfig = () => {
  passport.use(
    new GitHubStrategy(
      {
        clientID: Config.GITHUB_CLIENT_ID,
        clientSecret: Config.GITHUB_CLIENT_SECRET,
        callbackURL: Config.GITHUB_CALLBACK_URL,
      },
      async (accessToken, refreshToken, profile, done) => {
        const user = await User.findOrCreate({
          where: { userId: profile.username },
          defaults: {
            password: 'test',
            profile_url: profile.photos[0].value,
          },
        });
        done(null, user);
      },
    ),
  );

  const cookieExtractor = (req) => {
    return req.cookies ? req.cookies.jwt : undefined;
  };
  passport.use(
    new JwtStrategy(
      {
        jwtFromRequest: cookieExtractor,
        secretOrKey: Config.JWT_SECRET,
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

export default passportConfig;

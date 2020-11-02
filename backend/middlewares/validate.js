import passport from 'passport';

const authentication = (req, res, next) => {
  passport.authenticate('jwt', { session: false }, (err, user) => {
    if (user) {
      req.user = user;
      return next();
    }
    return next({
      status: 401,
      message: '로그인 후 사용해 주세요.',
    });
  })(req, res, next);
};

export default { authentication };

import express from 'express';
import passport from 'passport';
import loginService from '@services/loginService';

const router = express.Router();

router.get('/', passport.authenticate('github'));
router.get('/callback', loginService.githubOAuthLogin);

export default router;

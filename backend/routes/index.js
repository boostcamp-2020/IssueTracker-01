import express from 'express';
import validate from '@middlewares/validate';
import githubRouter from './oauth/github';

const router = express.Router();

router.get('/', (req, res) => {
  return res.send('ok');
});

router.use('/oauth/github', githubRouter);
router.get('/validate/jwt', validate.authentication, (req, res) => {
  res.sendStatus(200);
});

export default router;

import createError from 'http-errors';
import express from 'express';

import cookieParser from 'cookie-parser';
import logger from 'morgan';

import { sequelize } from './models';
import 'module-alias/register';
import indexRouter from './routes/index';
import passport from 'passport';
import passportConfig from './passport/passport';
import cors from 'cors';

const app = express();

sequelize
  .sync({ force: false })
  .then(() => {
    console.log('데이터베이스 연결 성공');
  })
  .catch((err) => {
    console.error(err);
  });

passportConfig();
app.use(
  cors({
    origin: true,
    credentials: true,
  }),
);
app.use(logger('dev'));
app.use(express.json());
app.use(express.urlencoded({ extended: false }));
app.use(cookieParser());
app.use(passport.initialize());
app.use('/', indexRouter);

app.use((req, res, next) => {
  next(createError(404));
});

app.use((err, req, res) => {
  res.status(err.status || 500).json({ message: err.message });
});

export default app;

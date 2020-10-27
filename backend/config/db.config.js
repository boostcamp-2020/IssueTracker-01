import Config from '.';

export default {
  development: {
    username: Config.DB_USER,
    password: Config.DB_PASSWORD,
    database: Config.DB_NAME,
    host: Config.DB_HOST,
    dialect: 'mysql',
  },
  test: {
    username: Config.DB_USER,
    password: Config.DB_PASSWORD,
    database: Config.DB_NAME,
    host: Config.DB_HOST,
    dialect: 'mysql',
  },
  production: {
    username: Config.DB_USER,
    password: Config.DB_PASSWORD,
    database: Config.DB_NAME,
    host: Config.DB_HOST,
    dialect: 'mysql',
  },
};

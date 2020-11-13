module.exports = {
  presets: [
    '@babel/preset-react',
    [
      '@babel/preset-env',
      {
        targets: { chrome: 55 },
      },
    ],
  ],
};

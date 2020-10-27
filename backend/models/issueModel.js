const Sequelize = require('sequelize');

module.exports = class Issue extends Sequelize.Model {
  static init(sequelize) {
    return super.init(
      {
        issueId: {
          type: Sequelize.INTEGER,
          allowNull: false,
          autoIncrement: true,
          primaryKey: true,
        },
        title: {
          type: Sequelize.STRING(45),
          allowNull: false,
        },
        content: {
          type: Sequelize.STRING(200),
        },
        status: {
          type: Sequelize.STRING(30),
          defaultValue: 'open',
        },
      },
      {
        sequelize,
        underscored: false,
        paranoid: false,
        modelName: 'Transaction',
        tableName: 'transaction',
        charset: 'utf8mb4',
        collate: 'utf8mb4_general_ci',
      },
    );
  }

  static associate(db) {
    db.Issue.belongsTo(db.User, {
      foreignKey: 'userId',
    });

    db.Issue.belongsTo(db.MileStone, {
      foreignKey: 'milestoneId',
    });
  }
};

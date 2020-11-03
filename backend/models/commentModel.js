import Sequelize from 'sequelize';

export default class Comment extends Sequelize.Model {
  static init(sequelize) {
    return super.init(
      {
        commentId: {
          type: Sequelize.INTEGER,
          allowNull: false,
          autoIncrement: true,
          primaryKey: true,
        },
        content: {
          type: Sequelize.STRING(200),
          allowNull: false,
        },
      },
      {
        sequelize,
        underscored: false,
        paranoid: false,
        modelName: 'Comment',
        tableName: 'Comment',
        charset: 'utf8mb4',
        collate: 'utf8mb4_general_ci',
      },
    );
  }

  static associate(db) {
    db.Comment.belongsTo(db.User, {
      foreignKey: 'userId',
    });
    db.Comment.belongsTo(db.Issue, {
      foreignKey: 'issueId',
    });
  }
}

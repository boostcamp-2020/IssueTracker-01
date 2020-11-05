import Sequelize from 'sequelize';

export default class Issue extends Sequelize.Model {
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
        isOpen: {
          type: Sequelize.TINYINT(1),
          defaultValue: 1,
        },
      },
      {
        sequelize,
        underscored: false,
        paranoid: false,
        modelName: 'Issue',
        tableName: 'issues',
        charset: 'utf8mb4',
        collate: 'utf8mb4_general_ci',
      },
    );
  }

  static associate(db) {
    db.Issue.belongsTo(db.User, {
      foreignKey: 'userId',
      as: 'UserAuthor',
    });
    db.Issue.belongsTo(db.User, {
      foreignKey: 'assignees',
      targetKey: 'userId',
    });
    db.Issue.belongsTo(db.Milestone, {
      foreignKey: 'milestoneId',
    });
    db.Issue.hasMany(db.IssueLabel, {
      foreignKey: 'issueId',
    });
    db.Issue.hasMany(db.Comment, {
      foreignKey: 'issueId',
    });
  }
}

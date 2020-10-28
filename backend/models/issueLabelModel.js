import Sequelize from 'sequelize';

export default class IssueLabel extends Sequelize.Model {
  static init(sequelize) {
    return super.init(
      {
        // id: {
        //     type: Sequelize.INTEGER,
        //     allowNull: false,
        //     primaryKey: true,
        // },
      },
      {
        sequelize,
        timestamps: false,
        underscored: false,
        paranoid: false,
        modelName: 'IssueLabel',
        tableName: 'issuelabels',
        charset: 'utf8mb4',
        collate: 'utf8mb4_general_ci',
      },
    );
  }

  static associate(db) {
    db.IssueLabel.belongsTo(db.Issue, {
      foreignKey: 'issueId',
    });
    db.IssueLabel.belongsTo(db.Label, {
      foreignKey: 'name',
    });
  }
}

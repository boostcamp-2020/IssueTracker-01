import Sequelize from 'sequelize';

export default class MileStone extends Sequelize.Model {
  static init(sequelize) {
    return super.init(
      {
        milestoneId: {
          type: Sequelize.INTEGER,
          allowNull: false,
          autoIncrement: true,
          primaryKey: true,
        },
        title: {
          type: Sequelize.STRING(100),
          allowNull: false,
        },
        description: {
          type: Sequelize.TEXT,
          allowNull: true,
        },
        dueDate: {
          type: Sequelize.DATE,
          allowNull: true,
        },
      },
      {
        sequelize,
        timestamps: true,
        underscored: false,
        paranoid: false,
        modelName: 'MileStone',
        tableName: 'milestones',
        charset: 'utf8mb4',
        collate: 'utf8mb4_general_ci',
      },
    );
  }

  static async readMilestoneList() {
    try {
      const milestones = await this.findAll({ attributes: ['title', 'dueDate'] });
      return milestones.map((milestone) => milestone.dataValues);
    } catch (err) {
      console.log(err);
      return [];
    }
  }
}

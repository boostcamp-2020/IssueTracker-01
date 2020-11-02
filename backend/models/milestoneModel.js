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

  static associate(db) {
    db.Milestone.hasMany(db.Issue, {
      foreignKey: 'milestoneId',
    });
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

  static async readMilestonesDetail() {
    try {
      const milestones = await this.findAll({
        attributes: [
          'title',
          'dueDate',
          'description',
          [Sequelize.fn('sum', Sequelize.literal('if(`Issues`.`status` = "open", 1, 0)')), 'openIssues'],
          [Sequelize.fn('sum', Sequelize.literal('if(`Issues`.`status` = "close", 1, 0)')), 'closeIssues'],
        ],
        include: ['Issues'],
        group: ['MileStone.milestoneId'],
      });
      return milestones.map((milestone) => {
        const { Issues, ...milestoneData } = milestone.dataValues;
        return milestoneData;
      });
    } catch (err) {
      console.log(err);
      return [];
    }
  }

  static async createMilestone({ title, dueDate, description }) {
    await this.create({
      title,
      dueDate,
      description,
    });
  }

  static async updateMilestone({ id, title, dueDate, description }) {
    await this.update(
      {
        title,
        dueDate,
        description,
      },
      { where: { milestoneId: id } },
    );
  }
}

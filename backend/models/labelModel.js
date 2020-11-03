import Sequelize from 'sequelize';

export default class Label extends Sequelize.Model {
  static init(sequelize) {
    return super.init(
      {
        labelName: {
          type: Sequelize.STRING(100),
          allowNull: false,
          primaryKey: true,
        },
        color: {
          type: Sequelize.STRING(100),
          allowNull: false,
        },
        description: {
          type: Sequelize.STRING(100),
          allowNull: true,
        },
      },
      {
        sequelize,
        timestamps: false,
        underscored: false,
        paranoid: false,
        modelName: 'Label',
        tableName: 'labels',
        charset: 'utf8mb4',
        collate: 'utf8mb4_general_ci',
      },
    );
  }

  static async readLabels() {
    try {
      const labels = await this.findAll();

      return labels;
    } catch (error) {
      return false;
    }
  }

  static async createLabel(newLabel) {
    const result = await this.create(newLabel);

    return result;
  }

  static async updateLabel(curName, newName, labelColor, desc) {
    const result = await this.update(
      {
        labelName: newName,
        color: labelColor,
        description: desc,
      },
      {
        where: { labelName: curName },
      },
    );

    return result;
  }

  static async deleteLabel(name) {
    const result = await Label.destroy({
      where: { labelName: name },
    });

    return result;
  }

  static async isExist(name) {
    const check = await this.findOne({ where: { labelName: name } });

    return check;
  }
}

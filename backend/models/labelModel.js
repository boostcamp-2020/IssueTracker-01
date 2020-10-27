const Sequelize = require('sequelize');

module.exports = class Label extends Sequelize.Model {
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
                    allowNull: false,
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
        )
    }
}

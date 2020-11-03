import Milestone from '@models/milestoneModel';
import Sequelize from 'Sequelize';

const getMilestoneList = async (req, res, next) => {
  try {
    const milestones = await Milestone.findAll({ attributes: ['title', 'dueDate'] });
    res.json(milestones);
  } catch (err) {
    console.log(err);
    next({
      status: 400,
      message: err.message,
    });
  }
};

const getMilestone = async (req, res, next) => {
  try {
    const milestones = await Milestone.findAll({
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
    const milestoneData = milestones.map((milestone) => {
      const { Issues, ...milestoneData } = milestone.dataValues;
      return milestoneData;
    });
    res.json(milestoneData);
  } catch (err) {
    console.log(err);
    next({
      status: 400,
      message: err.message,
    });
  }
};

const addMilestone = async (req, res, next) => {
  try {
    const { title, description, dueDate } = req.body;
    await Milestone.create({
      title,
      dueDate,
      description,
    });
    res.json({ message: 'Success' });
  } catch (err) {
    console.log(err);
    next({
      status: 400,
      message: 'Fail',
    });
  }
};

const updateMilestone = async (req, res, next) => {
  try {
    const { id } = req.params;
    const { title, dueDate, description } = req.body;
    await Milestone.update(
      {
        title,
        dueDate,
        description,
      },
      { where: { milestoneId: id } },
    );
    res.json({ message: 'Success' });
  } catch (err) {
    console.log(err);
    next({
      status: 400,
      message: 'Fail',
    });
  }
};

const deleteMilestone = async (req, res, next) => {
  try {
    const { id } = req.params;
    await Milestone.destroy({ where: { milestoneId: id } });
    res.json({ message: 'Success' });
  } catch (err) {
    console.log(err);
    next({
      status: 500,
      message: 'Fail',
    });
  }
};

export default { getMilestoneList, getMilestone, addMilestone, updateMilestone, deleteMilestone };

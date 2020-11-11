import Issue from '@models/issueModel';
import Milestone from '@models/milestoneModel';
import Sequelize from 'sequelize';

const getMilestoneList = async (req, res, next) => {
  try {
    const milestones = await Milestone.findAll({
      attributes: ['milestoneId', 'title', 'dueDate', 'description', 'updatedAt'],
      include: [
        {
          model: Issue,
          attributes: ['issueId', 'isOpen'],
        }
      ]
    });
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
        [Sequelize.fn('sum', Sequelize.literal('if(`Issues`.`isOpen` = 1, 1, 0)')), 'openIssues'],
        [Sequelize.fn('sum', Sequelize.literal('if(`Issues`.`isOpen` = 0, 1, 0)')), 'closeIssues'],
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
    const { milestoneId } = req.params;
    const { title, dueDate, description } = req.body;

    if (dueDate.length === 0) {
      await Milestone.update(
        {
          title, description
        },
        { where: { milestoneId: milestoneId } },
      );
    } else {
      await Milestone.update(
        {
          title, dueDate, description
        },
        { where: { milestoneId: milestoneId } },
      );
    }

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
    const { milestoneId } = req.params;
    await Milestone.destroy({ where: { milestoneId: milestoneId } });
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

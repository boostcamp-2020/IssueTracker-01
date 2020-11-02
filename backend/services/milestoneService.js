import Milestone from '@models/milestoneModel';

const getMilestoneList = async (req, res, next) => {
  try {
    const milestones = await Milestone.findAll({ attributes: ['title', 'dueDate'] });
    res.json(milestones.map((milestone) => milestone.dataValues));
  } catch (err) {
    console.log(err);
    next({
      status: 500,
      message: err,
    });
  }
};

export default { getMilestoneList };

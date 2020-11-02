import Milestone from '@models/milestoneModel';

const getMilestoneList = async (req, res, next) => {
  try {
    const milestones = await Milestone.readMilestoneList();
    res.json(milestones);
  } catch (err) {
    console.log(err);
    next({
      status: 500,
      message: err,
    });
  }
};

export default { getMilestoneList };

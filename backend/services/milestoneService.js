import MileStone from '@models/milestoneModel';

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

const getMilestone = async (req, res, next) => {
  try {
    const milestones = await Milestone.readMilestonesDetail();
    res.json(milestones);
  } catch (err) {
    console.log(err);
    next({
      status: 500,
      message: err.message,
    });
  }
};

const addMilestone = async (req, res, next) => {
  try {
    const { title, description, dueDate } = req.body;
    await Milestone.createMilestone({ title, description, dueDate });
    res.json({ message: 'Success' });
  } catch (err) {
    console.log(err);
    next({
      status: 500,
      message: 'Fail',
    });
  }
};

const updateMilestone = async (req, res, next) => {
  try {
    const { id } = req.params;
    const { title, dueDate, description } = req.body;
    await MileStone.updateMilestone({ id, title, dueDate, description });
    res.json({ message: 'Success' });
  } catch (err) {
    console.log(err);
    next({
      status: 500,
      message: 'Fail',
    });
  }
};

const deleteMilestone = async (req, res, next) => {
  res.json({ message: 'Success' });
};

export default { getMilestoneList, getMilestone, addMilestone, updateMilestone, deleteMilestone };

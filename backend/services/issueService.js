import Issue from '@models/issueModel';

const updateTitle = async (req, res, next) => {
  try {
    const { id } = req.params;
    const { title } = req.body;
    await Issue.update(
      {
        title,
      },
      { where: { issueId: id } },
    );
    res.json({ message: 'Success' });
  } catch (err) {
    console.log(err);
    next({
      status: 400,
      message: err.message,
    });
  }
};

const updateMilestone = async (req, res, next) => {
  try {
    const { id: issueId } = req.params;
    const { milestoneId } = req.body;
    await Issue.update(
      {
        milestoneId: milestoneId || null,
      },
      { where: { issueId } },
    );
    res.json({ message: 'Success' });
  } catch (err) {
    console.log(err);
    next({
      status: 400,
      message: err.message,
    });
  }
};

export default { updateTitle, updateMilestone };

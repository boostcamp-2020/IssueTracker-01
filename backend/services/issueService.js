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
    next({
      status: 400,
      message: err.message,
    });
  }
};

export default { updateTitle };

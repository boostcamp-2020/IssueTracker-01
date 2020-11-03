import Comment from '@models/commentModel';

const create = async (req, res) => {
  try {
    const data = {
      content: req.body.content,
      userId: req.user.dataValues.userId,
      issueId: req.params.issueId,
    };
    await Comment.create(data);
    return res.status(200).send();
  } catch (error) {
    return res.status(400).json({ message: 'Error' });
  }
};
const read = async (req, res) => {
  try {
    const data = await Comment.findAll({
      where: {
        issueId: req.params.issueId,
      },
      order: ['createdAt'],
    });
    return res.status(200).json(data);
  } catch (error) {
    return res.status(400).json({ message: 'Error' });
  }
};
const update = async (req, res) => {
  try {
    const data = { content: req.body.content };
    await Comment.update(data, { where: { commentId: req.params.commentId } });
    return res.status(200).send();
  } catch (error) {
    return res.status(400).json({ message: 'Error' });
  }
};

const del = async (req, res) => {
  try {
    await Comment.destroy({ where: { commentId: req.params.commentId } });
    return res.status(200).send();
  } catch (error) {
    return res.status(400).json({ message: 'Error' });
  }
};

export default { create, read, update, del };
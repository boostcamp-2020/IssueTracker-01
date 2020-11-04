import Issue from '@models/issueModel';
import IssueLabel from '@models/issueLabelModel';
import User from '@models/userModel';
import Label from '@models/labelModel';
import Milestone from '@models/milestoneModel';
import Comment from '@models/commentModel';

const updateAssignee = async (req, res) => {
  try {
    const { issueId } = req.params;

    await Issue.update(
      {
        assignees: req.body.userId,
      },
      {
        where: { issueId: issueId },
      },
    );

    return res.status(200).json({ message: 'success' });
  } catch (error) {
    return res.status(400).json({ message: error.message });
  }
};

const addLabel = async (req, res) => {
  try {
    const { issueId } = req.params;
    const newData = {
      issueId: issueId,
      labelName: req.body.labelName,
    };

    await IssueLabel.create(newData);

    return res.status(200).json({ message: 'success' });
  } catch (error) {
    return res.status(400).json({ message: error.message });
  }
};

const removeLabel = async (req, res) => {
  try {
    const { issueId } = req.params;

    await IssueLabel.destroy({
      where: { issueId: issueId, name: req.body.labelName },
    });

    return res.status(200).json({ message: 'success' });
  } catch (error) {
    return res.status(400).json({ message: error.message });
  }
};

const removeAllLabel = async (req, res) => {
  try {
    const { issueId } = req.params;

    await IssueLabel.destroy({
      where: { issueId: issueId },
    });

    return res.status(200).json({ message: 'success' });
  } catch (error) {
    return res.status(400).json({ message: error.message });
  }
};

const updateIssueStatus = async (req, res, next) => {
  try {
    const { status, issueId } = req.params;

    await Issue.update(
      {
        isOpen: status,
      },
      {
        where: { issueId: issueId },
      },
    );

    return res.status(200).json({ message: 'success' });
  } catch (error) {
    return res.status(400).json({ message: error.message });
  }
};

const updateTitle = async (req, res, next) => {
  try {
    const { issueId } = req.params;
    const { title } = req.body;
    await Issue.update(
      {
        title,
      },
      { where: { issueId: issueId } },
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
    const { issueId } = req.params;
    const { milestoneId } = req.body;
    await Issue.update(
      {
        milestoneId: milestoneId || null,
      },
      { where: { issueId: issueId } },
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

const create = async (req, res) => {
  try {
    const data = {
      title: req.body.title,
      userId: req.user.dataValues.userId,
      assignees: req.body.assignees,
      milestoneId: req.body.milestoneId,
    };
    console.log(data);
    const { issueId } = await Issue.create(data);
    const label = req.body.label;
    console.log(label);
    if (label.length) {
      label.forEach(async (name) => {
        await IssueLabel.create({ issueId, name });
      });
    }
    return res.status(200).json({ message: 'Success' });
  } catch (error) {
    return res.status(400).json({ message: 'Error' });
  }
};

const detailIssue = async (req, res) => {
  try {
    const { issueId } = req.params;
    const data = await Issue.findOne({
      include: [
        {
          model: User,
        },
        {
          model: IssueLabel,
        },
        {
          model: Milestone,
          attributes: ['title'],
          include: [
            {
              model: Issue,
              attributes: ['isOpen'],
            },
          ],
        },
        {
          model: Comment,
          include: [
            {
              model: User,
            },
          ],
        },
      ],
      where: { issueId: issueId },
    });
    return res.status(200).json(data);
  } catch (error) {
    console.log(error.message);
    return res.status(400).json({ message: 'Error' });
  }
};

const getIssueLists = async (req, res, next) => {
  try {
    const filters = req.query.q;
    const { userId } = req.user;
    let issueList = await Issue.findAll({
      attributes: ['title', 'issueId', 'createdAt', 'isOpen'],
      include: [
        {
          model: User,
          attributes: ['userId', 'profile_url'],
          as: 'UserAuthor',
        },
        {
          model: User,
          attributes: ['userId', 'profile_url'],
          required: false,
        },
        {
          model: IssueLabel,
          include: [{ model: Label, attributes: ['labelName', 'color'] }],
          attributes: ['id'],
        },
        {
          model: Milestone,
          attributes: ['title'],
        },
        {
          model: Comment,
          attributes: ['commentId', 'userId'],
          where: { userId },
          required: false,
        },
      ],
    });

    filters?.split(' ').forEach((filter) => {
      const [target, condition] = filter.split(':');
      if (target === 'is' && condition === 'open') {
        issueList = issueList.filter((issue) => issue.isOpen === 1);
      } else if (target === 'is' && condition === 'close') {
        issueList = issueList.filter((issue) => issue.isOpen === 0);
      } else if (target === 'author' && condition === '@me') {
        issueList = issueList.filter((issue) => issue.UserAuthor?.userId === userId);
      } else if (target === 'comment' && condition === '@me') {
        issueList = issueList.filter((issue) => issue.Comments.length > 0);
      } else if (target === 'assignee' && condition === '@me') {
        issueList = issueList.filter((issue) => issue.User?.userId === userId);
      }
    });
    res.json(issueList);
  } catch (err) {
    console.log(err);
    next({
      status: 400,
      message: err.message,
    });
  }
};

export default {
  create,
  updateTitle,
  updateMilestone,
  updateAssignee,
  addLabel,
  removeLabel,
  removeAllLabel,
  getIssueLists,
  detailIssue,
  updateIssueStatus,
};

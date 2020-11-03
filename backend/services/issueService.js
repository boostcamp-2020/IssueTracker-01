// TODO - 이슈 서비스 작성
import Issue from '@models/issueModel';
import User from '@models/userModel';
import IssueLabel from '@models/issueLabelModel';

const getAssigneeCandidates = async (req, res) => {
    try {
        const result = await User.findAll({attributes: ['userId', 'profile_url']});
        
        return res.status(200).json({ data: result, message: "success" });
    } catch (error) {
        return res.status(400).json({ message: error.message });
    }
}

const changeAssignee = async (req, res) => {
    const { id } = req.params;

    try {
        const result = await Issue.update({
            assignees: req.body.userId
          },
          {
            where: { issueId: id },
          }
        );
        
        return res.status(200).json({ data: result, message: "success" });
    } catch (error) {
        return res.status(400).json({ message: error.message });
    }
}

const addLabel = async (req, res) => {
    try {
      const { id } = req.params;
      const newData = {
        issueId: id,
        name: req.body.name
      };
      const result = await IssueLabel.create(newData);

      return res.status(200).json({ data: result, message: "success" });
    } catch (error) {
      return res.status(400).json({ message: error.message });
    }
}

const removeLabel = async (req, res) => {
    try {
        const { id } = req.params;

        const result = await IssueLabel.destroy({
            where: { issueId: id, name: req.body.labelName }
        });
  
        return res.status(200).json({ data: result, message: "success" });
      } catch (error) {
        return res.status(400).json({ message: error.message });
    }
}

const removeAllLabel = async (req, res) => {
    try {
        const { id } = req.params;

        const result = await IssueLabel.destroy({
            where: { issueId: id }
        });
  
        return res.status(200).json({ data: result, message: "success" });
      } catch (error) {
        return res.status(400).json({ message: error.message });
    }
}

export default { getAssigneeCandidates, changeAssignee, addLabel, removeLabel, removeAllLabel };

import Label from '../models/labelModel';

exports.getLabels = async (req, res) => {
  try {
    const labels = await Label.readLabels();

    if (labels !== false) {
      return res.status(200).json({ data: labels, message: 'success' });
    }

    return res.status(400).json({ message: 'unexpected fail' });
  } catch (error) {
    return res.status(500).json({ message: error.message });
  }
};

exports.createLabel = async (req, res) => {
  try {
    const isExist = await Label.isExist(req.body.name);

    if (!isExist) {
      const newLabel = {
        labelName: req.body.name,
        color: req.body.color,
        description: req.body.desc,
      };

      const result = await Label.createLabel(newLabel);

      if (result) {
        return res.status(200).json({ data: result, message: 'success' });
      }

      return res.status(400).json({ message: 'unexpected fail' });
    }

    return res.status(400).json({ message: 'name already exists.' });
  } catch (error) {
    return res.status(500).json({ message: error.message });
  }
};

exports.updateLabel = async (req, res) => {
  try {
    const isExist = await Label.isExist(req.body.newName);

    if (!isExist) {
      const result = await Label.updateLabel(req.body.curName, req.body.newName, req.body.color, req.body.desc);

      if (result !== false) {
        return res.status(200).json({ message: 'success.' });
      }

      return res.status(400).json({ message: 'unexpected fail' });
    }

    return res.status(400).json({ message: 'This name already exists.' });
  } catch (error) {
    return res.status(500).json({ message: error.message });
  }
};

exports.deleteLabel = async (req, res) => {
  try {
    const result = await Label.deleteLabel(req.body.name);

    if (result) {
      return res.status(200).json({ message: 'success.' });
    }

    return res.status(400).json({ message: 'The label does not exist.' });
  } catch (error) {
    return res.status(500).json({ message: error.message });
  }
};

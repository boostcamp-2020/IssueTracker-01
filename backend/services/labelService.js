import Label from '../models/labelModel';

exports.getLabels = async (req, res) => {
  try {
    const labels = await Label.findAll();

    return res.status(200).json({ data: labels, message: 'success' });
  } catch (error) {
    return res.status(400).json({ message: error.message });
  }
};

exports.createLabel = async (req, res) => {
  try {
    const newLabel = {
      labelName: req.body.labelName,
      color: req.body.color,
      description: req.body.desc,
    };

    const result = await Label.create(newLabel);

    return res.status(200).json({ data: result, message: 'success' });
  } catch (error) {
    return res.status(400).json({ message: error.message });
  }
};

exports.updateLabel = async (req, res) => {
  try {
    await Label.update(
      {
        labelName: req.body.newName,
        color: req.body.color,
        description: req.body.desc,
      },
      {
        where: { labelName: req.body.labelName },
      },
    );

    return res.status(200).json({ message: 'success.' });
  } catch (error) {
    return res.status(400).json({ message: error.message });
  }
};

exports.deleteLabel = async (req, res) => {
  try {
    await Label.destroy({
      where: { labelName: req.params.labelName },
    });

    return res.status(200).json({ message: 'success.' });
  } catch (error) {
    return res.status(400).json({ message: error.message });
  }
};

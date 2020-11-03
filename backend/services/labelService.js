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
    // const isExist = await Label.findOne({ where: { labelName: req.body.name } });

    // if (!isExist) {
    const newLabel = {
      labelName: req.body.name,
      color: req.body.color,
      description: req.body.desc,
    };

    const result = await Label.create(newLabel);

    return res.status(200).json({ data: result, message: 'success' });
    // }

    // return res.status(409).json({ message: 'This name already exists.' });
  } catch (error) {
    return res.status(400).json({ message: error.message });
  }
};

exports.updateLabel = async (req, res) => {
  try {
    // const isExist = await Label.findOne({ where: { labelName: req.body.newName } });

    // if (!isExist) {
    await Label.update(
      {
        labelName: req.body.newName,
        color: req.body.color,
        description: req.body.desc,
      },
      {
        where: { labelName: req.body.curName },
      },
    );

    return res.status(200).json({ message: 'success.' });
    // }

    // return res.status(409).json({ message: 'This name already exists.' });
  } catch (error) {
    return res.status(400).json({ message: error.message });
  }
};

exports.deleteLabel = async (req, res) => {
  try {
    await Label.destroy({
      where: { labelName: req.body.name },
    });

    return res.status(200).json({ message: 'success.' });
  } catch (error) {
    return res.status(400).json({ message: error.message });
  }
};

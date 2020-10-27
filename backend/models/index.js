const Sequelize = require('sequelize');
const env = process.env.NODE_ENV || 'development';
const config = require('../config/db.config')[env];

const User = require('./userModel');
const Milestone = require('./milestoneModel');
const Label = require('./labelModel');
const Issue = require('./issueModel');
const IssueLabel = require('./issueLabelModel');
const Comment = require('./commentModel');

const db = {};
const sequelize = new Sequelize(config.database, config.username, config.password, config);

db.sequelize = sequelize;
db.User = User;
db.Milestone = Milestone;
db.Label = Label;
db.Issue = Issue;
db.IssueLabel = IssueLabel;
db.Comment = Comment;

User.init(sequelize);
Milestone.init(sequelize);
Label.init(sequelize);
Issue.init(sequelize);
IssueLabel.init(sequelize);
Comment.init(sequelize);

Issue.associate(db);
IssueLabel.associate(db);
Comment.associate(db);

module.exports = db;

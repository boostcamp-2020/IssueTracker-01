import Sequelize from 'sequelize';

import Comment from './commentModel';
import User from './userModel';
import Milestone from './milestoneModel';
import Label from './labelModel';
import Issue from './issueModel';
import IssueLabel from './issueLabelModel';

import dbconfig from '../config/db.config';

const env = process.env.NODE_ENV || 'development';
const config = dbconfig[env];

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
Milestone.associate(db);
IssueLabel.associate(db);
Comment.associate(db);

module.exports = db;

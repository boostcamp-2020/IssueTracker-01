import React from 'react';
import { Route } from 'react-router-dom';

import Login from './pages/Login';
import IssueMain from '@pages/IssueMain';
import Label from '@pages/Label';
import IssueAdding from './pages/IssueAdding';
import Milestone from './pages/Milestone';
import MilestoneAdding from './pages/MilestoneAdding';
import MilestoneEditing from './pages/MilestoneEditing';
import DetailIssue from './pages/DetailIssue';

import { UserProvider } from './contexts/user';
import { LabelProvider } from '@contexts/label';
import UserListProvider from './contexts/userList';
import SelectionProvider from './contexts/selection';
import MilestoneProvider from './contexts/milestone';

const App = () => {
  return (
    <UserProvider>
      <LabelProvider>
        <Route path="/" component={Login} exact />
        <Route path="/label" component={Label} />
        <MilestoneProvider>
          <Route path="/milestone" exact={true} component={Milestone} />
          <Route path="/milestone-add" component={MilestoneAdding} />
          <Route path="/milestone-edit" component={MilestoneEditing} />
          <UserListProvider>
            <SelectionProvider>
              <Route path="/issue-add" component={IssueAdding} />
            </SelectionProvider>
            <Route path="/main" component={IssueMain} />
          </UserListProvider>
        </MilestoneProvider>
      </LabelProvider>
      <Route path="/detailIssue/:issueId" component={DetailIssue} />
    </UserProvider>
  );
};

export default App;

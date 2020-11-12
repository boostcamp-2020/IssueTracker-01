import React from 'react';
import { Route } from 'react-router-dom';

import Login from './pages/Login';
import Main from './pages/Main';
<<<<<<< HEAD
import Label from '@pages/Label';
import IssueAdding from './pages/IssueAdding';
import Milestone from './pages/Milestone';
import MilestoneAdding from './pages/MilestoneAdding';
import MilestoneEditing from './pages/MilestoneEditing';

import { UserProvider } from './contexts/user';
import { LabelProvider } from '@contexts/label';
import UserListProvider from './contexts/userList';
import SelectionProvider from './contexts/selection';
import MilestoneProvider from './contexts/milestone';
=======
import DetailIssue from './pages/DetailIssue';
>>>>>>> feature/detailIssuePage

const App = () => {
  return (
    <UserProvider>
<<<<<<< HEAD
      <LabelProvider>
        <Route path="/" component={Login} exact />
        <Route path="/label" component={Label} />
        <MilestoneProvider>
          <Route path="/milestone" exact={true} component={Milestone}/>
          <Route path="/milestone-add" component={MilestoneAdding}/>
          <Route path="/milestone-edit" component={MilestoneEditing}/>
          <UserListProvider>
            <SelectionProvider>
              <Route path="/issue-add" component={IssueAdding}/>
            </SelectionProvider>
            <Route path="/main" component={Main} />
          </UserListProvider>
        </MilestoneProvider>
      </LabelProvider>
=======
      <Route path="/" component={Login} exact />
      <Route path="/main" component={Main} />
      <Route path="/detailIssue/:issueId" component={DetailIssue} />
>>>>>>> feature/detailIssuePage
    </UserProvider>
  );
};

export default App;

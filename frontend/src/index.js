import React from "react";
import ReactDom from "react-dom";
import { BrowserRouter, Route } from 'react-router-dom';

import IssueAdding from './pages/IssueAdding';
import UserListProvider from './contexts/userList';
import SelectionProvider from './contexts/selection';

import Milestone from './pages/Milestone';
import MilestoneAdding from './pages/MilestoneAdding';
import MilestoneEditing from './pages/MilestoneEditing';
import MilestoneProvider from './contexts/milestone';

ReactDom.render(
    <BrowserRouter>
      <MilestoneProvider>
        <Route path="/milestone" exact={true} component={Milestone}/>
        <Route path="/milestone-add" component={MilestoneAdding}/>
        <Route path="/milestone-edit" component={MilestoneEditing}/>
        <UserListProvider>
          <SelectionProvider>
            <Route path="/issue-add" component={IssueAdding}/>
          </SelectionProvider>
        </UserListProvider>
      </MilestoneProvider>
    </BrowserRouter>,
    document.getElementById('root')
  );

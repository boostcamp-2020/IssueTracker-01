import React from "react";
import ReactDom from "react-dom";
import { BrowserRouter, Route } from 'react-router-dom';
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
      </MilestoneProvider>
    </BrowserRouter>,
    document.getElementById('root')
  );

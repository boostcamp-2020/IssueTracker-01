import React from 'react';
import IssueList from '@templates/IssueList';
import IssueButtons from '@templates/IssueButtons';

const IssueMain = ({ history }) => {
  return (
    <div>
      <IssueButtons />
      <IssueList history={history} />
    </div>
  );
};

export default IssueMain;

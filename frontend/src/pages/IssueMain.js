import React from 'react';
import IssueList from '@templates/IssueList';
import IssueButtons from '@templates/IssueButtons';

const IssueMain = () => {
  return (
    <div>
      <IssueButtons />
      <IssueList />
    </div>
  );
};

export default IssueMain;

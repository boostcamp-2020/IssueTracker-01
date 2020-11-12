import React from 'react';
import styled from 'styled-components';
import ListHead from '@components/label/ListHead';
import IssueList from '@components/issue/IssueList';
import { useIssueState } from '@contexts/issue';

const LabelList = () => {
  const issues = useIssueState();
  return (
    <div>
      <ListHead>
        <input type="checkbox" />
        <div>assignee</div>
      </ListHead>
      <IssueList items={issues} keys={issues.map((issue) => issue.issueId)} />
    </div>
  );
};

export default LabelList;

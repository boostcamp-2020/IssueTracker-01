import React from 'react';
import styled from 'styled-components';
import IssueAddingMain from '../organisms/issue/IssueAddingMain';
import IssueAddingSideBar from '../organisms/issue/IssueAddingSideBar';

const Page = styled.div`
  display: flex;
  flex-direction: row;
  padding: 10px;
`;

const IssueAdding = () => {
  return (
    <Page>
      <IssueAddingMain />
      <IssueAddingSideBar />
    </Page>
  );
};

export default IssueAdding;

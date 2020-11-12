import React from 'react';
import styled from 'styled-components';
import IssueFilter from '@components/issue/IssueFilter';
import TabButton from '@components/label/TabButton';
import GreenButton from '@components/utils/GreenButton';

const IssueButtons = () => {
  return (
    <FlexDiv>
      <IssueFilter />
      <Buttons>
        <TabButton />
        <GreenButton text="New Issue" />
      </Buttons>
    </FlexDiv>
  );
};

const FlexDiv = styled.div`
  display: flex;
  margin-bottom: 16px;
`;

const Buttons = styled.div`
  display: flex;
  margin-left: 8px;
  padding-left: 8px;
  justify-content: flex-end;
`;

export default IssueButtons;

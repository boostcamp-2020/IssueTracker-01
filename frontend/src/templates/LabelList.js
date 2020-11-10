import React from 'react';
import styled from 'styled-components';
import ListHead from '@components/ListHead';
import LabelCount from '@components/LabelCount';
import List from '@components/List';
import { useLabelState } from '@contexts/label';

const SummaryDiv = styled.div`
  color: #586069;
  font-size: 14px;
`;

const LabelList = () => {
  const labels = useLabelState();
  return (
    <div>
      <ListHead>
        <LabelCount count={1} />
        <SummaryDiv>Sort</SummaryDiv>
      </ListHead>
      <List items={labels} />
    </div>
  );
};

export default LabelList;

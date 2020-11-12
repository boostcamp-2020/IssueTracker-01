import React from 'react';
import styled from 'styled-components';
import ListHead from '@components/label/ListHead';
import LabelCount from '@components/label/LabelCount';
import List from '@components/utils/List';
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
      <List items={labels} keys={labels.map((label) => label.labelName)} />
    </div>
  );
};

export default LabelList;

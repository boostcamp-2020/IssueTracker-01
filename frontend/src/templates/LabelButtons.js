import React from 'react';
import styled from 'styled-components';
import TabButton from '@components/TabButton';
import GreenButton from '@components/GreenButton';
import LabelCreate from '@components/LabelCreate';

const FlexDiv = styled.div`
  display: flex;
  justify-content: space-between;
  margin-bottom: 20px;
`;

const LabelButtons = () => {
  return (
    <div>
      <FlexDiv>
        <TabButton />
        <GreenButton text={'New label'} />
      </FlexDiv>
      <LabelCreate />
    </div>
  );
};

export default LabelButtons;

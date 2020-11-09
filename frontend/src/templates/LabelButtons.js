import React from 'react';
import styled from 'styled-components';
import TabButton from '@components/TabButton';
import GreenButton from '@components/GreenButton';

const FlexDiv = styled.div`
  display: flex;
  justify-content: space-between;
`;

const LabelButtons = () => {
  return (
    <FlexDiv>
      <TabButton />
      <GreenButton text={'New label'} />
    </FlexDiv>
  );
};

export default LabelButtons;

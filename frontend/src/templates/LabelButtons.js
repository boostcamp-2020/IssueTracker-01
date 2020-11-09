import React from 'react';
import styled from 'styled-components';
import TabButton from '@components/TabButton';
import Button from '@components/Button';

const FlexDiv = styled.div`
  display: flex;
  justify-content: space-between;
`;

const LabelButtons = () => {
  return (
    <FlexDiv>
      <TabButton />
      <Button text={'New label'} />
    </FlexDiv>
  );
};

export default LabelButtons;

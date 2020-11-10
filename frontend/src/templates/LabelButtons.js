import React, { useState } from 'react';
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
  const [hide, setHide] = useState(true);
  const onClick = (e) => {
    e.preventDefault();
    setHide(!hide);
  };
  return (
    <div>
      <FlexDiv>
        <TabButton />
        <GreenButton text={'New label'} onClick={(e) => onClick(e)} />
      </FlexDiv>
      <LabelCreate hide={hide} onClick={onClick} />
    </div>
  );
};

export default LabelButtons;
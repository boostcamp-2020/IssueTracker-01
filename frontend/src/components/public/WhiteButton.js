import React from 'react';
import styled from 'styled-components';

const ButtonDiv = styled.div`
  margin: 3px 7px;
`;

const StyledButton = styled.button`
  font-size: 14px;
  font-weight: 500;
  line-height: 20px;
  vertical-align: middle;
  padding: 5px 16px;
  background-color: #fafbfc;
  color: #24292e;
  box-shadow: 0 1px 0 rgba(27, 31, 35, 0.04), inset 0 1px 0 hsla(0, 0%, 100%, 0.25);
  border-color: rgba(27, 31, 35, 0.15);
  border: 1px solid;
  border-radius: 6px;
`;

const WhiteButton = ({ text, onClick }) => {
  return (
    <ButtonDiv>
      <StyledButton onClick={onClick}>{text}</StyledButton>
    </ButtonDiv>
  );
};

export default WhiteButton;

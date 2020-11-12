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
  background-color: #2ea44f;
  color: #fff;
  box-shadow: 0 1px 0 rgba(27, 31, 35, 0.1), inset 0 1px 0 hsla(0, 0%, 100%, 0.03);
  border: 1px solid;
  border-color: rgba(27, 31, 35, 0.15);
  border-radius: 6px;
`;

const GreenButton = ({ type, text, onClick }) => {
  return (
    <ButtonDiv>
      <StyledButton type={type || 'button'} onClick={onClick}>
        {text}
      </StyledButton>
    </ButtonDiv>
  );
};

export default GreenButton;

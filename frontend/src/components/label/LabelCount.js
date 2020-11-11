import React from 'react';
import styled from 'styled-components';

const StyledDiv = styled.div`
  font-size: 14px;
  font-weight: 600;
`;

const LabelCount = ({ count }) => {
  return <StyledDiv>{count} labels </StyledDiv>;
};

export default LabelCount;

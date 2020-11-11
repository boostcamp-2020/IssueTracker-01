import React from 'react';
import styled from 'styled-components';
import { GoRepo } from 'react-icons/go';

const Box = styled.div`
  width: 100vw;
  background: #24292f;
  display: flex;
  justify-content: center;
  align-items: center;
  p {
    color: white;
    font-weight: 600;
  }
`;
const Header = () => {
  return (
    <Box>
      <GoRepo style={{ color: 'white' }} />
      <p>ISSUES</p>
    </Box>
  );
};

export default Header;

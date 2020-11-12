import React from 'react';
import styled from 'styled-components';

const FlexDiv = styled.div`
  display: flex;
  padding: 16px;
  background-color: #f6f8fa;
  justify-content: space-between;
`;

const ListHead = ({ children }) => {
  return <FlexDiv>{children}</FlexDiv>;
};

export default ListHead;

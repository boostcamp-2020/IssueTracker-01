import React from 'react';
import styled from 'styled-components';
import SVG from './SVG';

const FlextDiv = styled.div`
  display: flex;
  align-items: center;
`;

const TabBorder = styled.nav`
  border: 1px solid #e1e4e8;
  border-radius: 6px;
  padding: 5px 16px;
`;

const TabButton = ({}) => {
  return (
    <FlextDiv>
      <TabBorder>
        <a>
          <SVG name="labelImage" size="16" />
          Labels
        </a>
        <a>
          <SVG name="milestoneImage" size="16" />
          Milestones
        </a>
      </TabBorder>
    </FlextDiv>
  );
};

export default TabButton;

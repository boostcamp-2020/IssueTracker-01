import React from 'react';
import styled from 'styled-components';
import SVG from './SVG';

const FlextDiv = styled.div`
  display: flex;
  align-items: center;
`;

const TabBorder = styled.nav``;

const Button = styled.a`
  padding: 0 10px;
  border: 1px solid #e1e4e8;
  padding: 5px 16px;
  &:first-child {
    border-top-left-radius: 6px;
    border-bottom-left-radius: 6px;
  }

  &:last-child {
    border-top-right-radius: 6px;
    border-bottom-right-radius: 6px;
  }
`;

const TabButton = ({ active }) => {
  return (
    <FlextDiv>
      <TabBorder>
        <Button>
          <SVG name="labelImage" size="16" />
          Labels
        </Button>
        <Button>
          <SVG name="milestoneImage" size="16" />
          Milestones
        </Button>
      </TabBorder>
    </FlextDiv>
  );
};

export default TabButton;

import React from 'react';
import styled from 'styled-components';
import SVG from '../utils/SVG';

const FlextDiv = styled.div`
  display: flex;
  align-items: center;
`;

const TabBorder = styled.nav``;

const Button = styled.a`
  padding: 0 10px;
  border: 1px solid #e1e4e8;
  padding: 5px 16px;

  &:link {
    text-decoration: none;
    color: #24292e;
  }
  &:first-child {
    border-top-left-radius: 6px;
    border-bottom-left-radius: 6px;
  }

  &:last-child {
    border-top-right-radius: 6px;
    border-bottom-right-radius: 6px;
  }
`;

const TabButton = () => {
  return (
    <FlextDiv>
      <TabBorder>
        <Button href="/label">
          <SVG name="labelImage" size="16" />
          Labels
        </Button>
        <Button href="/milestone">
          <SVG name="milestoneImage" size="16" />
          Milestones
        </Button>
      </TabBorder>
    </FlextDiv>
  );
};

export default TabButton;

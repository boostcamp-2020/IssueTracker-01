import React from 'react';
import styled from 'styled-components';

const FilterButton = () => {
  return <SummaryButton>Filters</SummaryButton>;
};

const SummaryButton = styled.summary`
  color: #24292e;
  background-color: #fafbfc;
  border: 1px solid rgba(27, 31, 35, 0.15);
  border-top-left-radius: 6px;
  border-bottom-left-radius: 6px;
  box-shadow: 0 1px 0 rgba(27, 31, 35, 0.04), inset 0 1px 0 hsla(0, 0%, 100%, 0.25);
  padding: 5px 16px;
  font-size: 14px;
  font-weight: 500;
  line-height: 20px;
  vertical-align: middle;
`;

export default FilterButton;

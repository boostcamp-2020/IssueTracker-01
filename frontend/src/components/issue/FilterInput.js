import React from 'react';
import styled from 'styled-components';
import SVG from '@components/utils/SVG';
import { loadIssues, useIssueDispatch } from '@contexts/issue';

const FilterButton = () => {
  const dispatch = useIssueDispatch();
  const handleKeyPress = (e) => {
    if (e.key === 'Enter') {
      const { value } = e.target;
      console.log(value);
      loadIssues(dispatch, `q=${value}`);
    }
  };
  return <FilterInput placeholder="Search all issues" defaultValue="is:open" onKeyPress={handleKeyPress} />;
};

const FilterInput = styled.input`
  width: 100%;
  padding-left: 32px;

  color: #586069;
  background-color: #fafbfc;
  border: 1px solid #e1e4e8;
  border-top-right-radius: 6px;
  border-bottom-right-radius: 6px;
  box-shadow: 0 1px 0 rgba(27, 31, 35, 0.04), inset 0 1px 0 hsla(0, 0%, 100%, 0.25);
  padding: 5px 12px;
  font-size: 14px;
  font-weight: 500;
  line-height: 20px;
  vertical-align: middle;
`;

export default FilterButton;

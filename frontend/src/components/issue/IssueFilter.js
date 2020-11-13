import React from 'react';
import styled from 'styled-components';
import FilterButton from '@components/issue/FilterButton';
import FilterInput from '@components/issue/FilterInput';

const IssueFilter = () => {
  return (
    <FlexDiv>
      <FilterButton />
      <FilterInput />
    </FlexDiv>
  );
};

const FlexDiv = styled.div`
  display: flex;
  flex: 2;
`;

export default IssueFilter;

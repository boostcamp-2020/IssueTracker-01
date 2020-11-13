import React from 'react';
import styled from 'styled-components';

const HeaderLayout = styled.div`
    margin-top: 50px;
    margin-bottom: 50px
`;

const HeaderDesc = styled.p`
    font-size: 14px;
`;

const MilestoneAddHeader = () => {
    return <HeaderLayout>
        <h2> New milestone </h2>
        <HeaderDesc>Create a new milestone to help organize your issues and pull requests</HeaderDesc>
    </HeaderLayout>
}

export default MilestoneAddHeader;

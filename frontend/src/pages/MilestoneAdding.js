import React from 'react';
import styled from 'styled-components';
import MilestoneAddHeader from '../organisms/milestone/MilestoneAddHeader';
import MilestoneAddFrom from '../organisms/milestone/MilestoneAddFrom';

const MainLayout = styled.div`
  width: 78%;
  margin: 0 auto;
`;

const MilestoneAdding = () => {
  return <MainLayout>
    <MilestoneAddHeader/>
    <MilestoneAddFrom/>
  </MainLayout>
};

export default MilestoneAdding;

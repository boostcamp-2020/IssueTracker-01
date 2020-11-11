import React from 'react';
import styled from 'styled-components';
import MilestoneEditFrom from '../organisms/milestone/MilestoneEditFrom';

const EditLayout = styled.div`
  width: 78%;
  margin: 0 auto;
`;

const MilestoneEditing = () => {
    const id = window.location.search.replace('?', '');

    return <EditLayout>
        <MilestoneEditFrom id={id}/>
    </EditLayout>
};

export default MilestoneEditing;

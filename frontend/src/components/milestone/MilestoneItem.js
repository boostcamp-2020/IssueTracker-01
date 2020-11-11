import React, { useContext } from 'react';
import styled from 'styled-components';
import MilestoneTitle from '../../components/milestone/MilestoneTitle';
import MilestoneProgress from '../../components/milestone/MilestoneProgress';

const Item = styled.li`
    display: flex;
    flex-direction: row;
    margin: 0;
    padding: 0;
`;

const MilestoneItem = (props) => {
    return <Item>
        <MilestoneTitle data={props.item}/>
        <MilestoneProgress issues={props.item.Issues} index={props.index} id={props.item.milestoneId} data={props.item}/>
    </Item>
}

export default MilestoneItem;

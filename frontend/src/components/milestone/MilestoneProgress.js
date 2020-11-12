import React, { useContext, useRef } from "react";
import styled from 'styled-components';
import axios from 'axios';
import { MilestoneDispatchContext } from '../../contexts/milestone';
import MilestoneGraph, { getStats } from './MilestoneGraph';

const ProgressLayout = styled.div`
    flex: 0.45;
    display: flex;
    flex-direction: column;
`;

const Stats = styled.div`
    flex: 1;
    font-weight: lighter;
`;

const Btns = styled.div`
    flex: 1;
`;

const EditBtn = styled.button`
    font-weight: lighter;
    border: none;
    color: #0366de;
    background-color: rgba(0, 0, 255, 0);
    padding-left: 0;
    outline: none;

    &:hover {
        text-decoration: underline;.
      }
`;
const CloseBtn = styled.button`
    font-weight: lighter;
    border: none;
    color: #0366de;
    background-color: rgba(0, 0, 255, 0);
    outline: none;

    &:hover {
        text-decoration: underline;
      }
`;
const DeleteBtn = styled.button`
    font-weight: lighter;
    color: red;
    border: none;
    background-color: rgba(0, 0, 255, 0);
    outline: none;

    &:hover {
        font-weight: bold;
      }
`;

const MilestoneProgress = (props) => {
    const issues = props.issues;
    const milestoneId = props.id;
    const index = props.index;
    const stats = getStats(issues);
    const milestoneRef = useRef();

    const dispatch = useContext(MilestoneDispatchContext);
    console.log(milestoneId);
    const EditCilcked = () => {
        window.location.href = `http://localhost:8080/milestone-edit?${index}`;
    }

    const DeleteClicked = async () => {
        const result = await axios.delete('http://localhost:3000/api/milestone/' + milestoneId);
        
        if (result.status === 200) {
            dispatch({type: "delete", milestoneId: milestoneId});
        } else {
            alert("에러");
        }
    }

    return <ProgressLayout ref={milestoneRef}>
        <MilestoneGraph issues={issues}/>
        <Stats> {stats.per}% complete {stats.open} open {stats.close} closed</Stats>
        <Btns>
            <EditBtn onClick={EditCilcked}>Edit</EditBtn>
            <CloseBtn>Close</CloseBtn>
            <DeleteBtn onClick={DeleteClicked}>Delete</DeleteBtn>
        </Btns>
    </ProgressLayout>
}

export default MilestoneProgress;

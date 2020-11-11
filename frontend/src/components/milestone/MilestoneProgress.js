import React, { useContext, useRef } from "react";
import styled, { css } from 'styled-components';
import axios from 'axios';
import { MilestoneDispatchContext } from '../../contexts/milestone';


const ProgressLayout = styled.div`
    flex: 0.45;
    display: flex;
    flex-direction: column;
`;

const GraphArea = styled.span`
    height: 10px;
    flex: 1;
    padding-right: 20px;
`;

const GraphDiv = styled.div`
    width: 100%;
    height: 10px;
    margin: 0;
    margin-top: 10px;
    background-color: #e1e4e8;
    border-radius: 10px;
`;

const Graph = styled.div`
    width: 0%;
    height: 10px;
    margin: 0;
    margin-top: 10px;
    background-color: #28a745;
    border-radius: 10px;

    ${(props) =>
        props.per &&
        css`
          width: ${props.per}%;
        `}
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

const getStats = (issues) => {
    if (!issues.length) return { per: 0, open: 0, close: 0 }

    let open = 0;
    let close = 0;

    issues.forEach((issue) => {
        if(issue.isOpen) {
            open++;
        } else {
            close++;
        }
    })

    const per = close / (open + close) * 100;

    return { per: per, open: open, close: close }
}

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
        <GraphArea><GraphDiv><Graph per={stats.per} /></GraphDiv></GraphArea>
        <Stats> {stats.per}% complete {stats.open} open {stats.close} closed</Stats>
        <Btns>
            <EditBtn onClick={EditCilcked}>Edit</EditBtn>
            <CloseBtn>Close</CloseBtn>
            <DeleteBtn onClick={DeleteClicked}>Delete</DeleteBtn>
        </Btns>
    </ProgressLayout>
}

export default MilestoneProgress;

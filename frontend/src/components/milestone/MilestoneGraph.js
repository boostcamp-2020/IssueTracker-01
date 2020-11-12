import React from "react";
import styled, { css } from 'styled-components';

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

export const getStats = (issues) => {
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

const MilestoneGraph = (props) => {
    if (!props.issues && !props.per) return null;
    else {
        if (props.issues) {
            const stats = getStats(props.issues);
    
            return <GraphArea><GraphDiv><Graph per={stats.per} /></GraphDiv></GraphArea>;
        }

        return <GraphArea><GraphDiv><Graph per={props.per} /></GraphDiv></GraphArea>;
    }
}

export default MilestoneGraph;

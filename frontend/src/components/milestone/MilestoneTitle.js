import React from 'react';
import styled from 'styled-components';
import clockIcon from '../../../public/icon/clock.png' 

const TitleCell = styled.div`
    flex: 0.55;
    display: flex;
    flex-direction: column;
`;

const MilestoneMeta = styled.div`
    display: flex;
    flex-direction: row;
`;

const MilestoneMetaDueDate = styled.span`
    font-size: 0.95em;
    color: gray;
    font-weight: lighter;
`;

const MilestoneMetaUpdateDate = styled.span`
    font-size: 0.95em;
    color: gray;
    font-weight: lighter;
    padding-left: 20px
`;

const TitleLink = styled.a`
    font-size: 1.6em;
    width: fit-content;
    margin-bottom: 10px;
    text-decoration: none;
    color: black;

    &:hover {
        color: #0366de;
        text-decoration: underline;
    }
`;

const titleStyle = {
    fontSize: "1.6em",
    width: "fit-content",
    marginBottom: "10px",
    textDecoration: "none"
}

const Desc = styled.p`
    margin-top: 10px;
`;

const ClockImg = styled.img`
    width: 16px;
    height: 16px;
    margin-right: 5px;
`;

const month = ["January", "February", "March", "April", "May", "June",
  "July", "August", "September", "October", "November", "December"
];

const getDateFrom = (date) => {
    return month[date.getMonth()] + " " + date.getDate() + ", " + date.getFullYear();
}

const getElapsedTime = (date) => {
    const time = new Date(date).getTime();
    let result = Date.now() - time;

    if ((result / 1000) < 60) {
        result = parseInt(result / 1000) + " second";
    } else if ((result / 1000 / 60) < 60) {
        result = parseInt(result / 1000 / 60) + " minute";
    } else if ((result / 1000 / 60 / 60) < 60){
        result = parseInt(result / 1000 / 60 / 60) + " hour";
    } else {
        result = parseInt(result / 1000 / 60 / 60) + " day";
    }

    
    return result;
}

const MilestoneTitle = (props) => {
    const data = props.data;
    let dueDate = new Date(data.dueDate);
    
    if (data.dueDate) {
        dueDate = "Due by " + getDateFrom(dueDate);
    } else {
        dueDate = "No due date"
    }

    const updateDate = getElapsedTime(data.updatedAt);

    return <TitleCell>
        <TitleLink href="http://localhost:8080/milestone-add">{data.title}</TitleLink>
        <MilestoneMeta>
            <MilestoneMetaDueDate>{dueDate}</MilestoneMetaDueDate>
            <MilestoneMetaUpdateDate>
                <ClockImg src={clockIcon}/>
                Last updated about {updateDate} ago
            </MilestoneMetaUpdateDate>
        </MilestoneMeta>
        <Desc>{data.description}</Desc>
    </TitleCell>;
}

export default MilestoneTitle;

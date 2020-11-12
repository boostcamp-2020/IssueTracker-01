import React from 'react';
import styled from 'styled-components';
import calendarIcon from '../../../public/icon/calendar.png'

const MilestoneMetaDueDate = styled.div`
    display: flex;
    flex-direction: row;
    font-size: 0.95em;
`;

const CalendarIcon = styled.img`
    width: 16px;
    height: 16px;

    margin-right:5px;
    padding-top: 3px;
`;

const DueDateText = styled.p`
    margin: 0 auto;

color: gray;
font-weight: lighter;
`;

const month = ["January", "February", "March", "April", "May", "June",
  "July", "August", "September", "October", "November", "December"
];

const getDateFrom = (date) => {
    return month[date.getMonth()] + " " + date.getDate() + ", " + date.getFullYear();
}

const MilestoneDueDate = (props) => {
    let dueDate = new Date(props.dueDate);
    
    if (props.dueDate) {
        dueDate = "Due by " + getDateFrom(dueDate);
    } else {
        dueDate = "No due date"
    }

    return <MilestoneMetaDueDate>
            <CalendarIcon src={calendarIcon}/>
            <DueDateText>{dueDate} </DueDateText>
        </MilestoneMetaDueDate>;
}

export default MilestoneDueDate;

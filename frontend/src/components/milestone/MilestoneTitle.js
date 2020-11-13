import React from 'react';
import styled from 'styled-components';
import clockIcon from '../../../public/icon/clock.png';
import MilestoneDueDate from './MilestoneDueDate';

const TitleCell = styled.div`
  flex: 0.55;
  display: flex;
  flex-direction: column;
`;

const MilestoneMeta = styled.div`
  display: flex;
  flex-direction: row;
`;

const MilestoneMetaUpdateDate = styled.span`
  display: flex;
  flex-direction: row;

  font-size: 0.95em;
  color: gray;
  font-weight: lighter;
  padding-left: 20px;
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

const Desc = styled.p`
  margin-top: 10px;
`;

const ClockImg = styled.img`
  width: 16px;
  height: 16px;
  margin-right: 5px;
  padding-top: 3px;
`;

const UpdateDateText = styled.p`
  margin: 0 auto;

  color: gray;
  font-weight: lighter;
`;

const getElapsedTime = (date) => {
  const time = new Date(date).getTime();
  let result = Date.now() - time;

  if (result / 1000 < 60) {
    result = parseInt(result / 1000) + ' second';
  } else if (result / 1000 / 60 < 60) {
    result = parseInt(result / 1000 / 60) + ' minute';
  } else if (result / 1000 / 60 / 60 < 60) {
    result = parseInt(result / 1000 / 60 / 60) + ' hour';
  } else {
    result = parseInt(result / 1000 / 60 / 60) + ' day';
  }

  return result;
};

const MilestoneTitle = (props) => {
  const data = props.data;
  const updateDate = getElapsedTime(data.updatedAt);

  return (
    <TitleCell>
      <TitleLink href="/milestone-add">{data.title}</TitleLink>
      <MilestoneMeta>
        <MilestoneDueDate dueDate={data.dueDate} />
        <MilestoneMetaUpdateDate>
          <ClockImg src={clockIcon} />
          <UpdateDateText>Last updated about {updateDate} ago</UpdateDateText>
        </MilestoneMetaUpdateDate>
      </MilestoneMeta>
      <Desc>{data.description}</Desc>
    </TitleCell>
  );
};

export default MilestoneTitle;

import React from 'react';
import styled from 'styled-components';
import IssueInfo from '../../components/milestone/MilestoneIssue';
import arrow_bottom from '../../../public/icon/arrow_bottom.png';

const HeaderLayout = styled.div`
    display: flex;
    flex-direction: row;

    margin: 0 auto;
    padding-left: 20px;
    padding-top: 10px;
    padding-bottom: 10px;

    border-style: solid;
    border-radius: 5px;
    border-width: 1px;
    border-color: #e1e4e8;
`;

const MarkDownLayout = styled.div`
    flex: 1;
`;

const MarkDown = styled.summary`
    float: right;
    margin-right: 20px;
    font-weight: lighter;
`;

const ListSort = () => {
    return <MarkDownLayout>
        <MarkDown>
            Sort
            <img src={arrow_bottom} width="11" height="11"/>
        </MarkDown>
    </MarkDownLayout>
}

const TableListHeader = () => {
    return <HeaderLayout>
        <IssueInfo/>
        <ListSort/>
    </HeaderLayout>
}

export default TableListHeader;

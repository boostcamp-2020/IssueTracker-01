import React from 'react';
import styled from 'styled-components';
import checkIcon from '../../../public/icon/check.png'
import noticeIcon from '../../../public/icon/notice.png'

const InfoLayout = styled.div`
    flex: 1;
`;

const OpenInfo = styled.a`
    text-decoration: none;
`;

const CloseInfo = styled.a`
    text-decoration: none;
    margin-left: 25px;
`;

const StatsIcon = styled.img`
    width: 16px;
    height: 16px;
    padding-right: 10px
`;

const IssueInfo = () => {
    return <InfoLayout>
        <OpenInfo href="">
            <StatsIcon src={noticeIcon} width="20" height="20"/>
            0 Open
        </OpenInfo>
        <CloseInfo href="">
            <StatsIcon src={checkIcon} width="20" height="20"/>
            0 Close
        </CloseInfo>
    </InfoLayout>;
}

export default IssueInfo;

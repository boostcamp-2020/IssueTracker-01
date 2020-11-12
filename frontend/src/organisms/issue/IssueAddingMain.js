import React from 'react';
import styled from 'styled-components';
import IssueInputLayout from '../../components/Issue/IssueInputLayout';
import IssueInputTitle from '../../components/Issue/IssueInputTitle';
import IssueInputButtons from '../../components/Issue/IssueInputButtons';

const MainLayout = styled.div`
    width: 60%;
    
    margin: 0 auto;
    margin-right: 30px;
    margin-left: 7%;

    border: 1px solid #e1e4e8;
    border-radius: 6px;
`;

const IssueAddingMain = () => {
    return <MainLayout>
        <IssueInputTitle/>
        <IssueInputLayout/>
        <IssueInputButtons/>
    </MainLayout>
}

export default IssueAddingMain;

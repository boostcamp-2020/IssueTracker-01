import React from 'react';
import styled from 'styled-components';
import IssueInputLayout from '../../components/Issue/IssueInputLayout';
import IssueInputTitle from '../../components/Issue/IssueInputTitle';
import IssueInputButtons from '../../components/Issue/IssueInputButtons';

const MainLayout = styled.div`
    flex: 0.7;

    width: 60%;
    
    margin: 0 auto;
    margin-left: 3%;
    margin-right: 3%;
    
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

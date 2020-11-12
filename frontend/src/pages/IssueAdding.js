import React from 'react';
import styled from 'styled-components';
import IssueAddingMain from '../organisms/issue/IssueAddingMain';
import IssueAddingSideBar from '../organisms/issue/IssueAddingSideBar';

const Page = styled.div`
    display: flex;
    flex-direction: row;

    width: 78%;
    margin: 0 auto;
    padding: 10px;
`;

const IssueAdding = () => {
    return <Page>
        <IssueAddingMain/>
        <IssueAddingSideBar/>
    </Page>
}

export default IssueAdding;

import React, { useContext } from 'react';
import styled from 'styled-components';
import { SelectionsStateContext, SelectionsSetContext } from '../../contexts/selection';

const InputTitleLayout = styled.div`
    padding: 8px;
`;

const InputTitle = styled.input`
    width: 200px;
    height: 16px;
    margin: 0 auto;
    padding: 10px;

    border: 1px solid #e1e4e8;
    border-radius: 6px;

`;

const IssueInputTitle = () => {
    const selections = useContext(SelectionsStateContext);
    const setSelection = useContext(SelectionsSetContext);

    const inputTitle = (e) => {
        setSelection({
            ...selections,
            ['title']: e.target.value
        });
    }

    return <InputTitleLayout>
        <InputTitle onChange={inputTitle} placeholder="Title"/>
    </InputTitleLayout>
}

export default IssueInputTitle;

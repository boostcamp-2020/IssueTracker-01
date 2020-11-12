import React from 'react';
import styled from 'styled-components';

const InputArea = styled.div`
    padding: 8px;

    background-color: #fafbfc;
`;
const ButtonsLayout = styled.div`
    width: 67px;
    height: 40px;
`;
const WriteButton = styled.button`
    width: inherit;
    height: inherit;

    outline: none;
    border: 1px solid #e1e4e8;
    border-radius: 6px 6px 0 0;

    background-color: rgba(0, 0, 255, 0);
`;
const InputLayout = styled.div`
    border: 1px solid #e1e4e8;
    border-radius: 6px;
    border-top-left-radius: 0px;
`;
const InputComment = styled.textarea`
    width: 96%;
    height: 200px;

    margin: 10px;

    border: 1px solid #e1e4e8;
    border-radius: 6px;

    background-color: #fafbfc;
`;

const IssueInputLayout = () => {
    return <InputArea>
        <ButtonsLayout>
            <WriteButton>Write</WriteButton>
        </ButtonsLayout>
        <InputLayout>
            <InputComment placeholder="Leave a comment"/>
        </InputLayout>
    </InputArea>
}

export default IssueInputLayout;

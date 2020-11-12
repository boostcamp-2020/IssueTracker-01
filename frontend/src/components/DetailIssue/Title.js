import React, { useState, useCallback } from 'react';
import styled, { css } from 'styled-components';
import { GoIssueOpened, GoIssueClosed } from 'react-icons/go';
import calcTime from '../../util/calcTime';
import axios from 'axios';

const TextBox = styled.div`
  display: flex;
  h1 {
    font-weight: 500;
  }
`;
const IssueId = styled.h1`
  color: #6f7680;
`;
const TitleBox = styled.div`
  width: 100%;
  display: flex;
  justify-content: space-between;
  align-items: center;
`;
const EditButton = styled.button`
  width: 50px;
  height: 30px;
  background: #f5f7f9;
  border-radius: 4px;
  border: 1px solid #d0d5d7;
  font-weight: 600;
  outline: none;
  cursor: pointer;
  :disabled {
    cursor: default;
  }
`;

const boxStyle = css`
  width: 70px;
  height: 30px;
  display: flex;
  justify-content: center;
  align-items: center;
  border-radius: 4px;
  color: white;
  font-size: 0.9rem;
  font-weight: 600;
`;
const InfoBox = styled.div`
  display: flex;
  align-items: center;
  p {
    margin: 0;
  }
`;
const OpenBox = styled.div`
  ${boxStyle}
  background: #2cbe4e;
`;
const ClosedBox = styled.div`
  ${boxStyle}
  background: #cb2431;
`;
const Author = styled.p`
  color: #555b64;
  font-weight: 600;
`;
const InfoText = styled.p`
  color: #555b64;
`;
const InputTitle = styled.input`
  width: 90%;
  padding: 0.5rem;
  outline-color: #9cc1f5;
`;
const CancelP = styled.p`
  color: #2768cf;
  cursor: pointer;
`;

const Title = ({ detailIssue }) => {
  const { issueId, title, isOpen, userId, createdAt, Comments } = detailIssue;
  const time = calcTime(createdAt);
  const [edit, setEdit] = useState(0);
  const [titleText, setTitleText] = useState(title);
  const onChangeText = useCallback((e) => {
    setTitleText(e.target.value);
  }, []);
  const onChangeTitle = useCallback(async () => {
    try {
      await axios.patch(
        `http://127.0.0.1:3000/api/issue/${issueId}`,
        { title: titleText },
        {
          withCredentials: true,
        },
      );
    } catch (error) {
      console.log(error);
    }
    setEdit(0);
  });
  const onEditChange = useCallback(() => {
    if (edit) {
      setTitleText(title);
      setEdit(0);
      return;
    }
    setEdit(1);
  });
  return (
    <>
      {!edit ? (
        <TitleBox>
          <TextBox>
            <h1>{titleText}&nbsp;</h1>
            <IssueId>#{issueId}</IssueId>
          </TextBox>
          <EditButton onClick={onEditChange}>Edit</EditButton>
        </TitleBox>
      ) : (
        <TitleBox>
          <InputTitle value={titleText} onChange={onChangeText} />
          <EditButton disabled={!titleText.length} onClick={onChangeTitle}>
            Save
          </EditButton>
          <CancelP onClick={onEditChange}>Cancel</CancelP>
        </TitleBox>
      )}
      <InfoBox>
        {isOpen === 1 ? (
          <OpenBox>
            <GoIssueOpened />
            <p>&nbsp;Open</p>
          </OpenBox>
        ) : (
          <ClosedBox>
            <GoIssueClosed />
            <p>&nbsp;Closed</p>
          </ClosedBox>
        )}
        <Author>&nbsp;{userId}&nbsp;</Author>
        <InfoText>
          opened this issue {time} · {Comments.length} comment
        </InfoText>
      </InfoBox>
      <hr />
    </>
  );
};

export default Title;

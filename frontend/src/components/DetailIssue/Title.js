import React from 'react';
import styled, { css } from 'styled-components';
import { GoIssueOpened, GoIssueClosed } from 'react-icons/go';
import calcTime from '../../util/calcTime';

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
  color: #697079;
  font-weight: 600;
`;
const InfoText = styled.p`
  color: #90959b;
`;
const Title = ({ detailIssue }) => {
  const { issueId, title, isOpen, userId, createdAt, Comments } = detailIssue;
  const commentLength = Comments ? Comments.length : 0;
  const time = calcTime(createdAt);
  return (
    <>
      <TitleBox>
        <TextBox>
          <h1>{title}&nbsp;</h1>
          <IssueId>#{issueId}</IssueId>
        </TextBox>
        <EditButton>Edit</EditButton>
      </TitleBox>
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
          opened this issue {time} · {commentLength} comment
        </InfoText>
      </InfoBox>
      <hr />
    </>
  );
};

export default Title;

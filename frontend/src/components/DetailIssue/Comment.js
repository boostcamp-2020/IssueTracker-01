import React, { useContext, useCallback } from 'react';
import styled from 'styled-components';
import UserContext from '../../contexts/user';
import calcTime from '../../util/calcTime';

const Box = styled.div`
  display: flex;
  margin: 20px 0 30px 0;
`;
const Img = styled.img`
  width: auto;
  height: auto;
  max-width: 50px;
  max-height: 50px;
  border-radius: 5px;
`;
const Author = styled.p`
  font-weight: 600;
`;
const CommentTime = styled.p`
  color: #555b64;
`;

const EditBox = styled.div`
  width: 100px;
  display: flex;
  justify-content: space-between;
  align-items: center;
  color: #555b64;
`;
const OwnerBox = styled.div`
  display: flex;
  width: 60px;
  height: 30px;
  border-radius: 4px;
  border: 1px solid #bdcfe7;
  align-items: center;
  justify-content: center;
  font-weight: 600;
`;
const CommentBox = styled.div`
  width: 65%;
  margin-left: 20px;
  border-radius: 4px;
`;
const CommentInfo = styled.div`
  height: 40px;
  padding: 0 1rem 0 1rem;
  display: flex;
  justify-content: space-between;
  align-items: center;
  p {
    margin: 0;
  }
`;
const InfoBox = styled.div`
  display: flex;
`;
const CommentConent = styled.div`
  padding: 0 1rem 0 1rem;
`;
const Comment = ({ comment, setEdit, setComment }) => {
  const { commentId, content, createdAt, User } = comment;
  const { userId, profile_url } = User;
  const { user } = useContext(UserContext);
  const onEdit = useCallback(() => {
    setEdit(1);
    setComment({
      commentId,
      content,
    });
  });
  return (
    <Box>
      <Img src={profile_url} />
      {userId === user.userId ? (
        <CommentBox style={{ border: '1px solid #bdcfe7' }}>
          <CommentInfo style={{ background: '#f2f8ff', borderBottom: '1px solid #bdcfe7' }}>
            <InfoBox>
              <Author>{userId}&nbsp;</Author>
              <CommentTime>commented {calcTime(createdAt)}</CommentTime>
            </InfoBox>
            <EditBox>
              <OwnerBox>
                <p>Owner</p>
              </OwnerBox>
              <p style={{ cursor: 'pointer' }} onClick={onEdit}>
                Edit
              </p>
            </EditBox>
          </CommentInfo>
          <CommentConent>
            <p>{content}</p>
          </CommentConent>
        </CommentBox>
      ) : (
        <CommentBox style={{ border: '1px solid #dfe1e5' }}>
          <CommentInfo style={{ background: '#f7f8fa', borderBottom: '1px solid #dfe1e5' }}>
            <InfoBox>
              <Author>{userId}&nbsp;</Author>
              <CommentTime>commented {calcTime(createdAt)}</CommentTime>
            </InfoBox>
          </CommentInfo>
          <CommentConent>
            <p>{content}</p>
          </CommentConent>
        </CommentBox>
      )}
    </Box>
  );
};

export default Comment;

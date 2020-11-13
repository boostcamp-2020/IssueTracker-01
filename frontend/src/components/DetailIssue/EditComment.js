import React, { useState, useContext, useCallback } from 'react';
import styled from 'styled-components';
import UserContext from '../../contexts/user';
import axios from 'axios';

const Img = styled.img`
  width: auto;
  height: auto;
  max-width: 50px;
  max-height: 50px;
  border-radius: 5px;
`;
const Box = styled.div`
  display: flex;
  margin: 20px 0 30px 0;
`;
const AddBox = styled.div`
  width: 65%;
  margin-left: 20px;
  border-radius: 4px;
  border: 1px solid #dfe1e5;
`;
const Title = styled.div`
  height: 40px;
  padding: 0 1rem 0 1rem;
  background: #f7f8fa;
  border-bottom: 1px solid #dfe1e5;
  display: flex;
  align-items: center;
  p {
    margin: 0;
    font-weight: 600;
  }
`;
const Content = styled.div`
  padding: 0.5rem 1rem 0.5rem 1rem;
`;
const TextArea = styled.textarea`
  width: 100%;
  min-width: 100%;
  max-width: 100%;
  height: 60px;
  border-radius: 4px;
  border: 1px solid #dfe1e5;
  background: #f7f8fa;
  padding: 0.5rem;
  box-sizing: border-box;
  outline: 0;
  ::placeholder {
    color: #adb1b6;
  }
`;
const ButtonBox = styled.div`
  margin-bottom: 10px;
  padding: 0 1rem 0 1rem;
  display: flex;
  justify-content: flex-end;
`;
const CancelButton = styled.button`
  width: 110px;
  height: 30px;
  background: #f5f7f9;
  border-radius: 4px;
  border: 1px solid #d0d5d7;
  font-weight: 600;
  display: flex;
  align-items: center;
  justify-content: center;
  color: red;
  cursor: pointer;
`;
const UpdateButton = styled.button`
  margin-left: 5px;
  width: 200px;
  height: 30px;
  background: #2cbe4e;
  border-radius: 4px;
  border: 1px solid #7ea682;
  color: white;
  font-weight: 600;
  cursor: pointer;
  :disabled {
    background: #a2d1a6;
    cursor: default;
  }
`;
const EditComment = ({ setEdit, comment, fetchData }) => {
  const { user } = useContext(UserContext);
  const [text, setText] = useState(comment.content);
  const onChange = useCallback((e) => {
    setText(e.target.value);
  });
  const onCancel = useCallback(() => {
    setEdit(0);
  });
  const onUpdate = useCallback(async () => {
    try {
      await axios.patch(
        `http://api.hoyoung.me/api/comment/${comment.commentId}`,
        { content: text },
        {
          withCredentials: true,
        },
      );
    } catch (error) {
      console.log(error);
    }
    setEdit(0);
    fetchData();
  });
  return (
    <Box>
      <Img src={user.profileUrl} />
      <AddBox>
        <Title>
          <p>Write</p>
        </Title>
        <Content>
          <TextArea placeholder={'Leave a comment'} value={text} onChange={onChange} />
        </Content>
        <ButtonBox>
          <CancelButton onClick={onCancel}>Cancel</CancelButton>
          <UpdateButton onClick={onUpdate} disabled={!text.length}>
            Update comment
          </UpdateButton>
        </ButtonBox>
      </AddBox>
    </Box>
  );
};

export default EditComment;

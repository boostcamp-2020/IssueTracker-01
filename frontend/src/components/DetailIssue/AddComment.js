import React, { useContext } from 'react';
import styled from 'styled-components';
import UserContext from '../../contexts/user';
import { GoIssueClosed } from 'react-icons/go';

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
const CloseButton = styled.button`
  width: 120px;
  height: 30px;
  background: #f5f7f9;
  border-radius: 4px;
  border: 1px solid #d0d5d7;
  font-weight: 600;
  display: flex;
  align-items: center;
  justify-content: center;
`;
const AddButton = styled.button`
  margin-left: 5px;
  width: 90px;
  height: 30px;
  background: #a2d1a6;
  border-radius: 4px;
  border: 1px solid #7ea682;
  color: white;
  font-weight: 600;
`;
const AddComment = ({ issueId, isOpen }) => {
  const { user } = useContext(UserContext);
  return (
    <Box>
      <Img src={user.profileUrl} />
      <AddBox>
        <Title>
          <p>Write</p>
        </Title>
        <Content>
          <TextArea placeholder={'Leave a comment'} />
        </Content>
        <ButtonBox>
          {isOpen === 1 && (
            <CloseButton>
              <GoIssueClosed style={{ color: 'red' }} />
              &nbsp;Close issue
            </CloseButton>
          )}
          <AddButton>Comment</AddButton>
        </ButtonBox>
      </AddBox>
    </Box>
  );
};

export default AddComment;

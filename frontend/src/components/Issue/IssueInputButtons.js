import React, { useContext } from 'react';
import styled from 'styled-components';
import axios from 'axios';
import { SelectionsStateContext } from '../../contexts/selection';

const ButtonLayout = styled.div`
  display: flex;
  flex-direction: row-reverse;
  padding: 10px;
`;
const SubmitButton = styled.button`
  width: 149px;
  height: 32px;

  font-size: 0.9em;

  outline: none;
  border: none;
  border-radius: 6px;

  color: white;
  background-color: #28a745;
`;

const IssueInputButtons = () => {
  const selections = useContext(SelectionsStateContext);

  const submitIssue = async () => {
    if (selections.title.length > 0) {
        let data = {
            title: selections.title
        }
        if (selections.milestoneId.length == 0 && selections.assignees.length == 0) {
            data = {
                title: selections.title
            }
        } else if (selections.assignees.length == 0) {
            data = {
                title: selections.title,
                milestoneId: selections.milestoneId,
            }
        } else if (selections.milestoneId.length == 0) {
            data = {
                title: selections.title,
                assignees: selections.assignees,
            }
        }
      
        const result = await axios.post('http://api.hoyoung.me/api/issue', {
        data
        }, { withCredentials: true });

      if (result.status === 200) {
        window.location.href = '/issue';
      } else {
        alert('에러');
      }
    }

    alert('제목을 입력하세요.');
  };

  return (
    <ButtonLayout>
      <SubmitButton onClick={submitIssue}>Submit new issue</SubmitButton>
    </ButtonLayout>
  );
};

export default IssueInputButtons;

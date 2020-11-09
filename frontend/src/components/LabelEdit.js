import React from 'react';
import styled from 'styled-components';
import Button from './Button';
import WhiteButton from './WhiteButton';

const EditForm = styled.form`
  display: flex;
  align-items: flex-end;
`;

const InputLabel = styled.label`
  font-size: 14px;
  font-weight: 600;
  color: #24292e;
  margin-bottom: 8px;
`;

const GroupDiv = styled.div`
  display: flex;
  flex-direction: column;
  padding-right: 16px;
  margin-top: 16px;
  margin-bottom: 16px;
  width: ${(props) => props.width || '100%'};
`;

const GroupEndDv = styled.div`
  display: flex;
  padding-right: 16px;
  margin-top: 16px;
  margin-bottom: 16px;
  justify-content: flex-end;
  width: ${(props) => props.width || '100%'};
`;

const StyledInput = styled.input`
  padding: 5px 12px;
  font-size: 14px;
  line-height: 20px;
  color: #24292e;
  max-width: 100%;
  margnii-right: 5px;
  background-color: #fafbfc;
  border: 1px solid #e1e4e8;
  border-radius: 6px;
  outline: none;
`;

const LabelEdit = () => {
  return (
    <EditForm>
      <GroupDiv width={'25%'}>
        <InputLabel htmlFor="labelName">Label name</InputLabel>
        <StyledInput type="text" id="labelName" name="labelName" maxLength="50" />
      </GroupDiv>
      <GroupDiv width={'33.33333%'}>
        <InputLabel htmlFor="description">Description</InputLabel>
        <StyledInput type="text" id="description" name="description" maxLength="100" />
      </GroupDiv>
      <GroupDiv width={'16.66667%'}>
        <InputLabel htmlFor="color">Color</InputLabel>
        <StyledInput type="text" id="color" name="color" maxLength="7" />
      </GroupDiv>
      <GroupEndDv width={'25%'}>
        <WhiteButton text="Cancel" />
        <Button text="Save changes" />
      </GroupEndDv>
    </EditForm>
  );
};

export default LabelEdit;

import React from 'react';
import styled from 'styled-components';
import GreenButton from './GreenButton';
import WhiteButton from './WhiteButton';
import SVG from './SVG';

const EditForm = styled.form`
  display: ${(props) => (props.hide ? 'none' : 'flex')};
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

const FlexDiv = styled.div`
  display: flex;
`;

const RefreshButton = styled.button`
  width: 34px;
  border-radius: 6px;
  margin-right: 8px;
  flex-shrink: 0;
  border: 0;
  background-color: ${(props) => props.color};
`;

const LabelEdit = ({ id, hide, onClick, label, changeColor }) => {
  return (
    <EditForm hide={hide}>
      <GroupDiv width={'25%'}>
        <InputLabel htmlFor={`labelName-${id}`}>Label name</InputLabel>
        <StyledInput
          type="text"
          id={`labelName-${id}`}
          name="labelName"
          maxLength="50"
          defaultValue={label.labelName}
        />
      </GroupDiv>
      <GroupDiv width={'33.33333%'}>
        <InputLabel htmlFor={`description-${id}`}>Description</InputLabel>
        <StyledInput
          type="text"
          id={`description-${id}`}
          name="description"
          maxLength="100"
          defaultValue={label.description}
        />
      </GroupDiv>
      <GroupDiv width={'16.66667%'}>
        <InputLabel htmlFor={`color-${id}`}>Color</InputLabel>
        <FlexDiv>
          <RefreshButton color={label.color} onClick={(e) => changeColor(e)}>
            <SVG name="refreshButton" size="16" />{' '}
          </RefreshButton>
          <StyledInput
            type="text"
            id={`color-${id}`}
            name="color"
            maxLength="7"
            defaultValue={label.color}
            onChange={(e) => changeColor(e)}
          />
        </FlexDiv>
      </GroupDiv>
      <GroupEndDv width={'25%'}>
        <WhiteButton text="Cancel" onClick={onClick} />
        <GreenButton text="Save changes" />
      </GroupEndDv>
    </EditForm>
  );
};

export default LabelEdit;

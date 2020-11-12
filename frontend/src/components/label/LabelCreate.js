import React, { useState } from 'react';
import styled from 'styled-components';
import GreenButton from '../utils/GreenButton';
import WhiteButton from '../utils/WhiteButton';
import SVG from '../utils/SVG';
import { useLabelDispatch, createLabel } from '@contexts/label';

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

const PreviewLabel = styled.span`
  background: ${(props) => props.color};
  font-size: 12px;
  font-weight: 500;
  padding: 0 10px;
  line-height: 22px;
  border: 1px solid transparent;
  border-radius: 2em;
`;

const BackgroundDiv = styled.div`
  ${(props) => (props.hide ? 'display: none;' : '')}
  padding: 16px;
  border: 1px solid #d1d5da;
  border-radius: 6px;
  background-color: #f6f8fa;
  margin-bottom: 16px;
`;

const LabelCreate = ({ hide, onClick }) => {
  const [label, setLabel] = useState({});
  const dispatch = useLabelDispatch();

  const setFormData = (e) => {
    const { id, value } = e.target;
    setLabel({
      ...label,
      [id]: value,
    });
  };

  const fetchCreateLabel = (e) => {
    e.preventDefault();
    createLabel(dispatch, label);
  };

  return (
    <BackgroundDiv hide={hide}>
      <PreviewLabel color="#ff0000">test</PreviewLabel>
      <EditForm>
        <GroupDiv width={'25%'}>
          <InputLabel htmlFor="labelName" placeholder="Label Name">
            Label name
          </InputLabel>
          <StyledInput type="text" id="labelName" name="labelName" maxLength="50" onChange={(e) => setFormData(e)} />
        </GroupDiv>
        <GroupDiv width={'33.33333%'}>
          <InputLabel htmlFor="description">Description</InputLabel>
          <StyledInput
            type="text"
            id="description"
            name="description"
            maxLength="100"
            onChange={(e) => setFormData(e)}
          />
        </GroupDiv>
        <GroupDiv width={'16.66667%'}>
          <InputLabel htmlFor="color">Color</InputLabel>
          <FlexDiv>
            <RefreshButton>
              <SVG name="refreshButton" size="16" />{' '}
            </RefreshButton>
            <StyledInput type="text" id="color" name="color" maxLength="7" onChange={(e) => setFormData(e)} />
          </FlexDiv>
        </GroupDiv>
        <GroupEndDv width={'25%'}>
          <WhiteButton text="Cancel" onClick={(e) => onClick(e)} />
          <GreenButton type="submit" text="Create label" onClick={(e) => fetchCreateLabel(e)} />
        </GroupEndDv>
      </EditForm>
    </BackgroundDiv>
  );
};

export default LabelCreate;

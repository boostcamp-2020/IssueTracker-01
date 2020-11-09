import React from 'react';
import styled from 'styled-components';
import LabelEdit from './LabelEdit';

const LabelDiv = styled.div`
  padding: 16px;
  border: 1px solid #eaecef;
  border-top: 0;
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

const Description = styled.span`
  font-size: 12px;
  color: #586069;
`;

const ButtonDiv = styled.div`
  display: flex;
  width: 16.66667%;
  justify-content: flex-end;
`;

const Button = styled.div`
  font-size: 12px;
  margin-left: 16px;
  background-color: transparent;
  border: 0;
  white-space: nowrap;
  color: #586069;
`;

const WidthDiv = styled.div`
  width: ${(props) => props.width};
`;

const LabelInfo = styled.div`
  display: flex;
  justify-content: space-between;
`;

const Label = ({ item }) => {
  return (
    <LabelDiv>
      <LabelInfo>
        <WidthDiv width={'25%'}>
          <PreviewLabel color={item.color}>{item.labelName}</PreviewLabel>
        </WidthDiv>
        <WidthDiv width={'58.33333%'}>
          <Description>{item.description}</Description>
        </WidthDiv>
        <ButtonDiv>
          <Button>Edit</Button>
          <Button>Delete</Button>
        </ButtonDiv>
      </LabelInfo>
      <LabelEdit />
    </LabelDiv>
  );
};

export default Label;

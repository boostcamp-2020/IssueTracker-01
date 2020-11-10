import React, { useState } from 'react';
import styled from 'styled-components';
import LabelEdit from './LabelEdit';

const LabelDiv = styled.div`
  padding: 16px;
  border: 1px solid #eaecef;
  border-top: 0;
`;

const PreviewLabel = styled.span`
  display: inline-block;
  background: ${(props) => props.color};
  color: ${(props) => (props.fontContrast ? '#fff' : '#000')};
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

// 출처 : https://tonks.tistory.com/130
const hexToRgb = (hexType) => {
  let hex = hexType.replace('#', '');
  let value = hex.match(/[a-f\d]/gi);

  if (value.length == 3) hex = value[0] + value[0] + value[1] + value[1] + value[2] + value[2];

  value = hex.match(/[a-f\d]{2}/gi);

  const r = parseInt(value[0], 16);
  const g = parseInt(value[1], 16);
  const b = parseInt(value[2], 16);

  return { r, g, b };
};

const contrastColor = ({ r, g, b }) => {
  return (0.299 * r + 0.587 * g + 0.114 * b) / 255 < 0.5;
};

const generateRandomColor = () => {
  const letters = '0123456789ABCDEF';
  let color = '#';
  for (let i = 0; i < 6; i++) {
    color += letters[Math.floor(Math.random() * 16)];
  }
  return color;
};

const Label = ({ id, item }) => {
  const [hide, setHide] = useState(true);
  const [label, setLabel] = useState({ ...item, fontContrast: contrastColor(hexToRgb(item.color)) });

  let debounce = undefined;

  const toggleHide = (e) => {
    e.preventDefault();
    setHide(!hide);
  };

  const changeColor = (e) => {
    e.preventDefault();
    let { value } = e.target;
    if (!value) {
      value = generateRandomColor();
    }
    if (!/^#(([0-9a-fA-F]{2}){3}|([0-9a-fA-F]){3})$/.exec(value)) {
      return;
    }
    setLabel({
      ...label,
      color: value,
      fontContrast: contrastColor(hexToRgb(value)),
    });
  };

  const changeName = (e) => {
    let { value } = e.target;
    clearTimeout(debounce);
    debounce = setTimeout(() => {
      setLabel({
        ...label,
        labelName: value,
      });
    }, 500);
  };

  return (
    <LabelDiv>
      <LabelInfo>
        <WidthDiv width={'25%'}>
          <PreviewLabel color={label.color} fontContrast={label.fontContrast}>
            <span>{label.labelName}</span>
          </PreviewLabel>
        </WidthDiv>
        <WidthDiv width={'58.33333%'}>
          <Description>{label.description}</Description>
        </WidthDiv>
        <ButtonDiv>
          <Button onClick={toggleHide}>Edit</Button>
          <Button>Delete</Button>
        </ButtonDiv>
      </LabelInfo>
      <LabelEdit
        id={id}
        hide={hide}
        onClick={toggleHide}
        label={label}
        changeColor={changeColor}
        changeName={changeName}
      />
    </LabelDiv>
  );
};

export default Label;

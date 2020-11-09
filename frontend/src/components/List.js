import React from 'react';
import styled from 'styled-components';
import Label from '@components/Label';

const ListItem = styled.div``;

const List = ({ items }) => {
  return (
    <div>
      {items.map((item, i) => (
        <Label key={i} item={item} />
      ))}
    </div>
  );
};

export default List;

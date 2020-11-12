import React from 'react';
import styled from 'styled-components';
import Label from '@components/label/Label';

const ListItem = styled.div``;

const List = ({ items, keys }) => {
  return (
    <div>
      {items.map((item, i) => (
        <Label key={Array.isArray(keys) && keys.length ? keys[i] : i} id={i} item={item} />
      ))}
    </div>
  );
};

export default List;

import React from 'react';
import Issue from './Issue';

const IssueList = ({ items, keys }) => {
  return (
    <div>
      {items.reverse().map((item, i) => (
        <Issue key={Array.isArray(keys) && keys.length ? keys[i] : i} id={i} item={item} />
      ))}
    </div>
  );
};

export default IssueList;

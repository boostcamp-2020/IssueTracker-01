import React from 'react';
import Issue from './Issue';

const IssueList = ({ items, keys, history }) => {
  return (
    <div>
      {items.reverse().map((item, i) => (
        <Issue key={Array.isArray(keys) && keys.length ? keys[i] : i} id={i} item={item} history={history} />
      ))}
    </div>
  );
};

export default IssueList;

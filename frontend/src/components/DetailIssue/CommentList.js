import React from 'react';
import Comment from './Comment';

const CommentList = ({ comments }) => {
  return <div>{comments && comments.map((comment) => <Comment comment={comment} key={comment.commentId} />)}</div>;
};

export default CommentList;

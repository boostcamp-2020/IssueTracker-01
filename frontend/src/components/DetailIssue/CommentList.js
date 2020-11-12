import React from 'react';
import Comment from './Comment';

const CommentList = ({ comments, setEdit, setComment }) => {
  return (
    <div>
      {comments &&
        comments.map((comment) => (
          <Comment comment={comment} key={comment.commentId} setEdit={setEdit} setComment={setComment} />
        ))}
    </div>
  );
};

export default CommentList;

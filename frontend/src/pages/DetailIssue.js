import React, { useState, useEffect } from 'react';
import styled from 'styled-components';
import Header from '../components/util/Header';
import Title from '../components/DetailIssue/Title';
import CommentList from '../components/DetailIssue/CommentList';
import axios from 'axios';

const Box = styled.div`
  width: 90%;
  margin-left: auto;
  margin-right: auto;
`;
const DetailIssue = ({ match }) => {
  const { issueId } = match.params;
  const [detailIssue, setDetailIssue] = useState({});
  useEffect(() => {
    const fetchData = async () => {
      try {
        const response = await axios.get(`http://127.0.0.1:3000/api/issue/detailIssue/${issueId}`, {
          withCredentials: true,
        });
        setDetailIssue(response.data);
      } catch (error) {
        console.log(error);
      }
    };
    fetchData();
  }, [issueId]);
  return (
    <>
      <Header />
      <Box>
        <Title detailIssue={detailIssue} />
        <CommentList comments={detailIssue.Comments} />
      </Box>
    </>
  );
};

export default DetailIssue;

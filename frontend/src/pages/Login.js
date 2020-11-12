import React, { useEffect, useContext } from 'react';
import styled from 'styled-components';
import LoginForm from '../components/login/LoginForm';
import UserContext from '../contexts/user';
import axios from 'axios';

const Box = styled.div`
  width: 100vw;
  height: 100vh;
  background: #f9f9f9;
  display: flex;
  flex-direction: column;
  justify-content: center;
`;
const H1 = styled.h1`
  margin: 0;
  text-align: center;
  box-sizing: border-box;
`;
const Login = ({ history }) => {
  const { setUser } = useContext(UserContext);
  useEffect(() => {
    const checkLogin = async () => {
      try {
        const response = await axios.get('http://127.0.0.1:3000/isLogin', { withCredentials: true });
        setUser({
          userId: response.data.userId,
          profileUrl: response.data.profileUrl,
        });
        history.push('/main');
      } catch (error) {
        console.log(error);
      }
    };
    checkLogin();
  }, []);
  return (
    <Box>
      <H1>이슈 트래커</H1>
      <LoginForm />
    </Box>
  );
};

export default Login;

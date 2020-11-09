import React from "react";
import styled from "styled-components";
import LoginForm from "../components/login/LoginForm";

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
const Login = () => {
  return (
    <Box>
      <H1>이슈 트래커</H1>
      <LoginForm />
    </Box>
  );
};

export default Login;

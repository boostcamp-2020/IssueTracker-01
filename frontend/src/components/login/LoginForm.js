import React from 'react';
import styled, { css } from 'styled-components';
import GitHubButton from './GitHubButton';

const FormBox = styled.div`
  width: 400px;
  border-radius: 5px;
  border: 1px solid #ded5da;
  margin-left: auto;
  margin-right: auto;
  margin-top: 3rem;
  background: white;
`;
const Form = styled.div`
  width: 90%;
  margin-left: auto;
  margin-right: auto;
`;
const P = styled.p`
  color: #25292e;
  font-weight: 600;
`;
const inputStyle = css`
  width: 100%;
  height: 40px;
  background: white;
  box-sizing: border-box;
  border-radius: 5px;
  border: 1px solid #ded5da;
  padding: 0.5rem;
  margin-bottom: 5px;
  &:focus {
    outline: none;
  }
`;
const InputId = styled.input.attrs({
  type: 'text',
})`
  ${inputStyle}
`;
const InputPwd = styled.input.attrs({
  type: 'password',
})`
  ${inputStyle}
`;
const Text = styled.div`
  width: 100%;
  display: flex;
  margin-bottom: 20px;
  justify-content: space-around;
  p {
    color: #2768cf;
    font-weight: 600;
    cursor: pointer;
  }
`;

const LoginForm = () => {
  return (
    <FormBox>
      <Form>
        <P>아이디</P>
        <InputId />
        <P>비밀번호</P>
        <InputPwd />
        <Text>
          <p>로그인</p>
          <p>회원가입</p>
        </Text>
        <GitHubButton />
      </Form>
    </FormBox>
  );
};

export default LoginForm;

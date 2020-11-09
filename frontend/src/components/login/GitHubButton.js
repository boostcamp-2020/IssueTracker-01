import React from "react";
import styled from "styled-components";
import { GoMarkGithub } from "react-icons/go";

const GitHubLoginButton = styled.button`
  width: 100%;
  background: #a0a0a0;
  color: white;
  border: 1px solid #868687;
  border-radius: 5px;
  padding: 0.5rem;
  margin-bottom: 20px;
  display: flex;
  align-items: center;
  justify-content: center;
  box-sizing: border-box;
  font-size: 1rem;
  font-weight: 600;
  cursor: pointer;
  p {
    margin: 0;
  }
  &:hover {
    background: #5d5d5d;
  }
`;

const GitHubButton = () => {
  return (
    <GitHubLoginButton>
      <p>Sign in with GitHub&nbsp;</p>
      <GoMarkGithub style={{ color: "black" }} />
    </GitHubLoginButton>
  );
};

export default GitHubButton;

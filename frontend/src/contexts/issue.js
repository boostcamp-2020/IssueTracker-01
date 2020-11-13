import React, { useReducer, createContext, useContext, useEffect, dispatch } from 'react';
import axios from 'axios';

const issueReducer = (state, action) => {
  switch (action.type) {
    case 'LOAD':
      return [...action.data];
    default:
      throw new Error(`Unhandled action type: ${action.type}`);
  }
};

export const loadIssues = async (dispatch, query = '') => {
  try {
    const response = await axios.get(`http://api.hoyoung.me/api/issue?${query}`, {
      withCredentials: true,
    });
    console.log(response.data);
    dispatch({ type: 'LOAD', data: response.data });
  } catch (err) {
    console.log(err);
  }
};

const IssueStateContext = createContext();
const IssueDispatchContext = createContext();

export const IssueProvider = ({ children }) => {
  const [state, dispatch] = useReducer(issueReducer, []);
  useEffect(() => loadIssues(dispatch, 'q=is:open'), []);
  return (
    <IssueStateContext.Provider value={state}>
      <IssueDispatchContext.Provider value={dispatch}>{children}</IssueDispatchContext.Provider>
    </IssueStateContext.Provider>
  );
};

export const useIssueState = () => {
  const context = useContext(IssueStateContext);
  if (!context) {
    throw new Error('Cannot find issueProvider');
  }
  return context;
};

export const useIssueDispatch = () => {
  const context = useContext(IssueDispatchContext);
  if (!context) {
    throw new Error('Cannot find issueProvider');
  }
  return context;
};

import React, { useReducer, createContext, useContext, useEffect, dispatch } from 'react';
import axios from 'axios';

const labelReducer = (state, action) => {
  switch (action.type) {
    case 'LOAD':
      return (state = action.data);
    default:
      throw new Error(`Unhandled action type: ${action.type}`);
  }
};

const loadLabels = async (dispatch) => {
  try {
    const response = await axios.get('http://localhost:3000/api/label', {
      withCredentials: true,
    });
    dispatch({ type: 'LOAD', data: response.data.data });
  } catch (err) {
    console.log(err);
  }
};

const LabelStateContext = createContext();
const LabelDispatchContext = createContext();

export const LabelProvider = ({ children }) => {
  const [state, dispatch] = useReducer(labelReducer, []);
  useEffect(() => loadLabels(dispatch), []);
  return (
    <LabelStateContext.Provider value={state}>
      <LabelDispatchContext.Provider value={dispatch}>{children}</LabelDispatchContext.Provider>
    </LabelStateContext.Provider>
  );
};

export const useLabelState = () => {
  const context = useContext(LabelStateContext);
  if (!context) {
    throw new Error('Cannot find LabelProvider');
  }
  return context;
};

export const useLabelDispatch = () => {
  const context = useContext(LabelDispatchContext);
  if (!context) {
    throw new Error('Cannot find LabelProvider');
  }
  return context;
};

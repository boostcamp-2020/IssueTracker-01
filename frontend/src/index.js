import React from 'react';
import ReactDom from 'react-dom';
import App from './App.js';
import { BrowserRouter } from 'react-router-dom';
import { LabelProvider } from '@contexts/label';

ReactDom.render(
  <BrowserRouter>
    <LabelProvider>
      <App />
    </LabelProvider>
  </BrowserRouter>,
  document.getElementById('root'),
);

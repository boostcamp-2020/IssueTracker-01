import React from 'react';
import { Route } from 'react-router-dom';
import { UserProvider } from './contexts/user';
import Login from './pages/Login';
import Main from './pages/Main';
import Label from '@pages/Label';
import { LabelProvider } from '@contexts/label';

const App = () => {
  return (
    <UserProvider>
      <LabelProvider>
        <Route path="/" component={Login} exact />
        <Route path="/main" component={Main} />
        <Route path="/label" component={Label}
      </LabelProvider>
    </UserProvider>
  );
};

export default App;

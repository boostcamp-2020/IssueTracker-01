import React from 'react';
import { Route } from 'react-router-dom';
import { UserProvider } from './contexts/user';
import Login from './pages/Login';
import Main from './pages/Main';

const App = () => {
  return (
    <UserProvider>
      <Route path="/" component={Login} exact />
      <Route path="/main" component={Main} />
    </UserProvider>
  );
};

export default App;

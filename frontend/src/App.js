import React from 'react';
import Label from '@pages/Label';
import { Route } from 'react-router-dom';

const App = () => {
  return (
    <div>
      <Route path="/" exact={true}>
        <div>hello World</div>
      </Route>
      <Route path="/label" component={Label} />
    </div>
  );
};

export default App;

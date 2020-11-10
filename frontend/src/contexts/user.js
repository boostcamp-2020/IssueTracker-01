import React, { createContext, useState } from 'react';

const UserContext = createContext({
  userId: '',
  setUserId: () => {},
});

const UserProvider = ({ children }) => {
  const [userId, setUserId] = useState('');
  const value = {
    userId,
    setUserId,
  };
  return <UserContext.Provider value={value}>{children}</UserContext.Provider>;
};

const { Consumer: UserConsumer } = UserContext;

export { UserProvider, UserConsumer };

export default UserContext;

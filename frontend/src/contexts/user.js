import React, { createContext, useState } from 'react';

const UserContext = createContext({
  user: {
    userId: '',
    profileUrl: '',
  },
  setUser: () => {},
});

const UserProvider = ({ children }) => {
  const [user, setUser] = useState({
    userId: '',
    profileUrl: '',
  });
  const value = {
    user,
    setUser,
  };
  return <UserContext.Provider value={value}>{children}</UserContext.Provider>;
};

const { Consumer: UserConsumer } = UserContext;

export { UserProvider, UserConsumer };

export default UserContext;

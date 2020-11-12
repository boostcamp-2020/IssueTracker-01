import React, { createContext, useState, useEffect } from 'react';
import axios from 'axios';

export const UserListContext = createContext(null);

const UserListProvider = ({ children }) => {
    const [loading, setLoading] = useState(false);
    const [user, setUser] = useState(null);

    useEffect(() => {
        const getUsers = async () => {
            try {
                setLoading(true);
                setUser(null);

                const result = await axios.get('http://127.0.0.1:3000/api/user', { withCredentials: true });

                setUser(result.data.data);
            } catch (error) {
                throw error;
            }
            
            setLoading(false);
        }
        
        getUsers(); 
    }, []);

    if (loading) return null;
    if (!user) return null;

    return <UserListContext.Provider value={user}>
            { children }
    </UserListContext.Provider>
}

export default UserListProvider;

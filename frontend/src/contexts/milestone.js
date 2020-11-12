import React, { createContext, useState, useReducer, useEffect } from 'react';
import axios from 'axios';

const MilestoneReducer = (state, action) => {
    switch (action.type) {
        case "set":
            return action.list;
        case "create":
            return state.concat(action.milestone);
        case "update":
            state[action.milestoneId] = action.milestone;
            return state;
        case "delete":
            return state.filter(item => item.milestoneId !== action.milestoneId);
        default:
            throw new Error(`존재하지 않는 액션 타입`);
    }
}

export const MilestoneStateContext = createContext(null);
export const MilestoneDispatchContext = createContext(null);

const MilestoneProvider = ({ children }) => {
    const [loading, setLoading] = useState(false);
    const [state, dispatch] = useReducer(MilestoneReducer, []);

    useEffect(() => {
        const getMilestones = async () => {
            try {
                setLoading(true);

                const result = await axios.get('http://127.0.0.1:3000/api/milestone', { withCredentials: true });

                dispatch({type: 'set', list: result.data});
            } catch (error) {
                throw error;
            }
            
            setLoading(false);
        }
        
        getMilestones(); 
    }, []);

    if (loading) return null

    return <MilestoneStateContext.Provider value={state}>
        <MilestoneDispatchContext.Provider value={dispatch}>
            { children }
        </MilestoneDispatchContext.Provider>
    </MilestoneStateContext.Provider>
}

export default MilestoneProvider;

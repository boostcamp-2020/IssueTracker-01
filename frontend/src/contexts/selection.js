import React, { createContext, useState, useReducer, useEffect } from 'react';

export const SelectionsStateContext = createContext(null);
export const SelectionsSetContext = createContext(null);

const SelectionProvider = ({ children }) => {
    const [selections, setSelections] = useState({
        title: "",
        userId: "",
        assignees: "",
        milestoneId: "",
    });

    return <SelectionsStateContext.Provider value={selections}>
        <SelectionsSetContext.Provider value={setSelections}>
            { children }
        </SelectionsSetContext.Provider>
    </SelectionsStateContext.Provider>
}

export default SelectionProvider;

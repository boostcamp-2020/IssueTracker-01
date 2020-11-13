import React, { useContext } from 'react';
import styled from 'styled-components';
import MilestoneItem from '../../components/milestone/MilestoneItem';
import { MilestoneStateContext } from '../../contexts/milestone';

const TableListLayout = styled.ul`
    display: flex;
    flex-direction: column;

    margin: 0 auto;
    padding-left: 20px;
    padding-top: 10px;
    padding-bottom: 10px;

    border-style: solid;
    border-radius: 5px;
    border-width: 1px;
    border-color: #e1e4e8;

    list-style: none;
`;

const TableList = () => {
    const data = new Array(useContext(MilestoneStateContext))[0];
    console.log(data);
    return <TableListLayout>
            {data.map(milestone =>
                <MilestoneItem item={milestone} index={data.indexOf(milestone)} key={data.indexOf(milestone)}/>
            )}
    </TableListLayout>
}

export default TableList;

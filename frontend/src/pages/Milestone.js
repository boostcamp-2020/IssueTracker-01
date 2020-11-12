import React from 'react';
import styled from 'styled-components';
import TableListHeader from '../organisms/milestone/TableListHeader';
import TableList  from '../organisms/milestone/TableList';

const MilestonePage = styled.div`
    width: 78%;
    margin: 0 auto;
`;

const Milestone = () => {
    return <MilestonePage>
            <TableListHeader/>
            <TableList/>
    </MilestonePage>
}

export default Milestone;

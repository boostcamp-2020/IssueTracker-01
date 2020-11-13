import React from 'react';
import styled from 'styled-components';
import TableListHeader from '../organisms/milestone/TableListHeader';
import TableList  from '../organisms/milestone/TableList';
import TabButton from '../components/label/TabButton';
import GreenButton from '@components/utils/GreenButton';


const MilestonePage = styled.div`
    width: 78%;
    margin: 0 auto;
`;

const Buttons = styled.div`
  display: flex;
  margin-left: 8px;
  padding-left: 8px;
  justify-content: flex-end;
`;

const Milestone = () => {
    return <MilestonePage>
        <Buttons>
            <TabButton/>
            <GreenButton text="New milestone" onClick={() => (location.href = '/milestone-add')} />
        </Buttons>
        <TableListHeader/>
        <TableList/>
    </MilestonePage>
}

export default Milestone;

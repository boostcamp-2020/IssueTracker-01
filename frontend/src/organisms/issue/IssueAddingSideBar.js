import React, { useContext, useState } from 'react';
import styled from 'styled-components';

import MilestoneDueDate from '../../components/milestone/MilestoneDueDate';
import MilestoneGraph, { getStats } from '../../components/milestone/MilestoneGraph';

import { SelectionsStateContext, SelectionsSetContext } from '../../contexts/selection';
import { UserListContext } from '../../contexts/userList';
import { MilestoneStateContext } from '../../contexts/milestone';

const SideBarLayout = styled.div`
    padding: 10px;

    float: right;
`;

const AssigneesItem = styled.li`
    margin-top: 10px;
    padding: 0;

    list-style: none;
    color: #586069;
`;

const MilestoneItem = styled.li`
    display: flex;
    flex-direction: column;
    margin: 0 auto;
    margin-top: 10px;
    padding: 0;

    list-style: none;
    color: #586069;
`;

const SideSummary = styled.summary`
    outline: none;
    border: none;
`;

const MessageSpan = styled.span`
    display: flex;
    flex-direction: column;

    font-size: 0.9em;
    color: gray;
`;

const SelfAsssingedButton = styled.button`
    margin-top:5px;
    margin-left:5px;

    outline:none;
    border:none;

    font-weight: lighter;

    color: gray;
    background-color: rgba(0,0,255,0);

    &:hover {
        font-weight: bolder;
        color: #0366de;
        text-decoration: underline;
    }
`;

const SolidLine = styled.hr`
    margin-top: 25px;
    margin-bottom: 25px;

    border: 0.5px solid #e1e4e8;
`;

const ListLayout = styled.ul`
    padding: 0;
`;

const SelectedItem = styled.p`
    margin-bottom: 0;
`;

const AssigneesListItem = (props) => {
    if (props.user.userId === 'No one—') {
        return <SelectedItem>No one—</SelectedItem>
    }

    const ProfileImg = styled.img`
        width: 16px;
        height: 16px;

        margin-right: 12px;
        padding-top: 2px;
    `;
    
    const user = props.user;

    return <AssigneesItem value={user.profile_url}>
       <ProfileImg src={user.profile_url}/>
       {user.userId}
    </AssigneesItem>
}

const MilestoneListItem = (props) => {
    const milestone = props.milestone;
    const data = getStats(milestone.Issues);

    return <MilestoneItem value={data.per} className={milestone.title}>
       <p>{milestone.title}</p>
       <MilestoneDueDate dueDate={milestone.dueDate}/>
    </MilestoneItem>
}

const IssueAddingSideBar = () => {
    const users = useContext(UserListContext);
    const milestones = useContext(MilestoneStateContext);
    const selections = useContext(SelectionsStateContext);
    const setSelection = useContext(SelectionsSetContext);

    const [per, setPer] = useState(0);
    const [selectedTitle, setTitle] = useState('No milestone');

    const [userId, setUserId] = useState('No one—');
    const [profileUrl, setProfileUrl] = useState('none');

    const AssigneesSelected = (e) => {
        const assigneeUl = e.target.closest('ul');
        const className = assigneeUl.className.split(' ')[2];

        if (className === 'assignees_list') {
            const assigneesItem = e.target.closest('li');
            const userId = assigneesItem.innerText.split('\n')[0];
     
            setUserId(userId);
            setProfileUrl(assigneesItem.value);
            setSelection({
                ...selections,
                ['assignees']: userId
            });

            console.log(selections);

            const detailsTest = e.target.closest('details');
            detailsTest.open = false;
        }
    }

    const MilestoneSelected = (e) => {
        const milestoneUl = e.target.closest('ul');
        const className = milestoneUl.className.split(' ')[2];

        if (className === 'milestone_list') {
            const milestoneItem = e.target.closest('li');
            const milestonetitle = milestoneItem.innerText.split('\n')[0];

            setPer(milestoneItem.value);
            setTitle(milestonetitle);
            setSelection({
                ...selections,
                ['milestoneId']: milestonetitle
            });

            const detailsTest = e.target.closest('details');
            detailsTest.open = false;
        }
    }

    return <SideBarLayout>
        <details>
            <SideSummary className="Assignees">Assignees</SideSummary>
            <div onClick={AssigneesSelected}>
                <ListLayout className="assignees_list">
                    {users.map(user =>
                        <AssigneesListItem user={user} key={user.userId}/>    
                    )}
                </ListLayout>
            </div>
        </details>
        <MessageSpan>
            <AssigneesListItem user={{userId: userId, profile_url: profileUrl }}/>
            <SelfAsssingedButton>
                    assignee yourself
            </SelfAsssingedButton>
        </MessageSpan>
        <SolidLine/>
        <details>
            <SideSummary className="Labels">Labels</SideSummary>
            <div>

            </div>
        </details>
        <MessageSpan>None yet</MessageSpan>
        <SolidLine/>
        <details>
            <SideSummary className="Milestone">Milestone</SideSummary>
            <div onClick={MilestoneSelected}>
                <ListLayout className="milestone_list">
                    {milestones.map(milestone =>
                        <MilestoneListItem setPer={setPer} milestone={milestone} key={milestone.milestoneId}/>
                    )}
                </ListLayout>
            </div>
        </details>
        <MessageSpan>
            <MilestoneGraph per={per}/>
            <SelectedItem>{selectedTitle}</SelectedItem>
            </MessageSpan>
        <SolidLine/>
    </SideBarLayout>
}

export default IssueAddingSideBar;

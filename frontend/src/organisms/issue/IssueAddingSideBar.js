import React, { useContext, useState } from 'react';
import styled, { css } from 'styled-components';

import MilestoneDueDate from '../../components/milestone/MilestoneDueDate';
import MilestoneGraph, { getStats } from '../../components/milestone/MilestoneGraph';

import { SelectionsStateContext, SelectionsSetContext } from '../../contexts/selection';
import { UserListContext } from '../../contexts/userList';
import { MilestoneStateContext } from '../../contexts/milestone';
import { useLabelState } from '@contexts/label';

const SideBarLayout = styled.div`
    flex: 0.2;
    padding: 10px;
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
    margin-top: 5px;
`;

const SelectedItem = styled.p`
    margin-bottom: 0;
    margin-top:0;
`;

const LabelListItemLayout = styled.div`
    height: fit-content;

    display: flex;
    flex-direction: row;
`;

const LabelSpan = styled.span`
    width: fit-content;

    margin-top: 10px;
    padding: 5px 10px;

    display: flex;
    flex-direction: row;

    border-radius: 15px;

    font-size: 0.9em;
    background-color: red;

    ${(props) =>
        props &&
        css`
          background-color: ${props.color};
          padding: ${props.padding};
        `}
`;

const Circle = styled.div`
    background-color: red;
    width:16px;
    height:16px;
    border-radius: 50px;
    
    margin-right: 5px;
    margin-top: 3.5px;

    ${(props) =>
    props.color &&
    css`
      background-color: ${props.color};
    `}
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

    return <AssigneesItem>
       <ProfileImg src={user.profile_url}/>
       {user.userId}
    </AssigneesItem>
}

const LabelListItem = (props) => {
    const label = props.label;

    return <LabelListItemLayout className={label.color}>
        <Circle color={label.color}/>
        <SelectedItem>{label.labelName}</SelectedItem>
    </LabelListItemLayout>
}

const MilestoneListItem = (props) => {
    const milestone = props.milestone;
    const data = getStats(milestone.Issues);

    return <MilestoneItem value={data.per} className={milestone.title}>
       <SelectedItem>{milestone.title}</SelectedItem>
       <MilestoneDueDate dueDate={milestone.dueDate}/>
    </MilestoneItem>
}

const IssueAddingSideBar = () => {
    const users = useContext(UserListContext);
    const milestones = useContext(MilestoneStateContext);

    const selections = useContext(SelectionsStateContext);
    const setSelection = useContext(SelectionsSetContext);

    const labels = useLabelState();

    const [per, setPer] = useState(0);
    const [selectedTitle, setTitle] = useState('No milestone');

    const [color, setColor] = useState('white');
    const [selectedLabel, setLabel] = useState({text:'None yet', padding: "0"});

    const [userId, setUserId] = useState('No one—');
    const [profileUrl, setProfileUrl] = useState('none');

    const AssigneesSelected = (e) => {
        const assigneeUl = e.target.closest('ul');
        const className = assigneeUl.className.split(' ')[2];

        if (className === 'assignees_list') {
            const assigneesItem = e.target.closest('li');
            const userId = assigneesItem.innerText.split('\n')[0];
     
            setUserId(userId);
            setProfileUrl(assigneesItem.firstChild.src);
            setSelection({
                ...selections,
                ['assignees']: userId
            });

            const detailsTest = e.target.closest('details');
            detailsTest.open = false;
        }
    }

    const LabelSelected = (e) => {
        const labelUl = e.target.closest('ul');
        const className = labelUl.className.split(' ')[2];

        if (className === 'label_list') {
            const labelItem = e.target.closest('div');
            const labelTitle = labelItem.innerText.split('\n')[0];
            const circleColor = labelItem.className.split(' ')[2];
     
            setColor(circleColor);
            setLabel({text: labelTitle, padding: "5px 10px"});

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
            <div onClick={LabelSelected}>
                <ListLayout className="label_list">
                        {labels.map(label =>
                            <LabelListItem setPer={setPer} label={label} key={label.labelName}/>
                        )}
                </ListLayout>
            </div>
        </details>
        <LabelSpan color={color} padding={selectedLabel.padding}>
            <SelectedItem>{selectedLabel.text}</SelectedItem>
        </LabelSpan>
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

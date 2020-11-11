import React, { useContext, useRef, useState } from 'react';
import styled from 'styled-components';
import axios from 'axios';
import { MilestoneStateContext } from '../../contexts/milestone';

const InputLayout = styled.dd`
    margin-left: 0;
    margin-top: 10px;
    margin-bottom: 10px;
`;

const InputTitle = styled.input`
    width: 440px;
    height: 32px;

    border: 1px solid #e1e4e8;
    border-radius: 6px;
    outline: none;

    background-color: #fafbfc;
`;

const InputDate = styled.input`
    width: 442.8px;
    height: 32px;

    border: 1px solid #e1e4e8;
    border-radius: 6px;
    outline: none;

    background-color: #fafbfc;
`;
const InputDesc = styled.textarea`
    width: 600px;
    height: 200px;

    border: 1px solid #e1e4e8;
    border-radius: 6px;
    outline: none;

    background-color: #fafbfc;
`;

const SolidLine = styled.hr`

    border: 1px solid #eaecef;
    background-color: #eaecef;
`;

const MilestoneEditButtonsLayout = styled.div`
    display: flex;
    flex-direction: row-reverse;
`;

const PublicButtonStyled = styled.button`
    height: 34px;

    margin-right: 10px;
    padding: 1px 20px;

    font-size: 0.9em;
        
    outline: none;
    border: 1px solid #d1d4e8;
    border-radius: 6px;

    color: black;
    background-color: rgba(0, 0, 255, 0);
`;

const UpdateMilestoneButton = styled.button`
    width: 149px;
    height: 32px;

    font-size: 0.9em;
    
    outline: none;
    border: none;
    border-radius: 6px;

    color: white;
    background-color: #28a745;
`;

const MilestoneEditFrom = (props) => {
    const id = props.id;
    const data = useContext(MilestoneStateContext)[id];

    if (!data) return null;

    let desc = data.description;
    if (!data.description) desc = "";

    let date = data.dueDate.split('T')[0];
    if (!data.dueDate) date = "연도-월-일";
    console.log(date);

    const [text, setText] = useState({
        title: data.title,
        dueDate: date,
        description: desc,
    })

    const { title, dueDate, description } = text;

    const titleInput = useRef();
    const dueDateInput = useRef();
    const descInput = useRef();

    const updateButtonClicked = async () => {
        const result = await axios.patch(`http://localhost:3000/api/milestone/${Number(data.milestoneId)}`,
            {
                title: titleInput.current.value,
                dueDate: dueDateInput.current.value,
                description: descInput.current.value
            }
        );
        
        if (result.status === 200) {
            window.location.href = "http://localhost:8080/milestone";
        } else {
            alert('에러');
        }
    }

    const InputChange = (e) => {
        const { value, name } = e.target;

        setText({
            ...text,
            [name]: value
        })
    }

    return <div>
        <dl>
            <dt><label>Title</label></dt>
            <InputLayout>
                <InputTitle name="title" value={title} onChange={InputChange} type="text" ref={titleInput}></InputTitle>
            </InputLayout>
            <dt><label>Due date (optional)</label></dt>
            <InputLayout>
                <InputDate name="dueDate" value={dueDate} onChange={InputChange} type="date" ref={dueDateInput}></InputDate>
            </InputLayout>
            <dt><label>Description (optional)</label></dt>
            <InputLayout>
                <InputDesc name="description" value={description} onChange={InputChange} ref={descInput}/>
            </InputLayout>
            <SolidLine/>
            <MilestoneEditButtonsLayout>
                <UpdateMilestoneButton onClick={ updateButtonClicked }>Save changes</UpdateMilestoneButton>
                <PublicButtonStyled>Close milestone</PublicButtonStyled>
                <PublicButtonStyled>Cancel</PublicButtonStyled>
            </MilestoneEditButtonsLayout>
        </dl>
    </div>
}

export default MilestoneEditFrom;

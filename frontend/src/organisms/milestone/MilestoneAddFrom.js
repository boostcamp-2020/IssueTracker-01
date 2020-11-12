import React, { useRef } from 'react';
import styled from 'styled-components';
import axios from 'axios';

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

const MilestoneCreateButtonsLayout = styled.div`
    display: flex;
    flex-direction: row-reverse;
`;

const CreateMilestoneButton = styled.button`
    width: 149px;
    height: 32px;

    font-size: 0.9em;
    
    outline: none;
    border: none;
    border-radius: 6px;

    color: white;
    background-color: #28a745;
`;

const MilestoneAddFrom = () => {
    const createButtonClicked = async () => {
        const result = await axios.post("http://localhost:3000/api/milestone",
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

    const titleInput = useRef();
    const dueDateInput = useRef();
    const descInput = useRef();

    return <div>
        <dl>
            <dt><label>Title</label></dt>
            <InputLayout>
                <InputTitle placeholder="Title" type="text" ref={titleInput}></InputTitle>
            </InputLayout>
            <dt><label>Due date (optional)</label></dt>
            <InputLayout>
                <InputDate placeholder="연도-월-일" type="date" ref={dueDateInput}></InputDate>
            </InputLayout>
            <dt><label>Description (optional)</label></dt>
            <InputLayout>
                <InputDesc ref={descInput}/>
            </InputLayout>
            <SolidLine/>
            <MilestoneCreateButtonsLayout>
                <CreateMilestoneButton onClick={ createButtonClicked }>Create milestone</CreateMilestoneButton>
            </MilestoneCreateButtonsLayout>
        </dl>
    </div>
}

export default MilestoneAddFrom;

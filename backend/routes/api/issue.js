import issueService from '@services/issueService';
import { Router } from 'express';

const router = Router();

router.get('/assignee', issueService.getAssigneeCandidates);
router.patch('/assignee/:id', issueService.changeAssignee);
router.post('/issueLabel/:id', issueService.addLabel);
router.delete('/issueLabel/:id', issueService.removeLabel);
router.delete('/issueLabel/all', issueService.removeAllLabel);

export default router;

import issueService from '@services/issueService';
import { Router } from 'express';

const router = Router();

router.patch('/assignee/:id', issueService.updateAssignee);
router.post('/issueLabel/:id', issueService.addLabel);
router.delete('/issueLabel/:id', issueService.removeLabel);
router.delete('/issueLabel/all/:id', issueService.removeAllLabel);
router.patch('/:id', issueService.updateTitle);
router.patch('/:id/milestone', issueService.updateMilestone);
router.post('/', issueService.create);

export default router;

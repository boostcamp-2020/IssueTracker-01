import issueService from '@services/issueService';
import { Router } from 'express';

const router = Router();

router.patch('/assignee/:issueId', issueService.updateAssignee);
router.post('/issueLabel/:issueId', issueService.addLabel);
router.delete('/issueLabel/:issueId', issueService.removeLabel);
router.delete('/issueLabel/all/:issueId', issueService.removeAllLabel);
router.patch('/:issueId', issueService.updateTitle);
router.patch('/:issueId/milestone', issueService.updateMilestone);
router.patch('/status/:status/:issueId', issueService.updateIssueStatus);
router.post('/', issueService.create);
router.get('/', issueService.getIssueLists);
router.get('/detailIssue/:issueId', issueService.detailIssue);

export default router;

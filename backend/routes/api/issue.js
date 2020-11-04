import issueService from '@services/issueService';
import { Router } from 'express';

const router = Router();

router.get('/', issueService.getIssueLists);
router.get('/detailIssue/:issueId', issueService.detailIssue);

router.post('/', issueService.create);
router.post('/issueLabel/:issueId', issueService.addLabel);

router.patch('/:issueId', issueService.updateTitle);
router.patch('/assignee/:issueId', issueService.updateAssignee);
router.patch('/:issueId/milestone', issueService.updateMilestone);
router.patch('/status/:status/:issueId', issueService.updateIssueStatus);

router.delete('/issueLabel/:issueId', issueService.removeLabel);
router.delete('/issueLabel/all/:issueId', issueService.removeAllLabel);

export default router;

import issueService from '@services/issueService';
import { Router } from 'express';

const router = Router();

router.patch('/:id', issueService.updateTitle);
router.patch('/:id/milestone', issueService.updateMilestone);
router.post('/', issueService.create);

export default router;

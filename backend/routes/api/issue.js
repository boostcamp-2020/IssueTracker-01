import issueService from '@services/issueService';
import { Router } from 'express';

const router = Router();

router.patch('/:id', issueService.updateTitle);

export default router;

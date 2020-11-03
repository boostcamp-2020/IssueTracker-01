import issueService from '@services/issueService';
import { Router } from 'express';

const router = Router();

router.post('/', issueService.create);

export default router;

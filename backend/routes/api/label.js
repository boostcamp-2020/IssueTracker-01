import labelService from '@services/labelService.js';
import { Router } from 'express';

const router = Router();

router.get('/api/label', labelService.getLabels);
router.post('/api/label', labelService.createLabel);
router.patch('/api/label', labelService.updateLabel);
router.delete('/api/label', labelService.deleteLabel);

export default router;

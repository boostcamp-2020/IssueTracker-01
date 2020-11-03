import labelService from '@services/labelService.js';
import { Router } from 'express';

const router = Router();

router.get('/getLabels', labelService.getLabels);
router.post('/createLabel', labelService.createLabel);
router.patch('/updateLabel', labelService.updateLabel);
router.delete('/deleteLabel', labelService.deleteLabel);

export default router;

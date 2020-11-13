import labelService from '@services/labelService.js';
import { Router } from 'express';

const router = Router();

router.get('/', labelService.getLabels);
router.post('/', labelService.createLabel);
router.patch('/', labelService.updateLabel);
router.delete('/:labelName', labelService.deleteLabel);

export default router;

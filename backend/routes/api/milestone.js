import express from 'express';
import milestoneService from '@services/milestoneService';

const router = express.Router();

router.get('/', milestoneService.getMilestoneList);
router.get('/detail', milestoneService.getMilestone);
router.post('/', milestoneService.addMilestone);
router.patch('/:id', milestoneService.updateMilestone);
router.delete('/:id', milestoneService.deleteMilestone);

export default router;

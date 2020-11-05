import express from 'express';
import milestoneService from '@services/milestoneService';

const router = express.Router();

router.get('/', milestoneService.getMilestoneList);
router.get('/detail', milestoneService.getMilestone);
router.post('/', milestoneService.addMilestone);
router.patch('/:milestoneId', milestoneService.updateMilestone);
router.delete('/:milestoneId', milestoneService.deleteMilestone);

export default router;

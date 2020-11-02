import express from 'express';
import milestoneService from '../../services/milestoneService';

const router = express.Router();

router.get('/', milestoneService.getMilestoneList);
router.get('/detail', milestoneService.getMilestone);
router.post('/', milestoneService.addMilestone);

export default router;

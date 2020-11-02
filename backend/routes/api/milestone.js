import express from 'express';
import milestoneService from '../../services/milestoneService';

const router = express.Router();

router.get('/', milestoneService.getMilestoneList);

export default router;

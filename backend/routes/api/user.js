import userService from '@services/userService';
import { Router } from 'express';

const router = Router();

router.get('/', userService.getUsers);

export default router;

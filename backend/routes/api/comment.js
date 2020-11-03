import express from 'express';
import CommentService from '@services/commentService';

const router = express.Router();

router.post('/:issueId', CommentService.create);
router.get('/:issueId', CommentService.read);
router.put('/:commentId', CommentService.update);
router.delete('/:commentId', CommentService.del);

export default router;

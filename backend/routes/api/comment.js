import express from 'express';
import CommentService from '@services/commentService';

const router = express.Router();

router.post('/:issueId', CommentService.create);
router.get('/:issueId', CommentService.read);
router.patch('/:commentId', CommentService.update);
router.delete('/:commentId', CommentService.remove);

export default router;

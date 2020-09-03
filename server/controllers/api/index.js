'use strict';

const
	express = require('express'),
	votePollService = require('../../services/vote_polling');

let router = express.Router();

router.get('/get_all', votePollService.getPollsList);
router.get('/submit_vote', votePollService.submitVote);

module.exports = router;

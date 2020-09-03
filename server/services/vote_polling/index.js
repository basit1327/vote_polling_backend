'use strict';
const _ = require('lodash'),
	clc = require('cli-color'),
	queryBuilder = require('../../dataaccess/query_builder'),
	{failedToGetDatabaseConnection} = require('../../../configs/res_codes'),
	DbConnection = require('../../dataaccess/dbconnection').DbConnection;

const acceptedVotesValues = [0,1];

async function getPollsList (req,res){
	let connection;
	try {
		connection = await new DbConnection().getConnection();
		if ( connection ) {
			let query = new queryBuilder()
				.select([
					'id',
					'text',
					'date',
					'get_votes_count(id) as votesCount'
					]
				)
				.from('questions')
				.orderBy('questions.date',0);
			let dbRes = await connection.query(query.queryText,query.getParamValuesOnly());
			if ( _.has(dbRes,'[0].id') ){
				res.send({status:200,detail:'Successfully get list of polls',data:dbRes});
			} else {
				res.send({status:400,detail:'No record found..',data:[]});
			}
		} else {
			res.send({status: 400, detail: failedToGetDatabaseConnection.description});
		}
	}
	catch (e) {
		res.send({status: 400, detail: 'something went wrong while getting polls list'});
		console.log(clc.red(e));
	}
	finally {
		if ( connection ) {
			connection.release();
		}
	}
}

async function submitVote (req,res){
	let vote = req.query.vote;
	let questionId = req.query.questionId;
	if ( acceptedVotesValues.indexOf(Number(vote))===-1 || !Number(questionId)){
		res.send({status:400,detail:'Invalid vote casting..'});
		return;
	}

	let connection;
	try {
		connection = await new DbConnection().getConnection();
		if ( connection ) {
			let query = new queryBuilder()
				.insert([
						'question_id',
						'vote_value',
						'casted_at'
					]
				)
				.into('votes')
				.columnValues([Number(questionId),Number(vote),new Date()]);
			let dbRes = await connection.query(query.queryText,query.getParamValuesOnly());
			if ( _.has(dbRes,'insertId') ){
				res.send({status:200,detail:'Your vote is submitted'});
			} else {
				res.send({status:400,detail:'Something not fine, failed to add your vote'});
			}
		} else {
			res.send({status: 400, detail: failedToGetDatabaseConnection.description});
		}
	}
	catch (e) {
		res.send({status: 400, detail: 'something went wrong while adding your vote'});
		console.log(clc.red(e));
	}
	finally {
		if ( connection ) {
			connection.release();
		}
	}
}

module.exports = {
	getPollsList,
	submitVote
};

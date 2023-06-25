const VoterModel = require('../models/voter');

const bcrypt = require('bcrypt');

const path = require('path');

var nodemailer = require('nodemailer');

const saltRounds = 10;

module.exports = {
	create: function (req, res, cb) {
		VoterModel.findOne(
			{ email: req.body.email, election_address: req.body.election_address },
			function (err, result) {
				if (err) {
					cb(err);
				} else {
					if (!result) {
						VoterModel.create(
							{
								email: req.body.email,
								password: req.body.email,
								election_address: req.body.election_address,
							},
							function (err, voter) {
								if (err) cb(err);
								else {
									console.log(voter);

									console.log(voter.email);

									console.log(req.body.election_description);

									console.log(req.body.election_name);

									var transporter = nodemailer.createTransport({
										service: 'gmail',

										auth: {
											user: process.env.EMAIL,

											pass: process.env.PASSWORD,
										},
									});

									const mailOptions = {
										from: process.env.EMAIL, // sender address

										to: voter.email, // list of receivers

										subject: req.body.election_name, // Subject line

										html:
											req.body.election_description +
											'<br>Your voting id is:' +
											voter.email +
											'<br>' +
											'Your password is:' +
											voter.password +
											'<br><a href="http://localhost:3000/homepage">Click here to visit the website</a>', // plain text body
									};

									transporter.sendMail(mailOptions, function (err, info) {
										if (err) {
											res.json({
												status: 'error',
												message: 'Voter could not be added',
												data: null,
											});

											console.log(err);
										} else {
											console.log(info);

											res.json({
												status: 'success',
												message: 'Voter added successfully!!!',
												data: null,
											});
										}
									});
								}
							}
						);
					} else {
						res.json({ status: 'error', message: 'Voter already exists ', data: null });
					}
				}
			}
		);
	},
};
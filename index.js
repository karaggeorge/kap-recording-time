'use strict';
const path = require('path');
const execa = require('execa');
const electronUtil = require('electron-util/node');

const binary = path.join(electronUtil.fixPathForAsarUnpack(__dirname), 'kap-recording-time');

let process;

const config = {
	hideHours: {
		title: 'Hide Hours',
		description: 'Hide the hours digits until needed.',
		type: 'boolean',
		default: false,
		required: true
	}
};

const willStartRecording = ({config}) => {
	const {hideHours} = config.store;
	process = execa(binary, [hideHours && '--hide-hours'].filter(Boolean));
};

const didStartRecording = () => {
	// Start the timer
	process.stdin.write('\n');
};

const didStopRecording = () => {
	if (process) {
		process.kill();
		process = undefined;
	}
};

const recordingTime = {
	title: 'Show Recording Time',
	config,
	willStartRecording,
	didStartRecording,
	didStopRecording
};

exports.recordServices = [recordingTime];

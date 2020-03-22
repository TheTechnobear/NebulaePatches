/*
All of the secondary controls labelled, “alt” are accessed while holding down the source button.
• speed: 0-1 value of encoder + CV amount. Clicks between 0.625 and 0.375
• pitch: 0-1 value of encoder + 1V/Oct amount. Clicks to 0.6
• start: 0-1
• size: 0-1
• density: 0-1
• overlap: 0-1
• window: 0-1
• reset: 10ms 1 value sent when pressed or triggered.
• freeze: latching 0 or 1 control. Button is rising edge sensitive
• record: latching 0 or 1 control. Button is rising edge sensitive
• file: latching 0 or 1 control. Button is falling edge sensitive
• source: latching 0 or 1 control. Button is falling edge sensitive
• filestate: state of the file button independant of gate. 0 or 1
• sourcegate: state of the source gate input independant of button. 0 or 1
• pitch_alt: 0-1
• start_alt: 0-1
• size_alt: 0-1
• density_alt: 0-1
• overlap_alt: 0-1
• window_alt: 0-1
• reset_alt: 10ms 1 value sent when button is pressed in secondary control menu
• freeze_alt: latching 0 or 1 control. Button is rising edge sensitive
• record_alt: latching 0 or 1 control. Button is falling edge sensitive
• file_alt: latching 0 or 1 control. Button is falling edge sensitive
*/


s = Server.default;
s.options.bindAddress = "0.0.0.0";
s.options.maxLogins = 4;
s.options.blockSize = 64;
s.options.numInputBusChannels = 2;
s.options.numOutputBusChannels = 2;

s.waitForBoot{
"Server Booted".postln;
"Default patch".postln;
};


(
~rPort=3000;

// messages coming from the nebulae
OSCdef( \osc_speed, {
	arg msg, time, addr, recvPort;
},
'/neb/speed',recvPort:~rPort);

OSCdef( \osc_pitch, {
	arg msg, time, addr, recvPort;
},
'/neb/pitch',recvPort:~rPort);

OSCdef( \osc_start, {
	arg msg, time, addr, recvPort;
},
'/neb/start',recvPort:~rPort);

OSCdef( \osc_size, {
	arg msg, time, addr, recvPort;
},
'/neb/size',recvPort:~rPort);

OSCdef( \osc_density, {
	arg msg, time, addr, recvPort;
},
'/neb/density',recvPort:~rPort);

OSCdef( \osc_overlap, {
	arg msg, time, addr, recvPort;
},
'/neb/overlap',recvPort:~rPort);

OSCdef( \osc_window, {
	arg msg, time, addr, recvPort;
},
'/neb/window',recvPort:~rPort);

OSCdef( \osc_reset, {
	arg msg, time, addr, recvPort;
},
'/neb/reset',recvPort:~rPort);

OSCdef( \osc_freeze, {
	arg msg, time, addr, recvPort;
},
'/neb/freeze',recvPort:~rPort);

OSCdef( \osc_record, {
	arg msg, time, addr, recvPort;
},
'/neb/record',recvPort:~rPort);

OSCdef( \osc_file, {
	arg msg, time, addr, recvPort;
},
'/neb/file',recvPort:~rPort);

OSCdef( \osc_freeze, {
	arg msg, time, addr, recvPort;
},
'/neb/freeze',recvPort:~rPort);

OSCdef( \osc_source, {
	arg msg, time, addr, recvPort;
},
'/neb/source',recvPort:~rPort);

OSCdef( \osc_filestate, {
	arg msg, time, addr, recvPort;
},
'/neb/filestate',recvPort:~rPort);

OSCdef( \osc_sourcegate, {
	arg msg, time, addr, recvPort;
},
'/neb/sourcegate',recvPort:~rPort);

// alt forms
OSCdef( \osc_speed_alt, {
	arg msg, time, addr, recvPort;
},
'/neb/speed_alt',recvPort:~rPort);

OSCdef( \osc_pitch_alt, {
	arg msg, time, addr, recvPort;
},
'/neb/pitch_alt',recvPort:~rPort);

OSCdef( \osc_start_alt, {
	arg msg, time, addr, recvPort;
},
'/neb/start_alt',recvPort:~rPort);

OSCdef( \osc_size_alt, {
	arg msg, time, addr, recvPort;
},
'/neb/size_alt',recvPort:~rPort);

OSCdef( \osc_density_alt, {
	arg msg, time, addr, recvPort;
},
'/neb/density_alt',recvPort:~rPort);

OSCdef( \osc_overlap_alt, {
	arg msg, time, addr, recvPort;
},
'/neb/overlap_alt',recvPort:~rPort);
OSCdef( \osc_window_alt, {
	arg msg, time, addr, recvPort;
},
'/neb/window_alt',recvPort:~rPort);

OSCdef( \osc_reset_alt, {
	arg msg, time, addr, recvPort;
},
'/neb/reset_alt',recvPort:~rPort);

OSCdef( \osc_freeze_alt, {
	arg msg, time, addr, recvPort;
},
'/neb/freeze_alt',recvPort:~rPort);

OSCdef( \osc_record_alt, {
	arg msg, time, addr, recvPort;
},
'/neb/record_alt',recvPort:~rPort);

OSCdef( \osc_file_alt, {
	arg msg, time, addr, recvPort;
},
'/neb/file_alt',recvPort:~rPort);

OSCdef( \osc_freeze_alt, {
	arg msg, time, addr, recvPort;
},
'/neb/freeze_alt',recvPort:~rPort);

)


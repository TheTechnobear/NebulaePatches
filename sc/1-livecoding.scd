s = Server.default;
s.options.bindAddress = "0.0.0.0";
s.options.maxLogins = 4;
s.options.blockSize = 64;
s.options.numInputBusChannels = 2;
s.options.numOutputBusChannels = 2;

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

s.waitForBoot{
"Server Booted".postln;
"Live Coding patch".postln;


s.sync;
};



(
// osc /
~remote = nil;
~rPort=3000;

OSCdef( \liveConnect, {
	arg msg, time, addr, recvPort;
	'connect->'.post;msg[1].post; ' '.post;msg[2].postln;
	~remote = NetAddr(msg[1].asString, msg[2]); // remote server
}
,
'/live/connect',
recvPort:~rPort
);


//neb messages to forward
OSCdef( \osc_speed, { |msg, time, addr, recvPort|if(~remote != nil) { ~remote.sendMsg(msg[0],msg[1]) }} ,
'/neb/speed',recvPort:~rPort);
OSCdef( \osc_pitch, { |msg, time, addr, recvPort|if(~remote != nil) { ~remote.sendMsg(msg[0],msg[1]) }} ,
'/neb/pitch',recvPort:~rPort);
OSCdef( \osc_start, { |msg, time, addr, recvPort|if(~remote != nil) { ~remote.sendMsg(msg[0],msg[1]) }} ,
'/neb/start',recvPort:~rPort);
OSCdef( \osc_size, { |msg, time, addr, recvPort|if(~remote != nil) { ~remote.sendMsg(msg[0],msg[1]) }} ,
'/neb/size',recvPort:~rPort);
OSCdef( \osc_density, { |msg, time, addr, recvPort|if(~remote != nil) { ~remote.sendMsg(msg[0],msg[1]) }} ,
'/neb/density',recvPort:~rPort);
OSCdef( \osc_overlap, { |msg, time, addr, recvPort|if(~remote != nil) { ~remote.sendMsg(msg[0],msg[1]) }} ,
'/neb/overlap',recvPort:~rPort);
OSCdef( \osc_window, { |msg, time, addr, recvPort|if(~remote != nil) { ~remote.sendMsg(msg[0],msg[1]) }} ,
'/neb/window',recvPort:~rPort);
OSCdef( \osc_reset, { |msg, time, addr, recvPort|if(~remote != nil) { ~remote.sendMsg(msg[0],msg[1]) }} ,
'/neb/reset',recvPort:~rPort);
OSCdef( \osc_freeze, { |msg, time, addr, recvPort|if(~remote != nil) { ~remote.sendMsg(msg[0],msg[1]) }} ,
'/neb/freeze',recvPort:~rPort);
OSCdef( \osc_record, { |msg, time, addr, recvPort|if(~remote != nil) { ~remote.sendMsg(msg[0],msg[1]) }} ,
'/neb/record',recvPort:~rPort);
OSCdef( \osc_file, { |msg, time, addr, recvPort|if(~remote != nil) { ~remote.sendMsg(msg[0],msg[1]) }} ,
'/neb/file',recvPort:~rPort);
OSCdef( \osc_freeze, { |msg, time, addr, recvPort|if(~remote != nil) { ~remote.sendMsg(msg[0],msg[1]) }} ,
'/neb/freeze',recvPort:~rPort);

OSCdef( \osc_source, { |msg, time, addr, recvPort|if(~remote != nil) { ~remote.sendMsg(msg[0],msg[1]) }} ,
'/neb/source',recvPort:~rPort);
OSCdef( \osc_filestate, { |msg, time, addr, recvPort|if(~remote != nil) { ~remote.sendMsg(msg[0],msg[1]) }} ,
'/neb/filestate',recvPort:~rPort);
OSCdef( \osc_sourcegate, { |msg, time, addr, recvPort|if(~remote != nil) { ~remote.sendMsg(msg[0],msg[1]) }} ,
'/neb/sourcegate',recvPort:~rPort);

// alt forms
OSCdef( \osc_speed_alt, { |msg, time, addr, recvPort|if(~remote != nil) { ~remote.sendMsg(msg[0],msg[1]) }} ,
'/neb/speed_alt',recvPort:~rPort);
OSCdef( \osc_pitch, { |msg, time, addr, recvPort|if(~remote != nil) { ~remote.sendMsg(msg[0],msg[1]) }} ,
'/neb/pitch_alt',recvPort:~rPort);
OSCdef( \osc_start_alt, { |msg, time, addr, recvPort|if(~remote != nil) { ~remote.sendMsg(msg[0],msg[1]) }} ,
'/neb/start_alt',recvPort:~rPort);
OSCdef( \osc_size_alt, { |msg, time, addr, recvPort|if(~remote != nil) { ~remote.sendMsg(msg[0],msg[1]) }} ,
'/neb/size_alt',recvPort:~rPort);
OSCdef( \osc_density_alt, { |msg, time, addr, recvPort|if(~remote != nil) { ~remote.sendMsg(msg[0],msg[1]) }} ,
'/neb/density_alt',recvPort:~rPort);
OSCdef( \osc_overlap_alt, { |msg, time, addr, recvPort|if(~remote != nil) { ~remote.sendMsg(msg[0],msg[1]) }} ,
'/neb/overlap_alt',recvPort:~rPort);
OSCdef( \osc_window_alt, { |msg, time, addr, recvPort|if(~remote != nil) { ~remote.sendMsg(msg[0],msg[1]) }} ,
'/neb/window_alt',recvPort:~rPort);
OSCdef( \osc_reset_alt, { |msg, time, addr, recvPort|if(~remote != nil) { ~remote.sendMsg(msg[0],msg[1]) }} ,
'/neb/reset_alt',recvPort:~rPort);
OSCdef( \osc_freeze_alt, { |msg, time, addr, recvPort|if(~remote != nil) { ~remote.sendMsg(msg[0],msg[1]) }} ,
'/neb/freeze_alt',recvPort:~rPort);
OSCdef( \osc_record_alt, { |msg, time, addr, recvPort|if(~remote != nil) { ~remote.sendMsg(msg[0],msg[1]) }} ,
'/neb/record_alt',recvPort:~rPort);
OSCdef( \osc_file_alt, { |msg, time, addr, recvPort|if(~remote != nil) { ~remote.sendMsg(msg[0],msg[1]) }} ,
'/neb/file_alt',recvPort:~rPort);
OSCdef( \osc_freeze_alt, { |msg, time, addr, recvPort|if(~remote != nil) { ~remote.sendMsg(msg[0],msg[1]) }} ,
'/neb/freeze_alt',recvPort:~rPort);

)






/*
m = NetAddr("127.0.0.1", ~rPort); // testing loopback
m.sendMsg("/live/connect", '127.0.0.1',4000);
m.sendMsg("/neb/pitch", 0.5);
m.sendMsg("/neb/density", 0.6);

(
OSCdef( \nebRemote, {
	|msg, time, addr, recvPort| 'remote->'.postln;msg[0].post;msg[1].postln;},'/neb/pitch',recvPort:4000 );

OSCdef( \nebRemote2, {
	|msg, time, addr, recvPort| 'remote->'.postln;msg[0].post;msg[1].postln;},'/neb/density',recvPort:4000 );
)
*/


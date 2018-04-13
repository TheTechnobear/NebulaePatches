/*
Live Coding Template : Mark Harris (aka TheTechnobear)
This is an example of the what you might need for your supercollider patch on the Nebulae that you wish to interact with remotely (e.g. laptop/desktop)
It fulfils two roles,
- forwarding osc messages from nebulae to your remote computer
- informs remote computer of audio files present on nebulae

there are two use cases:
a) Live Coding
where you want to do everything remotely on your computer, either for performance or this is also useful for developing patches for the Nebulae
for this usage, you can use this patch 'as-is', and use the example at the base of this patch as a starting point for remote side.

b) Optimised remote live performance with dedicated patch.
The 'issue' with using this patch 'as-is' is that all CV messages are sent over the network, regardless of if you need them or not!
so an alternative option is...
develop your synth patch 'as normal' (to run on the nebulae), then copy n' paste this patch into your patch
and remove any OSCdef for forwarding that you do not need to be forwarded to your remote client.
this approach will allow you to influence some parts of the patch on nebulae.
(you can also extend the use of the client->nebulae connection for other osc messages to control patch)
*/




/*
OSC messages
/neb/+ nebulae messages e.g. /neb/speed

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


Live Coding support (see bottom of patch for examples)
send : /live/connect(host,port) - connect to nebulae, and proxy nebulae messages to host/port
/live/audiofile - file that exists on nebulae (server), you cannot use SoundFile.collect as that is client side

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
	SoundFile.collect("/home/alarm/audio/*").do { |f| ~remote.sendMsg("/live/audiofile",f.path); };
}
,
'/live/connect',
recvPort:~rPort
);


//neb messages to forward to remote client
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
OSCdef( \osc_pitch_alt, { |msg, time, addr, recvPort|if(~remote != nil) { ~remote.sendMsg(msg[0],msg[1]) }} ,
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
// EXAMPLE PATCH USED ON REMOTE CLIENT \
you'll need/want something like this live-coding is running on nebulae

// connect to nebulae
~nebulaeip= '192.168.1.65';
s.options.maxLogins = 4;
Server.default = s = Server.remote("nebulae", NetAddr(~nebulaeip.asString,57110),s.options,1);
s.initTree;
s.startAliveThread;

~localip = '192.168.1.18';
~rPort=3000;


// on connection we will get a list of audio files on the nebulae
~audio_files = List.new;
OSCdef(\liveaudiofile,
	{
		arg msg, time, addr, recvPort;
		msg[1].postln;
		~audio_files.add(msg[1]);
	},
	'/live/audiofile',
	recvPort:~rPort
);

//connect to live patch, and ask for redirection
m = NetAddr(~nebulaeip.asString, ~rPort);
m.sendMsg("/live/connect",~localip,~rPort);


// note from here on, the patch would be the same as run on the Nebulae

// lets see register some messages to test
// (you can pickup all the inbound messages from 0-default template)

OSCdef( \osc_speed, {
	arg msg, time, addr, recvPort;
    'remote->'.postln;msg[0].post;msg[1].postln;
},
'/neb/speed',recvPort:~rPort);

OSCdef( \osc_pitch, {
	arg msg, time, addr, recvPort;
    'remote->'.postln;msg[0].post;msg[1].postln;
},
'/neb/pitch',recvPort:~rPort);

// what audio files are there?
~audio_files.do { |f| f.postln;};

// note:
// SoundFile.collect won't work, see this is run client side...
// Buffer.read, expects a server file ... so something like Buffer.read(~audio_files[0]);


*/


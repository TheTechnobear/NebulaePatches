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
s.options.memSize = 131072;
s.options.bindAddress = "0.0.0.0";
s.options.maxLogins = 4;
s.options.blockSize = 64;
s.options.numInputBusChannels = 2;
s.options.numOutputBusChannels = 2;

~rPort=3000;

~synth = nil;

s.waitForBoot{
	"Server Booted".postln;
	"BufGrain patch".postln;

	~path="/home/alarm/audio/*";~audio_files= List.new;
	SoundFile.collect(~path).do { |f| ~audio_files.add(f.path);}

	SynthDef(\sdGrainBuf, {
		arg sndbuf, gate = 1,
		amp = 0.6, density = 10,
		dur=0.1, rate=1.0,
		pos=0, interp=2,
		pan=0, envbufnum = -1,
		maxgrains=10;

		var sig,env, gen;
		env = EnvGen.kr(
				Env([0, 1, 0], [1, 1], \sin, 1),
				gate,
				levelScale: amp,
				doneAction: 2);

		gen = Impulse.kr(density);

		sig = GrainBuf.ar(
			2,
			gen,
			dur,
			sndbuf,
			rate,
			pos,
			interp,
			pan,
			envbufnum,
			maxgrains,
		);
		Out.ar(0,sig);
	}
	).add;

	s.sync;
	z = Buffer.read(s,~audio_files[0]);
	~synth = Synth(\sdGrainBuf,[\sndbuf, z, \maxgrains, 10]);
};

(

OSCdef( \osc_start, {
	arg msg, time, addr, recvPort;
	if (~synth!=nil) {~synth.set(\pos,msg[1])};
},
'/neb/start',recvPort:~rPort);

OSCdef( \osc_speed, {
	arg msg, time, addr, recvPort;
	if (~synth!=nil) {~synth.set(\rate,msg[1].linlin(0,1,-5,5))};
},
'/neb/speed',recvPort:~rPort);


OSCdef( \osc_size, {
	arg msg, time, addr, recvPort;
	if (~synth!=nil) {~synth.set(\dur,msg[1])};
},
'/neb/size',recvPort:~rPort);

OSCdef( \osc_density, {
	arg msg, time, addr, recvPort;
	if (~synth!=nil) {~synth.set(\density,msg[1].linlin(0,1,1,100))};
},
'/neb/density',recvPort:~rPort);


OSCdef( \osc_window, {
	arg msg, time, addr, recvPort;
	if (~synth!=nil) {~synth.set(\interp,msg[1].linlin(0,1,1,4))};
},
'/neb/window',recvPort:~rPort);

)

// // testing
// m = NetAddr("localhost",~rPort);
// m.sendMsg("/neb/start",0.0);
// m.sendMsg("/neb/size",1);
// m.sendMsg("/neb/speed",0.6);
// m.sendMsg("/neb/density",0.0);
// m.sendMsg("/neb/window",0.5);
// ~synth.set(\gate,0);
// SoundFile.collect(Platform.resourceDir +/+ "sounds/*")
// .do { |f| f.path.postln };


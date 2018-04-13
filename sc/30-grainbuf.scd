~rPort=3000;
~synth = nil;
~audio_files = nil;
~audio_bufs = List.new;
~dict = Dictionary.new;

s.waitForBoot{
	"Server Booted".postln;
	"GrainBuf patch".postln;

	~path="/home/alarm/audio/*";~audio_files= List.new;
	SoundFile.collect(~path).do { |f| ~audio_files.add(f.path);};
	~audio_files.do { | f| ~audio_bufs.add(Buffer.readChannel(s,f,channels:[0]))};

	SynthDef(\sdGrainBuf, {
		arg sndbuf, gate = 1,
		amp = 0.6, density = 10,
		dur=0.1, rate=1.0,
		pos=0, interp=2,
		pan=0, envbufnum = -1,
		maxgrains=512;

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
	2.wait;
	
        ~dict.add(\nbuf -> 0);
        ~dict.add(\sndbuf -> ~audio_bufs[0]);
	~dict.postln;
	~synth = Synth(\sdGrainBuf,~dict.asPairs);
};

(

OSCdef( \osc_file, {
	arg msg, time, addr, recvPort;
	var v;
	if (~audio_files!=nil) {"audio file".post;~audio_files[msg[1]].postln};
	if (~synth!=nil) {
		v = ~audio_bufs[msg[1]];
		~synth.set(\sndbuf,v);
		~synth.set(\nbuf,msg[1]);
	};
        ~dict.add(\sndbuf -> v);
        ~dict.add(\nbuf -> msg[1]);
},
'/neb/file',recvPort:~rPort);

OSCdef( \osc_start, {
	arg msg, time, addr, recvPort;
	if (~synth!=nil) {~synth.set(\pos,msg[1])};
        ~dict.add(\start -> msg[1]);
},
'/neb/start',recvPort:~rPort);

OSCdef( \osc_speed, {
	arg msg, time, addr, recvPort;
        var v= msg[1].linlin(0,1,-5,5);
	if (~synth!=nil) {~synth.set(\rate,v)};
        ~dict.add(\rate -> v);
},
'/neb/speed',recvPort:~rPort);


OSCdef( \osc_size, {
	arg msg, time, addr, recvPort;
	if (~synth!=nil) {~synth.set(\dur,msg[1])};
        ~dict.add(\dur -> msg[1]);
},
'/neb/size',recvPort:~rPort);

OSCdef( \osc_density, {
	arg msg, time, addr, recvPort;
        var v= msg[1].linlin(0,1,1,100);
	if (~synth!=nil) {~synth.set(\density,v)};
        ~dict.add(\density -> v);
},
'/neb/density',recvPort:~rPort);


OSCdef( \osc_window, {
	arg msg, time, addr, recvPort;
        var v= msg[1].linlin(0,1,1,4);
	if (~synth!=nil) {~synth.set(\interp,v)};
        ~dict.add(\interp -> v);
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


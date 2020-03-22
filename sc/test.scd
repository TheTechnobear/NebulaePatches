~synthdef=SynthDef(\testSynth, {
        arg freq =440;
        var sig;
        sig = Saw.ar(freq);
        Out.ar(0,sig!2);
    }
);
~synth=nil;

OSCdef( \oscPitch, {
        arg msg, time, addr, recvPort;
	    ~synth.set(\freq, msg[1].linlin(0,1,440,880));
    },
    "/neb/pitch",
    recvPort:3000
);

s.boot;
s.doWhenBooted {
    ~synthdef.add;
    1.wait;
    ~synth=Synth.new(\testSynth);
};


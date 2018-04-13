s.waitForBoot{
"Server Booted".postln;
"Simple Test Synth".postln;

SynthDef(\testSynth, {
        arg freq =440;
        var sig;
        sig = Saw.ar(freq);
        Out.ar(0,sig!2);
}).add;

OSCdef( \oscPitch, {
    arg msg, time, addr, recvPort;
    ~synth.set(\freq, msg[1].linlin(0,1,440,880));
},
"/neb/pitch",
recvPort:3000
);

s.sync;

~synth=Synth.new(\testSynth);

};


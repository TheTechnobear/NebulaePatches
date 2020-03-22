s = Server.default;

s.options.bindAddress = "0.0.0.0";
s.options.maxLogins = 4;
s.options.blockSize = 64;
s.options.numInputBusChannels = 2;
s.options.numOutputBusChannels = 2;

s.waitForBoot{
"Server Booted".postln;
}


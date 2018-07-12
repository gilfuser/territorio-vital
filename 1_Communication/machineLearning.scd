// tracking amplitude
(
Ndef(\machineLearning, {
	var sound = LFNoise2.ar(5/*mul:LFNoise2.kr(1).range(0,1)*/); // source
	// RunningSum.rms(sound).poll(label:'rms'); // rms
	Amplitude.kr(sound).poll(label:'peak'); // peak
	/*
	Peak.kr(sound, Impulse.kr(1)).poll(label:'peak_trig');
	// peak when triggered
	PeakFollower.kr(sound).poll(label:'peak_dec'); // peak with decay
	RunningMin.kr(sound).poll(label:'min'); // minimum
	RunningMax.kr(sound).poll(label:'max'); // maximum
	*/
	Out.ar(6,sound); // write to output
});
);
Ndef(\machineLearning).gui;
b = a.play;
b.free

(
MFdef(\dataPlay).add(\setBusses, { |data|
	~pulse1.set(data[0].linlin(0,1024,-1,1));
	~pulse2.set(data[1].linlin(0,1024,-1,1));
	~pulse3.set(data[2].linlin(0,1024,-1,1));
	~pulse4.set(data[3].linlin(0,1024,-1,1))
});
);

// FROM ARDUINO SEND-RECEIVE
(
MFdef(\arduino).add(\setBusses, { |data|
	var hpf, galv;
	~pulse1.set(data[0].linlin(256,768,0,1));
	~pulse2.set(data[1].linlin(0,1024,0,1));
	~galvanic1.set(data[2]);
});
);
MFdef(\arduino).remove(\setBusses);

// filter galvanic
Ndef(\processInput).addSpec(\lower, [0, 896, 0, 128]);
Ndef(\processInput).addSpec(\upper, [512, 1023, 1, 128]);

(
Ndef(\processInput, { | offset = 0 upper = 1023 lower = 512 |
	var pulse2, pulsefilt, min, max, peak;
	pulse2 = ~pulse2.kr + offset; //.poll(label:'pulse1');
	pulsefilt = {RunningMin.kr(pulse2, Impulse.ar(1)).poll(label:'min')}.poll; // minimum
	// .linlin(lower,upper,0,1);
	// galv = LPF2Casc.kr(galv, 5, 10);
	Out.kr(5, pulse2)
});
);
Ndef(\processInput).gui;



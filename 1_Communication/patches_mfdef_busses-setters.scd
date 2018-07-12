// FROM DATA-PLAY
(
MFdef(\dataPlay).add(\setBusses, { |data|
	~pulse1.set(data[0].linlin(0,1024,0,1));
	~pulse2.set(data[1].linlin(0,1024,0,1));
	~pulse3.set(data[2].linlin(0,1024,0,1));
	~pulse4.set(data[3].linlin(0,1024,0,1))
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
	var galv;
	galv = ~galvanic1.kr.linlin(lower,upper,0,1);
	galv = LPF2Casc.kr(galv, 5, 10);
	Out.kr(5, galv)
});
);

Ndef(\test).gui;
MFdef(\test).add(\post, {|data| data[2].postln});
MFdef(\arduino).remove(\post);
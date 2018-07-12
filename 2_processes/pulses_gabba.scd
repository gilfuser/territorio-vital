Ndef(\gabba1).ar(1);
(
Ndef(\gabba1, {
    var trig = Trig1.kr(
		HPZ1.kr( \threshold.kr(0.15) >= ~pulse1.kr )
	);
    var freq = ZeroCrossing.kr( ~pulse1.kr.lag(0.2) ).lag(1);
    var frecip = (freq + 0.001).reciprocal.clip(0.001,1);
    var env = Env.perc( 0.001, frecip * LFNoise2.kr(0.12).range(1, 1.25) ).ar(gate: trig);
    var sig = SinOsc.ar(
		Lag3UD.kr( trig, 0.001, frecip ).exprange( 43.6, 87.3 ) * [-0.1, 0, 0.1].midiratio,
		0.5pi
	);
    sig = (
		sig * env * Lag3UD.kr(
			trig, 0.001, LFNoise2.kr(0.12).range(1.2, 1.7)
		).exprange(
			1, LFNoise2.kr(0.12).range(1.7, 2.4)
		)
	).tanh; // kind of rezonator (?)
	sig = BPeakEQ.ar(
		sig, LFCub.kr(0.12, 1.5pi).exprange( 61.7, 164.8 ), 0.3, 2
	); // more rezon. not sure if its necessary
	sig = (sig * 4).tanh; // distortion!
	sig = BPeakEQ.ar(
		sig, LFCub.kr(0.08, 0.5pi).exprange(61.7, 2793.8), 0.4, 6
	); // filter mod
	sig = (
		sig * Lag3UD.kr(
			trig, 0.001, LFNoise2.kr(0.06).range(0.5, 3)
		).exprange(1, LFNoise2.kr(0.1).range(3, 10) )
	).tanh; // more distortion
	sig = Compander.ar( sig, sig, 0.1, 1, 1/40, 0.05, 0.2 );  // heavy compression
	sig = HPF2Casc.ar(sig, 22, 10);  // filter out only very low freqs
	sig = BLowPass4.ar(
		sig,
		Lag3UD.kr( trig, 0.01, 1 ).exprange(43.6, 11175.3),
		LFNoise2.kr(0.12).range(0.25, 0.5)
	);  // filter mod
	sig = LeakDC.ar(sig);
    Mix(sig) * \amp.kr(0.4);
});
);

///////////////////////////////////////////////////////////////////

Ndef(\gabba2).ar(1);
(
Ndef(\gabba2, {
    var trig = Trig1.kr( HPZ1.kr( \threshold.kr(0.15) >= ~pulse2.kr ) );
    var freq = ZeroCrossing.kr( ~pulse2.kr.lag(0.2) ).lag(1);
    var frecip = ( freq + 0.001 ).reciprocal.clip(0.001, 1);
    var env = Env.perc( 0.001, frecip * LFNoise2.kr(0.12).range(1, 1.25) ).ar(gate: trig);
    var sig = SinOsc.ar( Lag3UD.kr( trig, 0.001, frecip ).exprange( 51.913, 103.826 ) * [-0.1, 0, 0.1].midiratio, 0.5pi );
    sig = sig * env;
    sig = ( sig * Lag3UD.kr( trig, 0.001, LFNoise2.kr(0.12).range(1.2, 1.7) ).exprange( 1, LFNoise2.kr(0.12).range(1.7, 2.4) ) ).tanh;
    sig = BPeakEQ.ar(sig, LFCub.kr(0.12, 1.5pi).exprange(51.913, 207.652), 0.3, 2);
    sig = (sig * 4).tanh;
    sig = BPeakEQ.ar(sig, LFCub.kr(0.08, 0.5pi).exprange(51.913, 2793.826), 0.4, 6);
    sig = (sig * Lag3UD.kr(trig, 0.001, LFNoise2.kr(0.06).range(0.5, 3)).exprange(1, LFNoise2.kr(0.1).range(3, 10))).tanh;
    sig = Compander.ar( sig, sig, 0.1, 1, 1/40, 0.001, 0.17 );
    sig = HPF2Casc.ar(sig, 22, 10);
    sig = BLowPass4.ar( sig, Lag3UD.kr( trig, 0.01, 1 ).exprange(51.913, 11175.303), LFNoise2.kr(0.12).range(0.2, 0.6) );
	sig = LeakDC.ar(sig);
    Mix(sig) * \amp.kr(0.4);
});
);

///////////////////////////////////////////////////////////////////

Ndef(\gabba3).ar(1);
(
Ndef(\gabba3, {
    var trig = Trig1.kr( HPZ1.kr( \threshold.kr(0.15) >= ~pulse3.kr ) );
    var freq = ZeroCrossing.kr( ~pulse3.kr.lag(0.2) ).lag(1);
    var frecip = ( freq + 0.001 ).reciprocal.clip(0.001, 1);
    var env = Env.perc( 0.001, frecip * LFNoise2.kr(0.15).range(frecip, freq*0.5) ).ar(gate: trig);
    var sig = SinOsc.ar(
		Lag3UD.kr( trig, 0.001, frecip ).exprange(
			( freq * 10 ).lag2ud(1), ( freq * 20 ).lag2ud(1)
		) * [ -0.1, 0, 0.1 ].midiratio, 0.5pi
	);
    sig = sig * env;
	sig = (
		sig * Lag3UD.kr(
			trig, 0.001, LFNoise2.kr( frecip * 0.25 ).range( frecip * 0.25, frecip * 0.33 )
		).exprange(
			1, LFNoise2.kr(0.12).range(freq, freq/*2/3*/)
		)
	).tanh;
    sig = BPeakEQ.ar(sig, LFCub.kr(0.12, 1.5pi).exprange(51.913, 207.652), 0.3, 2);
    sig = (sig * 4).tanh;
    sig = BPeakEQ.ar(sig, LFCub.kr(0.08, 0.5pi).exprange(46.249, 246.942), 0.4, 6);
    sig = ( sig * Lag3UD.kr(trig, 0.001, LFNoise2.kr(0.06).range(frecip, 3)).exprange(1, LFNoise2.kr(0.1).range(3, 10)) ).tanh;
    sig = Compander.ar( sig, sig, 0.5, 1, 1/40, 0.17, 0.05 );
    sig = HPF2Casc.ar(sig, 65.406, 10);
	// sig = BLowPass4.ar( sig, Lag3UD.kr( trig, 0.01, 1 ).exprange(43.654, 11175.303), LFNoise2.kr(0.12).range(0.25, 0.5) );
	sig = LeakDC.ar(sig);
	sig = Limiter.ar(sig, 0.5);
    Mix(sig) * \amp.kr(0.1);
});
);

Ndef(\gabba3).gui;

///////////////////////////////////////////////////////////////////

Ndef(\gabba4).ar(1);
(
Ndef(\gabba4, {
    var trig = Trig1.kr( HPZ1.kr( \threshold.kr(0.15) >= ~pulse4.kr ) );
    var freq = ZeroCrossing.kr( ~pulse4.kr.lag(0.2) ).lag(1);
    var frecip = ( freq + 0.001 ).reciprocal.clip(0.001, 1);
    var env = Env.perc( 0.001, frecip * LFNoise2.kr(0.12).range(1, 1.25) ).ar(gate: trig);
    var sig = SinOsc.ar( ( Lag3UD.kr( trig, 0.001, frecip ) ).exprange( 52, 104 ) * [-0.1, 0, 0.1].midiratio, 0.5pi );
    sig = sig * env;
    sig = ( sig * Lag3UD.kr( trig, 0.001, LFNoise2.kr(0.12).range(1.2, 1.7) ).exprange( 1, LFNoise2.kr(0.12).range(1.7, 2.4) ) ).tanh;
    sig = BPeakEQ.ar( sig, LFCub.kr(0.12, 1.5pi).exprange( 61.74, 164.81 ), 0.3, 2 );
    sig = (sig * 4).tanh;
    sig = BPeakEQ.ar(sig, LFCub.kr(0.08, 0.5pi).exprange( 73.4, 2794 ), 0.4, 6);
    sig = (sig * Lag3UD.kr( trig, 0.001, LFNoise2.kr(0.06).range( 0.5, 3) ).exprange(1, LFNoise2.kr(0.1).range(3, 10) ) ).tanh;
    sig = Compander.ar( sig, sig, 0.1, 1, 1/40, 0.05, 0.2 );
    sig = HPF2Casc.ar( sig, 21.827, 10 );
    sig = BLowPass4.ar( sig, Lag3UD.kr( trig, 0.01, 1 ).exprange(61.74, 11175.303), LFNoise2.kr(0.12).range( 0.25, 0.5 ) );
	sig = LeakDC.ar(sig);
    Mix(sig) * \amp.kr(0.1);
});
);
"pulses_gabba - LOADED".postString;
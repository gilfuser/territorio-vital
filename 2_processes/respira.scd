Ndef(\t_resp1).ar(4);
Ndef(\t_resp1).fadeTime = 8;
Ndef(\t_resp1).addSpec(\xpos, [-1, 1]);
Ndef(\t_resp1).addSpec(\ypos, [-1, 1]);

(
Ndef(\t_resp1,{
    var trig = Trig1.kr(Impulse.kr(LFNoise2.kr(0.1).range(8, 10)));
    var mod = (~resp1.kr + 0.02).clip(0,1);
    var peak = RunningMax.kr(mod, Impulse.kr(0.1)); // CHECK IT!
    var fb = LocalIn.ar(4);
    var bg = BLowPass4.ar(
        SawDPW.ar( [LFTri.kr(1/32).exprange(65.93, 67.613), LFTri.kr(1/32).exprange(55, 56.635) ]).sum,
        mod.linexp(0, peak, 349.2 + (mod*1000).lag2(0.2), 1491.91), // << AQUI!
        0.3, mul:-35.dbamp
    );
    var sig = Formant.ar(
        Decay2.ar(K2A.ar(trig), 0.001, mod * 8 + 0.1 ).exprange(34.93, 39.20),
        Decay2.ar(K2A.ar(trig), 0.001, mod * 8 + 0.1 ).exprange(49.39, 55.44),
        Decay2.ar(K2A.ar(trig), 0.001, mod * 8 + 0.1 ).exprange(39.20, 46.62)
    );
    fb = DelayC.ar( fb, 1, 0.49 );
    fb = AllpassC.ar( fb, 1, 0.5, (mod * 100 + 0.1).lag2(1) );
    fb = LPF.ar( fb, (700 + (mod*2000)).lag2(0.2).poll, mul:SinOsc.ar(1/8).range(-25, -35).dbamp);
	sig = HPF2Casc.ar(sig, 87.307, 10);
    sig = sig + GVerb.ar(
        in:LPF.ar(sig, 60, 0.5) + (bg * -10.dbamp),
        roomsize:1, revtime:1.2, damping:1, inputbw:1 - (mod*10), spread: 0, drylevel:1, mul:-12.dbamp
    );
	// sig = SoftClipAmp8.ar(sig, 4);
    sig = (sig + fb) * 0.125;
    sig = Compander.ar( sig, sig, 0.6, 1/3, 1/40, 0.17, 0.05 );
	sig = LeakDC.ar(sig);
    sig = Limiter.ar(sig);
    LocalOut.ar(sig);
    sig = Mix.ar(sig) * \amp.kr(0.2);
    // SplayAz.ar(4, sig, spread: spread) * amp;
	// Pan4.ar(sig, LFTri.kr(0.5, 0), LFTri.kr(0.1, 0) ) * \amp.kr(0.35);
    // Pan4.ar(sig, LFTri.kr(0.1, 0), 0/*LFTri.kr(0.15, 0)*/ ) * \amp.kr(0.2);
	// Pan4.ar(sig, \xpos.kr(0), \ypos.kr(0) ) * \amp.kr(0.2);

});
);
Ndef(\t_resp2).ar(4, 8);
(
Ndef(\t_resp2,{
    var trig = Trig1.kr(HPZ1.kr( \threshold.kr(0.1) >=  ~pulse2.kr ));
    var mod = (~resp2.kr + 0.022).clip(0.01,1);
    var peak = RunningMax.kr(mod, Impulse.kr(0.1) );  // << AQUI!
    var min = RunningMin.kr(mod, Impulse.kr(0.1) );  // << AQUI!
	var freqs = [
		mod.linexp(0.01, peak, 6.875, 16.352) * 0.5,
		mod.linexp(0.01, peak, 8.176, 12.25) * 0.5 ,
		mod.linexp(0.01, peak, 5.15, 12.25) * 0.5 ,
		mod.linexp(0.01, peak, 4.589, 10.301) * 0.5

	];
	var lfreq = 392/*mod.linexp(min, peak, 392, 698.45).lag3ud(0.4)*/;
    var fb = LocalIn.ar(4);
	var wnoise = {WhiteNoise.ar(0.2, 0.4)};
    var sig = LFSaw.ar( freqs ) * wnoise;  // CHOOSE FREQ AT BUILD
	// sig = Mix(sig);
	// (mod*1000).poll;
	fb = DelayC.ar( fb, 2, /*0.49*/ (mod * 10).lag2 );  // << AQUI 0.49
	fb = AllpassC.ar( fb, 2, (mod* 10).lag2(0.2)/*0.5*/, mod * 10 + 1 );  // << AQUI!
	fb = LPF.ar( fb, lfreq, mod.linexp(0, peak, -25, -35).dbamp);  // CHOOSE FREQ AT BUILD
	fb = Mix(fb);
	// trig = DelayC.ar(trig, 1, 0.125);
	sig = HPF.ar(sig, mod.linexp(0, peak.lag2, 8372, 6272));
	sig = sig * Env([0, 1, 0], [mod*100, 0.0001], 4).ar(gate:trig);
	sig = sig * -40.dbamp;
	sig = sig + FreeVerb.ar(
		LPF2Casc.ar( sig, mod.linexp(0, peak.lag2(0.2), 58.27, 82.407), 10),
		mix: 0.5, room: 1, damp: mod.linlin(0, peak, 0, 1).lag(0.5), mul:-10.dbamp
	);
    /*sig = sig + GVerb.ar(
        LPF2Casc.ar( sig, mod.linexp(0, peak.lag2(0.2), 58.27, 77.782), 10),
        1, 1, 0.5/*1 - (mod*10).lag3ud(0.5)*/, mod.linlin(0, peak, 0, 1).lag(0.5), spread:0, mul:-10.dbamp
	);*/
	sig = BLowPass4.ar( sig, mod.linexp(0, peak.lag, 5587.652, 14917.24).lag3ud, 0.5);
    sig = ( sig + fb ) * 0.5;
    sig = Compander.ar( sig, sig, 0.5, 1/2.5, 1/50, 0.17, 0.1 );
	sig = Limiter.ar(sig);
    sig = LeakDC.ar(sig);
    LocalOut.ar(sig);
	(sig)
	// [ sig[0] + sig[1], sig[2] + sig[3] ]
	// Balance2.ar(sig[0] + sig[1], sig[2] + sig[3]) * \amp.kr(0.2);
	// Pan4.ar(sig, LFTri.kr(0.5, 0), LFTri.kr(0.1, 0) ) * \amp.kr(0.2);

});
);
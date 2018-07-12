(
Ndef(\dark1,{ | dist = 0.5 |
    var trig = HPZ1.kr( \threshold.kr(0.15) >=  ~pulse1.kr );
    var freq = ZeroCrossing.kr(~pulse1.kr).lag(1);
    var frecip = ( freq + 0.001 ).reciprocal.clip(0,1);
    var fb = LocalIn.ar(1).lag2(0.01);
    var sig = Formant.ar(
        Decay2.ar( K2A.ar(trig), 0.001, freq * 0.25 ).exprange( 34.93, 39.20 ),
        Decay2.ar( K2A.ar(trig), 0.001, freq * 0.25 ).exprange( 49.39, 55.44 ),
        Decay2.ar( K2A.ar(trig), 0.001, freq * 0.25 ).exprange( 39.20, 46.62 )
    ) * Env.perc(0.001, frecip).kr(gate: trig);
	var k = 2 * dist / (1 - dist).clip(0.1, 0.9);
    var hh = HPF.ar( WhiteNoise.ar(0.1), 6000 ) * Env.perc( 0.001, frecip * 0.75 ).ar(gate:trig);
	fb = DelayC.ar( fb, 1, frecip.lag3(4) );
	fb = AllpassC.ar( fb, 1, frecip.lag3(4), freq.lag3(4) * 2 );
	fb = HPF.ar( fb, 65.4, 3 ) * SinOsc.ar( frecip.lag2(0.2) ).range(-35, -25).dbamp;
    sig = HPF2Casc.ar(sig, 65.4, 10);
	// hh = DelayC.ar(hh, 1, frecip);
    sig = ( hh + sig + (fb * 0.25)) * 0.25;
	sig = Limiter.ar(sig);
	sig = (1 + k) * sig / (1 + (k * sig.abs));
	sig = Compander.ar( sig, sig, 0.5, 0.6, 1/40, 0.17, 0.05 );
	// sig = LeakDC.ar(sig);
    LocalOut.ar(sig);
    sig * \amp.kr(0.3);
});
);
(
Ndef(\dark2,{
    var trig = HPZ1.kr( \threshold.kr(0.1) >=  ~pulse2.kr );
    var freq = ZeroCrossing.kr(~pulse2.kr).lag(1);
    var frecip = (freq+0.001).reciprocal.clip(0.001,1);
    var fb = LocalIn.ar(1);
    var sig = Formant.ar(
        Decay2.ar( K2A.ar(trig), 0.001, freq*0.5).exprange(38.891, 39.20),
        Decay2.ar( K2A.ar(trig), 0.001, freq*0.5).exprange(46.62, 52 ),
        Decay2.ar( K2A.ar(trig), 0.001, freq*0.5).exprange(55.44, 43.654)
    ) * Env.perc(0.001, frecip).kr(gate: trig);
    var hh = HPF.ar(WhiteNoise.ar(0.2), 11175.303) * Env.perc(0.001, frecip*0.25).ar(gate:trig);
    sig = HPF2Casc.ar(sig, 65.4, 10);
    fb = DelayC.ar( fb, 1, frecip.lag3(4));
    fb = AllpassC.ar( fb, frecip.lag3(4), freq.lag3(4) * 2);
    fb = LPF.ar( fb, 1046.5, mul:SinOsc.ar(1/7).range(-25, -35).dbamp);
    // hh = DelayC.ar(hh, 1, frecip*2);
    sig = (hh + sig + fb) * 0.25;
    sig = Compander.ar( sig, sig, 0.5, 0.7, 1/40, 0.17, 0.05 );
	sig = Limiter.ar(sig);
    LocalOut.ar(sig);
	sig * \amp.kr(0.8);
});
);
(
Ndef(\dark3,{
    var trig = HPZ1.kr( \threshold.kr(0.1) >=  ~pulse3.kr );
    var freq = ZeroCrossing.kr(~pulse3.kr.lag(0.2)).lag(1);
    var frecip = (freq+0.001).reciprocal.clip(0.001,1);
    var fb = LocalIn.ar(1);
    var sig = Formant.ar(
        Decay2.ar(K2A.ar(trig), 0.001, freq*0.125).exprange(34.93, 39.20),
        Decay2.ar(K2A.ar(trig), 0.001, freq*0.125).exprange(49.39, 55.44),
        Decay2.ar(K2A.ar(trig), 0.001, freq*0.125).exprange(49.39, 39.20)
    ) * Env.perc( 0.001, frecip * 0.75z ).kr(gate: trig);
    var hh = HPF2Casc.ar(WhiteNoise.ar(0.1), 8372, 10) * Env.perc(0.001, frecip*0.5).ar(gate:trig);
    fb = DelayC.ar( fb, 1, 0.49);
    fb = AllpassC.ar( fb, 1, 0.5, 10);
    fb = LPF.ar( fb, 880, mul:SinOsc.ar(1/8).range(-25, -35).dbamp);
    sig = HPF2Casc.ar(sig, 65.4, 10);
    // hh = DelayC.ar(hh, 1, frecip*0.75);
    sig = (hh + sig + fb) * 0.25;
    sig = Compander.ar( sig, sig, 0.5, 0.7, 1/40, 0.17, 0.05 );
    sig = Limiter.ar(sig);
    LocalOut.ar(sig);
    sig * \amp.kr(0.8);
});
);
(
Ndef(\dark4, {
    var trig = HPZ1.kr( \threshold.kr(0.1) >=  ~pulse4.kr );
    var freq = ZeroCrossing.kr(~pulse4.kr.lag(0.2)).lag(1);
    var frecip = (freq+0.001).reciprocal.clip(0.001,1);
    var fb = LocalIn.ar(1);
    var sig = Formant.ar(
        Decay2.ar(K2A.ar(trig), 0.001, freq*0.125).exprange(34.93, 39.20),
        Decay2.ar(K2A.ar(trig), 0.001, freq*0.125).exprange(43.65, 46.25),
        Decay2.ar(K2A.ar(trig), 0.001, freq*0.125).exprange(58.27, 43.65 )
    ) * Env.perc( 0.001, freq * 0.25 ).kr(gate: trig);
    var hh = HPF2Casc.ar(WhiteNoise.ar(0.05), [5587.652, 7458.62], 2) * Env.perc(0.001, frecip*0.75).ar(gate:trig);
    fb = DelayC.ar( fb, 1, 0.49);
    fb = AllpassC.ar( fb, 1, 0.5, 10);
    fb = LPF.ar( fb, 1760, mul:SinOsc.ar(1/8).range(-25, -35).dbamp);
    sig = HPF2Casc.ar( sig, 65.4, 10 );
	sig = (hh + sig + fb) * 0.25;
    sig = Compander.ar( sig, sig, 0.5, 0.8, 1/40, 0.17, 0.05 );
    sig = Limiter.ar(sig);
    LocalOut.ar(sig);
    Mix(sig) * \amp.kr(0.8);
});
);
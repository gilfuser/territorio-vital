(
Ndef(\say1,{
	var freq = \freq.kr( 58.3, \slide.kr(0.2) );
    var fdev = { LFNoise2.kr(0.01, 0.1, 1) };
    var vow = Vowel(\o, \bass) * ( \dist.kr(0.05) + LFCub.kr(0.001, 0, 0.02, 0.025) ).lag(0.2);
    var lfmod = { LFNoise2.ar( XLine.kr(1, 6, 1.5), XLine.kr( 0.001, 1, 0.66, 4), 0.501 ) };
    var form = Formants.ar(	[ freq * fdev.reciprocal, freq * fdev ] + lfmod!2, vow,	ampMods: 0.25 );
	var bal = Balance2.ar( form[0][0], form[1][1] );
	var sig = Fold.ar( bal, ( -1 * LFCub.kr(0.01, 0).range(0.1, 2) ), \fold.kr(1) );

	var trig = Trig1.kr( HPZ1.kr( \threshold.kr(0.15) >= ~pulse1.kr ) );
    var tfreq = ZeroCrossing.kr( ~pulse1.kr.lag(0.2) ).lag(1);
    var frecip = ( tfreq + 0.001 ).reciprocal.clip(0.001, 1);
    var relT = LFCub.kr( 0.0013, 1.5pi, frecip, frecip ); // sinusoidal slowly change env release time
    var textr = LFSaw.ar( [900, 820] ).sum * WhiteNoise.ar(1, 0.6);
    var textrT = DelayN.kr( trig, 1, frecip * 0.33 );
    var fb = LocalIn.ar(2).sum;
	var env = Env.perc( 0.001, relT ).ar(gate: trig);
    sig = sig * env;
    fb = DelayC.ar( fb, 1, 0.49 );
    fb = AllpassC.ar( fb, 1, 0.5, 10 );
    fb = LPF.ar( fb, 800, mul:SinOsc.ar(1/8).range(-25, -35).dbamp );
    textr = HPF.ar( textr, LFNoise2.kr(0.05).exprange( 5588, 11175 ) );
    textr = textr * Env( [0, 1, 0], [36/8, 0.0001], 4 ).ar( gate:textrT );
    textr = textr * -40.dbamp;
    textr = Compander.ar( textr, sig, 0.25, 1/1.25, 1/50, 0.01, 0.17 );
    textr = BBandPass.ar( textr, LFNoise2.kr(0.05).exprange(494, 5920), 0.25.lag(0.2) );
    sig = sig + (textr * 0.25);
    LocalOut.ar(sig);
    Mix(sig) * \amp.kr(0.2);
});
);

(
Ndef(\say2,{
	var freq = \freq.kr( 77.8, \slide.kr(0.1) );
    var lfmod = { LFNoise2.ar( XLine.kr( 1, 7, 1.5 ), XLine.kr( 0.001, 1, 0.66, 4), 0.501 )};
    var fdev = { LFNoise2.kr( 0.1, 0.01, 1 ) };
    var vow = Vowel(\e, \tenor) * \dist.kr(0.1);
    var form = Formants.ar(	[ freq * fdev.reciprocal, freq * fdev ] + lfmod!2, vow,	ampMods: 0.25 );
	var bal = Balance2.ar( form[0][0], form[1][1] );
    var sig = Fold.ar( bal, (-1 * LFCub.kr(0.01, 0.5pi).range(0.1, 2)), \fold.kr(2) );

    var trig = HPZ1.kr( \threshold.kr(0.15) >=  ~pulse2.kr );
    var tfreq = ZeroCrossing.kr( ~pulse2.kr.lag(0.2) ).lag(1);
    var frecip = ( tfreq + 0.0001 ).reciprocal.clip(0,1);
    var relT = LFCub.kr( 0.0013, 1.5pi, frecip, frecip );
    var textrT = DelayN.kr( PulseDivider.kr(trig, 2, 0.25), 1, frecip * 0.25 );
    var textr = LFSaw.ar( [880, 698.5] ).sum * WhiteNoise.ar(1, frecip);
    var fb = LocalIn.ar(2).sum;
	var env = Env.perc( 0.001, relT ).ar(gate: trig);
    sig = sig * env;
    fb = DelayC.ar(fb, 1, 0.3675);
    fb = AllpassC.ar(fb, 1, 0.5, 7.5);
    fb = LPF.ar( fb, 800, mul:SinOsc.ar(1/8).range(-25, -35).dbamp );
    textr = HPF.ar( textr, LFNoise2.kr(0.07).exprange(7459, 14917) );
    textr = textr * Env( [0, 1, 0], [tfreq * 3, 0.0001], 4 ).ar(gate:textrT);
    textr = textr * -40.dbamp;
    textr = Compander.ar( textr, sig, 0.25, 1/1.25, 1/50, 0.01, 0.17 );
    textr = BBandPass.ar( textr, LFNoise2.kr(0.05).exprange(2794, 5588), 0.25.lag(0.2) );
    sig = sig + (textr * 0.25);
    LocalOut.ar(sig);
    Mix(sig) * \amp.kr(0.2);
});
);

(
Ndef(\say3,{
	var freq = \freq.kr( 103.8, \slide.kr(0.1) );
    var lfmod = { LFNoise2.ar( XLine.kr(1, 6, 1.5), XLine.kr( 0.001, 1, 0.66, 4), 0.501 ) };
    var fdev = { LFNoise2.kr(0.1, 0.01, 1) };
    var vow = Vowel(\i, \counterTenor) * \dist.kr(0.12);
    var form = Formants.ar( [ freq * fdev.reciprocal, freq * fdev ] + lfmod!2, vow, ampMods: 0.25 );
    var bal = Balance2.ar( form[0][0], form[1][1] );
    var sig = Fold.ar( bal, (-1 * LFCub.kr(0.01, pi).range(0.1, 2)), \fold.kr(1) );

    var trig = HPZ1.kr( \threshold.kr(0.15) >=  ~pulse3.kr );
    var tfreq = ZeroCrossing.kr(~pulse3.kr.lag(0.2)).lag(1);
    var frecip = ( tfreq + 0.0001 ).reciprocal.clip(0.0001, 1);
    var fb = LocalIn.ar(2).sum;
    var relT = LFCub.kr( 0.0013, 1.5pi, frecip, frecip * 0.8 );
	var env = Env.perc( 0.001, relT ).ar(gate: trig);
    var textrT = DelayN.kr( PulseDivider.kr(trig, 3, 0.5), 1, frecip * 0.2 );
    var textr = LFSaw.ar( [698.5, 523.2]).sum * WhiteNoise.ar(1, frecip);
    fb = DelayC.ar(fb, 1, 0.275625 );
    fb = AllpassC.ar(fb, 1, frecip, freq * 4);
    fb = LPF.ar(fb, 800, mul:SinOsc.ar(frecip).range(-25, -35).dbamp);
    sig = sig * env;
    textr = HPF.ar( textr, LFNoise2.kr(0.07).exprange(5587.5, 11175) );
    textr = textr * Env( [0, 1, 0], [freq*3, 0.0001], 4 ).ar(gate:textrT);
    textr = textr * -40.dbamp;
    textr = Compander.ar( textr, sig, 0.25, 1/1.25, 1/50, 0.01, 0.17 );
    textr = BBandPass.ar(textr, LFNoise2.kr(0.06).exprange(2793.826, 3729.31), 0.25.lag(0.2));
    sig = sig + (textr * 0.25);
    LocalOut.ar(sig);
	Mix(sig) * \amp.kr(0.2);
});
);

(
Ndef(\say4,{ | amp = 0.2 threshold = 0.15 |
	var freq = \freq.kr(138.6);
    var lfmod = { LFNoise2.ar( XLine.kr(1, 6, 1.5), XLine.kr( 0.001, 1, 0.66, 4), 0.501 ) };
    var fdev = {LFNoise2.kr(0.1, 0.01, 1)};
    var vow = Vowel(\u, \soprano) * \dist.kr(0.15);
    var form = Formants.ar( [ freq * fdev.reciprocal, freq * fdev ] + lfmod!2, vow, ampMods: 0.25 );
    var bal = Balance2.ar(form[0][0], form[1][1] );
    var sig = Fold.ar( bal, (-1 * LFCub.kr(0.01, 1.5pi).range(0.1, 2)), \fold.kr(1)  );

	var trig = HPZ1.kr( threshold >=  ~pulse4.kr );
    var tfreq = ZeroCrossing.kr( ~pulse4.kr.lag(0.2) ).lag(1);
    var frecip = ( tfreq + 0.0001 ).reciprocal.clip(0.0001, 1);
    var relT = LFCub.kr( 0.0013, 1.5pi, frecip, frecip * 0.5 );
	var env = Env.perc( 0.001, relT ).ar(gate: trig);
    var fb = LocalIn.ar(2).sum;
    var textr = LFSaw.ar([698.456, 523.251]).sum * WhiteNoise.ar(1, frecip);
    var textrT = DelayN.kr( PulseDivider.kr( trig, 5, 0.75), 1, frecip * 0.2 );
    fb = DelayC.ar(fb, 1, 0.20671875 );
    fb = AllpassC.ar( fb, 1, frecip, freq * 4 );
    fb = LPF.ar( fb, 800, mul:SinOsc.ar(frecip).range(-25, -35).dbamp );
    sig = sig * env;
    textr = HPF.ar(textr, LFNoise2.kr(0.07).exprange(3729.31, 7458.62));
    textr = textr * Env([0, 1, 0], [freq*2, 0.0001], 4).ar(gate:textrT);
    textr = textr * -40.dbamp;
    textr = Compander.ar( textr, sig, 0.25, 1/1.25, 1/50, 0.01, 0.17 );
    textr = BBandPass.ar(textr, LFNoise2.kr(0.06).exprange(3729.31, 2793.826), 0.25.lag(0.2));
    sig = sig + (textr * 0.25);
    LocalOut.ar(sig);
	Limiter.ar( Mix(sig), 0.9) * \amp.kr(0.2);
});
);
"pulses_say - LOADED".postString;
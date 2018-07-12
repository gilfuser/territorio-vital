q=q ? ();
q.fx = q.fx ? ();
q.views = q.views ? ();
// for pitch
(
Pdefn(\scaleA, Scale.choose(7, 12).tuning_(Tuning.choose(12)));
Pdefn(\scaleA).source.name;
);

(
q.fx.fxLib = IdentityDictionary [

	'00_in' -> { arg in, level=0.85, llag=0.2;
		LeakDC.ar( in * level.lag(llag) )
		+ (BrownNoise.ar(0.000001) ! 2/*q.numChans*/);
	},

	/*'soundIn' -> { | in, inAmp = 1|
		var sndIn = SoundIn.ar(0, inAmp ) /*+ in*/;
		sndIn
	},*/

	'pitch' -> { | in degree=0  pitchDisp = 0, timeDisp = 0.5, slide = 0.4 |
		var wSize, tDisp, pRatio;
		var scale = {Pdefn(\scaleA).source}.value;
		var pitchRatio = Select.kr(degree+14, [ scale.degreeToRatio(-14, 0).lag(slide), scale.degreeToRatio(-13, 0).lag(slide), scale.degreeToRatio(-12, 0).lag(slide), scale.degreeToRatio(-11, 0).lag(slide), scale.degreeToRatio(-10, 0).lag(slide), scale.degreeToRatio(-9, 0).lag(slide), scale.degreeToRatio(-8, 0).lag(slide), scale.degreeToRatio(-7, 0).lag(slide), scale.degreeToRatio(-6, 0).lag(slide), scale.degreeToRatio(-5, 0).lag(slide), scale.degreeToRatio(-4, 0).lag(slide), scale.degreeToRatio(-3, 0).lag(slide), scale.degreeToRatio(-2, 0).lag(slide), scale.degreeToRatio(-1, 0).lag(slide), scale.degreeToRatio(0, 0).lag(slide), scale.degreeToRatio(1, 0).lag(slide), scale.degreeToRatio(2, 0).lag(slide), scale.degreeToRatio(3, 0).lag(slide), scale.degreeToRatio(4, 0).lag(slide), scale.degreeToRatio(5, 0).lag(slide), scale.degreeToRatio(6, 0).lag(slide), scale.degreeToRatio(7, 0).lag(slide), scale.degreeToRatio(8, 0).lag(slide), scale.degreeToRatio(9, 0).lag(slide), scale.degreeToRatio(10, 0).lag(slide), scale.degreeToRatio(11, 0).lag(slide), scale.degreeToRatio(12, 0).lag(slide), scale.degreeToRatio(13, 0).lag(slide), scale.degreeToRatio(14, 0).lag(slide)
			]);
		wSize =  0.15;
		tDisp = LFDNoise3.ar( 0.0626).range(0, wSize) * timeDisp;
		PitchShift.ar( in, wSize, pitchRatio, pitchDisp, tDisp );
	},

	// von Liebesbrunnen 2. requires Feedback Quark. Maybe simplify this?
	'ridm' -> { | in, up=500, dn=500, aTresh = 0.15, aDecay = 0.2, amp= 1/*, divisor=6, dividendo=2*/ |
		var sig, sig1, sig2, monosig, ampl, trig, paNoise, paNoise2, freqNoise, pan, duck, fbNode1, fbNode2;
		var dividendo = (3..9).choose;
		var divisor = (4..11).choose;
		var div = (dividendo / divisor);
		in = Slew.ar( in, up, dn );
		fbNode1 = FbNode( 1, div, 4 );
		fbNode2 =  FbNode( 1, 1 + 0.02, 4 );
		ampl = Amplitude.kr( Mix(in), attackTime: 0.002, releaseTime: aDecay );
		trig = HPZ1.kr( ampl >= aTresh );
		paNoise = dividendo * 3;
		paNoise2= dividendo * 700;
		paNoise = LFNoise2.kr( 1/paNoise, LFNoise2.kr(paNoise), LFNoise2.kr(paNoise) ).linlin( -1 * paNoise, paNoise, 0, 1 );
		freqNoise = LFNoise2.ar( paNoise, paNoise * 10, paNoise2 ).lag(1).clip(1000, 20000);
		//	SendTrig.kr(trig, 0, freqNoise);
		sig1 = fbNode1.delay * EnvGen.kr( Env.perc(0, divisor * 3, 1), trig );
		sig2 = fbNode2.delay * EnvGen.kr( Env.perc(0, dividendo * 3, 1), trig );
		sig1 = ( sig1 * 0.45 ) + LPF.ar( ( sig1 * 0.55), freqNoise ) + in[0];
		sig2 = ( sig2 * 0.45 ) + LPF.ar( ( sig2 * 0.55), freqNoise ) + in[0];
		fbNode1.write(sig1).lag2(0.1);
		fbNode2.write(sig2).lag2(0.1);
		pan = paNoise - 0.5;
		sig = Balance2.ar( sig1, sig2, pan );
		sig = sig - Ndef(\orb2) * -3.dbamp;
		sig *amp;
	},

	'lStrobe' -> { |in tempo=1 t_trig=1 strobe=1 lsphase=1 onTime=1 offTime=1 lscurve |
		// var shape = ['hold', 'step', 'lin', 'exp', 'sin', 'wel', 'cub'];
		var env = Select.kr(lscurve, [
			Env([ 0,1,0.001,0.001,1 ], [ 0,onTime,lsphase,offTime ].normalizeSum, \hold, releaseNode:1 ).kr(
			gate:t_trig, timeScale: strobe*(tempo.reciprocal) ),
				Env([ 0,1,0.001,0.001,1 ], [ 0,onTime,lsphase,offTime ].normalizeSum, \step, releaseNode:1 ).kr(
			gate:t_trig, timeScale: strobe*(tempo.reciprocal) ),
				Env([ 0,1,0.001,0.001,1 ], [ 0,onTime,lsphase,offTime ].normalizeSum, \lin, releaseNode:1 ).kr(
			gate:t_trig, timeScale: strobe*(tempo.reciprocal) ),
				Env([ 0,1,0.001,0.001,1 ], [ 0,onTime,lsphase,offTime ].normalizeSum, \exp, releaseNode:1 ).kr(
			gate:t_trig, timeScale: strobe*(tempo.reciprocal) ),
				Env([ 0,1,0.001,0.001,1 ], [ 0,onTime,lsphase,offTime ].normalizeSum, \wel, releaseNode:1 ).kr(
			gate:t_trig, timeScale: strobe*(tempo.reciprocal) ),
				Env([ 0,1,0.001,0.001,1 ], [ 0,onTime,lsphase,offTime ].normalizeSum, \cub, releaseNode:1 ).kr(
			gate:t_trig, timeScale: strobe*(tempo.reciprocal) )
		] );
		in * env;
	},

	'lTape' -> { |in tempo=1 dur=1  iphase=1.5 depth = 1 toffset = 1 |
		var curve = SinOsc.kr(tempo * dur.reciprocal, ( dur * iphase * 2pi + 1.5pi) % 2pi, depth, toffset );
		DelayL.ar(in, 2, curve);
	},

	'lFakeDuck' -> { | in dur=1 tempo=1 iphase=0 dwidth=0.5 dcurve=0 |
	var duck = VarSaw.ar( tempo * ( dur.reciprocal), iphase % 1, dwidth, 0.5, 0.5 ).lag2(0.02);
	in * duck.lincurve(/*inMax:0.5, */curve:dcurve)
	},

	'lLFO' -> { | in dur=1 tempo=1 iphase=0 lwidth=0.5 sinSawPul=0, midfreq=60, hifreq=13000 |
	var mod = Select.ar(sinSawPul, [
		SinOsc.ar( tempo * dur.reciprocal, ( dur * iphase * 2pi + 1.5pi) % 2pi),
		VarSaw.ar( tempo * dur.reciprocal, iphase % 1, lwidth ),
		LFPulse.ar(tempo * dur.reciprocal, (dur * iphase) % 1, lwidth.clip(0.02, 0.998) )*2-1,
	]);
	BLowPass.ar(in, mod.lag2(0.05).exprange(midfreq.lag(0.2), hifreq.lag(0.2)));
	},

	'ring_mod' -> { | in, rfreq= 300 | // from alles an alle
		SinOsc.ar(rfreq.lag(0.2)  * [1, 0.91], 0, in);
	},

	'filter' -> { | in, lbhnp = 0, sfreq = 10000, res= 0.5 |
		var lpf = Select.kr(lbhnp,
			[DC.kr(1), DC.kr(0), DC.kr(0), DC.kr(0), DC.kr(0) ]
		);
		var bpf = Select.kr(lbhnp,
			[DC.kr(0), DC.kr(1), DC.kr(0), DC.kr(0), DC.kr(0) ]
		);
		var hpf = Select.kr(lbhnp,
			[DC.kr(0), DC.kr(0), DC.kr(1), DC.kr(0), DC.kr(0) ]
		);
		var notch = Select.kr(lbhnp,
			[DC.kr(0), DC.kr(0), DC.kr(0), DC.kr(1), DC.kr(0) ]
		);
		var peak = Select.kr(lbhnp,
			[DC.kr(0), DC.kr(0), DC.kr(0), DC.kr(0), DC.kr(1) ]
		);
		SVF.ar( in, sfreq.lag(0.2), res.lag(0.4), lpf, bpf, hpf, notch, peak );
	},

	'droptape' -> { |in, tfb = 0, modspeed = 4, depth = 1, dtoffset = 1 |
		var curv = SinOsc.kr(modspeed.reciprocal, tfb * 2pi, depth, dtoffset );
		DelayL.ar(in, 2, curv);
	},

	/*'brf' -> { | in, bfreq = 10000, brq= 1 |
		BRF.ar(in, bfreq.lag(0.2), brq.lag(0.4) );
	},

	'hpf' -> { | in, hfreq = 22 |
		HPF.ar(in * (hfreq / 500).sqrt, hfreq);
	},*/

	'hpfCas' -> { | in, hfreqCa = 22 |
		HPF2Casc.ar(in, hfreqCa, 10);
	},

	'lpf' -> { | in, lfreq = 10000, rql=0.8 |
		BLowPass.ar(in, lfreq, rql);
	},

	'reverb' -> { | in |  // the cheapest reverb I can get
		var sig, del, ampR;
		sig = Splay.ar(in, 2/*(sig*0.25)+In.ar(in2, 4)*/);  // some rhythm X texture can be done here
		del = LocalIn.ar(2)+in;
		del = Splay.ar(del.reverse*0.3);
		4.do {	del = AllpassC.ar(del, 12, {ExpRand(0.2, 6.0)}, {ExpRand(3, 24)})};
		ampR = Amplitude.kr(in);
		del = Compander.ar(del, del, 0.3, 1, 1/4, 0.002, 0.6, 2);
		LocalOut.ar(del * LFNoise2.ar(0.0107, 0.2, 1).lag2(0.3));
		Median.ar(11, del);
	},

	'strobe' -> { | in, lofreq=4, width=0.5 | // from alles an alle
		in * LFPulse.kr(lofreq, 0, width);
	},

	'wah' -> { |in, rate = 2, depth = 0.5, ring=0.003, wrq = 0.8, ggain = 1| // from alles an alle
		var mod = VarSaw.kr(rate, 0, 0.1, depth).lag(0.1).exprange(100, 5000);
		var ringz = Ringz.ar( in, mod, ring
		);
		var sig = RLPF.ar(ringz, mod, wrq.lag(0.1)) * ggain.tanh.lag(0.0003) / ggain.sqrt;
		Limiter.ar(sig, 0.9);
	},

	/*'krush' -> { | in, /*bits = 8, */downsamp = 16 | // from alles an alle
		var down = Latch.ar(in, Impulse.ar(SampleRate.ir / downsamp.max(2)));
		down;
	},*/
	'comp' ->{ | in, cThresh=0.2, /*slopeB=1, */slopeA=0.5, clampT=0.002, relaxT=0.1, cAmp=2.0 |
		Compander.ar( in, in, cThresh, 1, slopeA, clampT, relaxT, cAmp );
	},

	'par_EQ' -> { arg in, pFreq=40.0, pRq=0.5, pDb=6.0;
		MidEQ.ar(in, pFreq.lag(1), pRq.lag(1), pDb.dbamp);
	},
	/*'adcVerb' -> { | in, revTime = 3, drift = 0.5, rrate = 0.5, wet = 0.15 | // from alles an alle
		var rev = AdCVerb.ar(LeakDC.ar(in) * wet,
			revTime,
			combScale: LFDNoise3.kr(rrate, drift.clip2(0.9), 1) );
		rev;
	},
	'adcVerb2' -> { | in, revTime = 3, animRate = 0.1, animDepth = 0.03, hfDamping = 0.1, mod=0.05, predelay = 0.02, inFilter = 0.6, leakCoeff = 0.995, combScale = 1, apScale = 1 |
		AdCVerb2.ar( in, revTime,animRate, animDepth, LFNoise1.kr(0.2!2,0.1*mod, 0.1*mod), 2, predelay,
			8, 4, 0.6, 0.995, combScale, apScale );
	},
	'lpf_noise' -> { | in, lnfreq = 10000, rqn=0.8 |
		BLowPass.ar(in, LFNoise2.kr( 1, lnfreq * 0.1, lnfreq * 0.1 + 0.01), rqn);
	},*/
	'hole' -> {  | in, dtime = 0.1, damp = 0.1, size = 1, diff = 0.707, fb = 0.1 |
		Greyhole.ar( in, dtime, damp, size.lag(0.2), diff, fb );
	},
	'delay' -> { arg in, delayTime1 = 0.4, delayTime2 = 0.45, mod=0, rise=1, fall=5;
		var dtKr, comb, modulator, dtActual;
		modulator = ( 1 - LFDNoise3.kr(mod.sqrt ! q.numChans * 4, 0.8 * mod).cubed );
		dtKr = [delayTime1, delayTime2 ].lag(1.0);
		dtActual = dtKr * modulator;
		comb = CombL.ar( in, 5.75, dtActual, dtKr * fall, 1 ) - CombL.ar( in, 5.75, dtActual, dtKr * rise, 1 );
	},
	'dualcomp'-> { | in, xfreq = 300, lflim = 0.7, hflim = 0.3, lfgain = 1.0, hfgain = 1.0 |
		DualBandComp.ar(in, xfreq, lflim, hflim, lfgain, hfgain);
	},
	'rollClip'-> { |in, clip=0.99, pole=0.2|
		OnePole.ar(in.clip2(clip), pole ** 0.7);
	},
	'ampFin' -> { |in, limDrive = 1.25, ampLimit = 0.95, postAmp = 1 |
		Limiter.ar(in * limDrive, ampLimit) * postAmp;
	},
	'leakDC' -> { | in, leak=0.99 |
		LeakDC.ar(in, leak);
	},
	/*'pan' -> { arg in, center= 0;
		Splay.ar( in, center: center);
	},*/
	'endFilt' -> { | in, highPass=40, lowPass=15000 |
        var l, h;
		l = HPF2Casc.ar( in, highPass);
		h = LPF2Casc.ar( in, lowPass);
		h-l;
	},
	/*'stereoSum' -> { | in |
        Balance2.ar(Mix([in[0], in[1]]), [in[2], in[3]]);
	},*/
];
);

(

//hole
Spec.add(\damp, [0, 1]);
Spec.add(\dtime, [0, 2]);
Spec.add(\size, [0.5, 3]);
Spec.add(\diff, [0, 1]);
Spec.add(\fb, [0, 1]);

//ampFin
Spec.add( \limDrive, \ampx4 );
Spec.add( \ampLimit, \amp );
Spec.add( \postAmp, \ampx4 );

Spec.add( \wet10, [0.0, 1.0]);
Spec.add( \wet20, [0.0, 1.0]);
Spec.add( \wet30, [0.0, 1.0]);
Spec.add( \wet40, [0.0, 1.0]);
Spec.add( \wet50, [0.0, 1.0]);
Spec.add( \wet60, [0.0, 1.0]);
Spec.add( \wet70, [0.0, 1.0]);
Spec.add( \wet80, [0.0, 1.0]);
Spec.add( \wet90, [0.0, 1.0]);
Spec.add( \wet100, [0.0, 1.0]);
Spec.add( \wet110, [0.0, 1.0]);
Spec.add( \wet120, [0.0, 1.0]);

//sound in
Spec.add( \inAmp, \ampx4.asSpec);

//zRidm
Spec.add( \divisor, [ 4, 11, \lin, 1 ]);
Spec.add( \dividendo, [ 3, 9, \lin, 1 ]);
Spec.add( \up, [ 10, 1000 ]);
Spec.add( \dn, [ 10, 1000 ]);
Spec.add( \aTresh, [ 0.005, 0.75, \exp ]);
Spec.add( \aDecay, [ 0.03, 1 ]);

//pitch
//Spec.add(\slide, [0.02, 2]);
//pitch
Spec.add(\pnote, [-14, 14, \lin, 0.5]);
Spec.add(\pitchDisp, [0, 0.5]);
Spec.add(\timeDisp, [0, 1]);
Spec.add(\slide, [0.02, 2]);

//filter
Spec.add(\lbhnp, [0, 4, \lin, 1, 0]);
Spec.add(\sfreq, \freq);
Spec.add(\res, [0, 1]);

//drop tape
Spec.add(\modspeed, [0.5, 16]);
Spec.add(\tfb, [0, 0.17]);

Spec.add(\dgain, \ampx4.asSpec);
Spec.add(\sustain, [0.1, 4]);

//wah
Spec.add(\ring, [0.003, 3, \exp]);
Spec.add(\rate, [0.2, 20, \exp]);
Spec.add(\depth, [0, 1]);
Spec.add(\ggain, [0.01, 1, \amp]);
Spec.add(\wrq, [0.2, 2]);

//ring_mod
Spec.add(\rfreq, \freq);

//lStrobe
Spec.add(\strobe, [0.25, 12, 1, 0.25]);
Spec.add(\lscurve, [0, 6, 0, 1]);
Spec.add(\onTime, [0.16, 16]);
Spec.add(\offTime, [0.16, 16]);
Spec.add(\lsphase, [0.16, 16]);
//ltape
Spec.add(\toffset, [0, 1]);
Spec.add(\depth, [0.001,1, \exp]);
// lFakeDuck
Spec.add( \dcurve, [ -6, 6 ]);
Spec.add( \dwidth, [ 0, 1 ]);
// lLFO
Spec.add(\hifreq, [200, 20000, \exp, 0, 220, units: " Hz"]);
Spec.add( \lwidth, [ 0, 1 ]);
Spec.add(\sinSawPul, [0, 2, \lin, 1, 1]);

q.fx.fxLib.keysValuesDo({ |key,val|
	ProxyChain.add(key.asSymbol, \filterIn -> val);
});
/*
//pan
Spec.add( \center, [-1, 1] );
//hpf
Spec.add( \hfreq, \freq.asSpec );
//hpfCas
Spec.add( \hfreqCa, \freq.asSpec );
//lpf
Spec.add( \lfreq, [20, 2000, \exp] );
// lpf noise
Spec.add( \lnfreq, [20, 2000, \exp] );
Spec.add( \rqn, [0.2, 2] );
//brf
Spec.add( \bfreq, \freq.asSpec);
Spec.add( \brq, \rq.asSpec);

Spec.add(\modDepth, [0, 1]);
Spec.add(\modFreq, [0, 10]);
//delay
Spec.add(\mod, [0, 1]);
*/
//comp
Spec.add( \cThresh, [0.0, 1.0] );
Spec.add( \slopeA, [0.04, 4] );
Spec.add( \clampT, [0.0005, 1] );
Spec.add( \relaxT, [0.005, 1] );
Spec.add( \cAmp, \ampx4);
// dual comp
/*Spec.add( \xfreq, \freq );
Spec.add( \lflim, [0.1, 1] );
Spec.add( \hflim, [0.1, 1] );
Spec.add( \lfgain, [0.2, 2, \exp ] );
Spec.add( \hfgain, [0.2, 2, \exp ] );*/
//endFilt
Spec.add( \highPass, \freq.asSpec );
Spec.add( \lowPass, \freq.asSpec );
//parEQ
Spec.add( \pFreq, \freq.asSpec );
Spec.add( \pDb, [-60, 32, \lin, 0, 1] );
Spec.add( \pRq, \rq.asSpec );

Spec.add(\threshold, [0,1]);

/*
//rollclip
Spec.add( \clip, [0.1, 0.9] );
Spec.add( \pole, [0.1, 0.5] );
//leakDC
Spec.add( \leak, [0.5, 0.999, \exp] );
//1_krush
Spec.add( \downsamp, [2, 32, 32, 2] );
//adcVerb
Spec.add(\revTime, [0.01, 100, \exp]);
Spec.add(\animRate, [0.01, 10, \exp]);
Spec.add(\animDepth, \amp.asSpec);
Spec.add(\hfDamping, [0, 1]);
Spec.add(\predelay, [0.0, 0.2/*, \amp*/]);
Spec.add(\revTime, [0.01, 100, \exp]);
Spec.add(\inFilter, [-0.99, 0.99]);
Spec.add(\leakCoeff, [0.8, 1.0]);
Spec.add(\combScale, [0.1, 2, \exp]);
Spec.add(\apScale, [0.1, 2, \exp]);
//strobe
Spec.add(\lofreq, [0.25, 16]);
Spec.add(\width, [0.01, 0.99]);
// adcverb
Spec.add(\rrate, [0.2, 20, \exp]);
// droptape
Spec.add(\dtoffset, [0, 1]);
Spec.add(\modspeed, [0, 10]);
*/
);

/*'DUCK' -> { |in, ctrlFreq= 1000, ctrlRq = 0.5, thresh=0.1, /*slopLo=1, */slopHi=0.5, relaxT=0.2, postgain=1 |
var controlsig = Ndef(\orb4).ar;
var ctrlFilt = BPF.ar(controlsig, ctrlFreq.lag(0.4), ctrlRq.lag(0.4));
var ducked = Compander.ar( in, ctrlFilt, thresh/*.clip(-46.dbamp, 1)*/, /*slopLo*/1, slopHi, 0.004, relaxT )/* * postgain*/;
LeakDC.ar(ducked, mul: postgain );
},*/
"Effects Library - LOADED".postString;
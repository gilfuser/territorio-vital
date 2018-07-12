(
Ndef(\metalic1, {
	var trig = Trig1.kr( HPZ1.kr( \threshold.kr(0.15) >= ~pulse1.kr ) );
	var tfreq = ZeroCrossing.kr( ~pulse1.kr ).lag(1);
	var frecip = ( tfreq + 0.001 ).reciprocal.clip(0.001, 1);
	var drand = Drand( [ 116.5, 138.6, 174.6, 233 ],inf );
	var gli = Demand.kr( trig, 0, Drand( [96, 87.3, 87.3, 96, 87.3, 96], inf ) );
	var rot = Demand.kr( trig, 0, [drand, gli] );
	var env = Env( [ 0, 1, 0 ], [ 0.001, frecip ], [0,-4] ).ar( gate:trig );
	var frq = Mix(rot).lag(0.1);
	var aliasing = SampleRate.ir / 2 / 512;
	var delta  = s.sampleRate/( 2056 * 2 );
	var buf1 = Buffer.alloc( Server.local, delta, 1 );
	var inp1 = LPF.ar( LFTri.ar( frq, 1/( aliasing/frq ) ), aliasing );//anti aliasing filtering
	var inp2 = LFPulse.ar( frq, mul:2, add:-1 );
	var sig  = PlayBuf.ar( 1, buf1 );
	RecordBuf.ar( inp2 - inp1, buf1 );
	sig = sig * env;
	sig = BLowPass4.ar( sig, Lag3UD.kr( trig, 0.01, 1 ).exprange(43.6, 11175), LFNoise2.kr(0.12).range(0.25, 0.5) );
	sig = MoogVCF.ar( sig,
		SinOsc.kr( LFNoise2.kr(0.007).range(0.001,2.2) ).exprange(932, 1865/*,8372, 16744*/),
		0.66
	);
	sig = Compander.ar( sig, sig, 0.5, 1/1.5, 1/5, 0.1, 0.17 );
	sig = Limiter.ar(sig);
	sig * \amp.kr(1);
});
);
(
Ndef(\metalic2, {
	var trig = Trig1.kr( HPZ1.kr( \threshold.kr(0.15) >= ~pulse2.kr ) );
	var tfreq = ZeroCrossing.kr( ~pulse2.kr ).lag(1);
	var frecip = ( tfreq + 0.001 ).reciprocal.clip(0.001, 1);
	var drand = Drand( [ 116.5, 138.6, 174.6, 233 ],inf );
	var gli = Demand.kr( trig, 0, Drand( [96, 87.3, 87.3, 96, 87.3, 96], inf ) );
	var rot = Demand.kr( trig, 0, [drand, gli] );
	var env = Env( [ 0, 1, 0 ], [ 0.001, frecip ], [0,-4] ).ar( gate:trig );
	var frq = Mix(rot).lag(0.12);
	var aliasing = SampleRate.ir / 2 / 512;
	var delta  = s.sampleRate/( 2056 * 2 );
	var buf1 = Buffer.alloc( Server.local, delta, 1 );
	var inp1 = LPF.ar( LFTri.ar( frq, 1/( aliasing/frq ) ), aliasing );//anti aliasing filtering
	var inp2 = LFPulse.ar( frq, mul:2, add:-1 );
	var sig  = PlayBuf.ar( 1, buf1 );
	RecordBuf.ar( inp2 - inp1, buf1 );
	sig = sig * env;
	sig = BLowPass4.ar( sig, Lag3UD.kr( trig, 0.01, 1 ).exprange(43.6, 11175), LFNoise2.kr(0.12).range(0.25, 0.5) );
	sig = MoogVCF.ar( sig,
		SinOsc.kr( LFNoise2.kr(0.007).range(0.001,2.2) ).exprange(932, 1865/*,8372, 16744*/),
		0.66
	);
	sig = Compander.ar( sig, sig, 0.5, 1/1.5, 1/5, 0.1, 0.17 );
	sig = Limiter.ar(sig);
	sig * \amp.kr(1);
});
);
(
Ndef(\metalic3, {
	var trig = Trig1.kr( HPZ1.kr( \threshold.kr(0.15) >= ~pulse3.kr ) );
	var tfreq = ZeroCrossing.kr( ~pulse3.kr ).lag(1);
	var frecip = ( tfreq + 0.001 ).reciprocal.clip(0.001, 1);
	var drand = Drand( [ 116.5, 138.6, 174.6, 233 ],inf );
	var gli = Demand.kr( trig, 0, Drand( [96, 87.3, 87.3, 96, 87.3, 96], inf ) );
	var rot = Demand.kr( trig, 0, [drand, gli] );
	var env = Env( [ 0, 1, 0 ], [ 0.001, frecip ], [0,-4] ).ar( gate:trig );
	var frq = Mix(rot).lag(0.15);
	var aliasing = SampleRate.ir / 2 / 512;
	var delta  = s.sampleRate/( 2056 * 2 );
	var buf1 = Buffer.alloc( Server.local, delta, 1 );
	var inp1 = LPF.ar( LFTri.ar( frq, 1/( aliasing/frq ) ), aliasing );//anti aliasing filtering
	var inp2 = LFPulse.ar( frq, mul:2, add:-1 );
	var sig  = PlayBuf.ar( 1, buf1 );
	RecordBuf.ar( inp2 - inp1, buf1 );
	sig = sig * env;
	sig = BLowPass4.ar( sig, Lag3UD.kr( trig, 0.01, 1 ).exprange(43.6, 11175), LFNoise2.kr(0.12).range(0.25, 0.5) );
	sig = MoogVCF.ar( sig,
		SinOsc.kr( LFNoise2.kr(0.007).range(0.001,2.2) ).exprange(932, 1865/*,8372, 16744*/),
		0.66
	);
	sig = Compander.ar( sig, sig, 0.5, 1/1.5, 1/5, 0.1, 0.17 );
	sig = Limiter.ar(sig);
	sig * \amp.kr(1);
});
);
(
Ndef(\metalic4, {
	var trig = Trig1.kr( HPZ1.kr( \threshold.kr(0.15) >= ~pulse4.kr ) );
	var tfreq = ZeroCrossing.kr( ~pulse4.kr ).lag(1);
	var frecip = ( tfreq + 0.001 ).reciprocal.clip(0.001, 1);
	var drand = Drand( [ 116.5, 138.6, 174.6, 233 ],inf );
	var gli = Demand.kr( trig, 0, Drand( [96, 87.3, 87.3, 96, 87.3, 96], inf ) );
	var rot = Demand.kr( trig, 0, [drand, gli] );
	var env = Env( [ 0, 1, 0 ], [ 0.001, frecip ], [0,-4] ).ar( gate:trig );
	var frq = Mix(rot).lag(0.18);
	var aliasing = SampleRate.ir / 2 / 512;
	var delta  = s.sampleRate/( 2056 * 2 );
	var buf1 = Buffer.alloc( Server.local, delta, 1 );
	var inp1 = LPF.ar( LFTri.ar( frq, 1/( aliasing/frq ) ), aliasing );//anti aliasing filtering
	var inp2 = LFPulse.ar( frq, mul:2, add:-1 );
	var sig  = PlayBuf.ar( 1, buf1 );
	RecordBuf.ar( inp2 - inp1, buf1 );
	sig = sig * env;
	sig = BLowPass4.ar( sig, Lag3UD.kr( trig, 0.01, 1 ).exprange(43.6, 11175), LFNoise2.kr(0.12).range(0.25, 0.5) );
	sig = MoogVCF.ar( sig,
		SinOsc.kr( LFNoise2.kr(0.007).range(0.001,2.2) ).exprange(932, 1865/*,8372, 16744*/),
		0.66
	);
	sig = Compander.ar( sig, sig, 0.5, 1/1.5, 1/5, 0.1, 0.17 );
	sig = Limiter.ar(sig);
	sig * \amp.kr(1);
});
);
Spec.add(\threshold, [0,1]);

Ndef(\sayA, { | dist = 0.05, fold = 2, slide = 0.2, freq = 58.27, pan = 0, amp = 0.2 |
    var	lfmod, freqDev,	aaa, form, bal, ruin, sig, attackTrig, attack;

    lfmod = {LFNoise2.ar(XLine.kr(1, 6, 1.5), XLine.kr( 0.001, 1, 0.66, 4), 0.501 )};
    freqDev = {LFNoise2.kr(0.01, 0.1, 1)};
    aaa = Vowel(\o, \bass) * (dist + LFCub.kr(0.001, 0, 0.02, 0.025)).lag(0.2);
    form = Formants.ar( [
        freq.lag(slide) * freqDev.reciprocal, freq.lag(slide) * freqDev
    ] + lfmod!2, aaa, ampMods: 0.25 ) * amp;
    bal = Balance2.ar(form[0][0], form[1][1], pan);
    ruin = Fold.ar(bal, (-1 * fold - LFCub.kr(0.009)).lag(0.2), fold.lag(0.2));
    sig = ruin * AmpComp.kr(freq, 43.65);
});
// Ndef(\sayA).gui;
Ndef(\pulse1).ar(2);
Ndef(\pulse1).fadeTime = 4;
(
Ndef(\pulse1,{ | ampx4= 1, threshold = 0.15 |
    var sayA, sig, trig, freqNoise, releaseT, attack, attackTrig, fb, freq;
    var in = Ndef(\sayA).ar;
    trig = HPZ1.kr( threshold >=  ~pulse1.kr );
    freq = ZeroCrossing.kr(~pulse1.kr.lag(0.2)).lag(1);
    fb = LocalIn.ar(2).sum;
    fb = DelayC.ar(fb, 1, 0.49);
    fb = AllpassC.ar(fb, 1, 0.5, 10);
    fb = LPF.ar(fb, 800, mul:SinOsc.ar(1/8).range(-25, -35).dbamp);

    releaseT = LFCub.kr(0.0013, 1.5pi, freq.reciprocal, 0.6); // sinusoidal slowly change env release time
    sayA = in * EnvGen.kr( Env.perc( 0, releaseT), trig );

    attackTrig = DelayN.kr(/*attackTrig*/trig, 1, freq.reciprocal*0.33);
    attack = LFSaw.ar([900, 820]).sum * WhiteNoise.ar(1, 0.6);
    attack = HPF.ar(attack, LFNoise2.kr(0.05).exprange(5919.91, 10548.082));
    attack = attack * Env([0, 1, 0], [36/8, 0.0001], 4).ar(gate:attackTrig);
    attack = attack * -40.dbamp;
    attack = Compander.ar( attack, sayA, 0.25, 1/1.25, 1/50, 0.01, 0.17 );
    attack = BBandPass.ar(attack, LFNoise2.kr(0.05).exprange(493.88, 5919.91), 0.25.lag(0.2));
    sig = (sayA + (attack * 0.25));
    LocalOut.ar(sig);
    // sig = Mix.ar(sig);
    sig * ampx4;
}).play;
);
Ndef(\pulse1).gui;
Ndef(\pulse2).ar(2);
Ndef(\pulse2).fadeTime = 4;
(
Ndef(\pulse2,{ | threshold = 0.1, ampx4 = 0.15 |
    var kick, kickTrig, hh, hhTrig, trig, sig, bg, attackTrig, attack, fb, freq;
    trig = HPZ1.kr( threshold >=  ~pulse2.kr );
    freq = ZeroCrossing.kr(~pulse2.kr.lag(0.2)).reciprocal.lag(4);
    // trig = Trig1.ar(trig);
    fb = LocalIn.ar(2).sum;
    fb = DelayC.ar( fb, 1, 0.49);
    fb = AllpassC.ar( fb, 1, 0.5, 10);
    fb = LPF.ar( fb, 800, mul:SinOsc.ar(1/8).range(-25, -35).dbamp);
    bg = BLowPass4.ar( LFSaw.ar( [65.93, 55.44]).sum, SinOsc.ar(1/17).range(1491.91, 592), 0.3, mul:-40.dbamp);
    // attackTrig = PulseDivider.ar(trig, 128, [32]).sum;
    attackTrig = DelayC.ar(/*attackTrig*/trig, 1, 0.125);
    attack = LFSaw.ar([900, 820]).sum * WhiteNoise.ar(1, 0.6);
    attack = HPF.ar(attack, 9000);
    attack = attack * Env([0, 1, 0], [36/8, 0.0001], 4).ar(gate:attackTrig);
    attack = attack * -30.dbamp;
    // kickTrig = trig/*PulseDivider.ar(trig, 4)*/;
    kick = Formant.ar(
        Decay2.ar(K2A.ar(trig), 0.001, 0.5).exprange(34.93, 39.20),
        Decay2.ar(K2A.ar(trig), 0.001, 0.5).exprange(49.39, 55.44),
        Decay2.ar(K2A.ar(trig), 0.001, 0.5).exprange(39.20, 46.62)
    ) * Env.perc(0, 1).kr(gate: trig);
    // kick = LPF.ar(kick, 2000);
    kick = kick + GVerb.ar(
        LPF.ar(kick, 60) + (bg * -10.dbamp) + attack,
        1, 1, damping:0.6, mul:-10.dbamp);
    // kick = SoftClipAmp8.ar(kick, 1);
    hhTrig = PulseDivider.ar(trig, 4, [1, 2]).sum;
    hh = HPF.ar(WhiteNoise.ar(0.1), 6000) * Env.perc(0.001, 0.1).ar(gate:trig);
    // hh = DelayC.ar(hh, 1, 0.4);
    sig = (hh + kick /*+ bg + attack */+ fb);
    sig = Compander.ar( sig, sig, 0.6, 1/3, 1/40, 0.17, 0.05 );
    sig = Limiter.ar(sig);
    Splay.ar(sig);
    LocalOut.ar(sig);
    sig * ampx4;
    // Mix(sig) /*[ampx4, ampx4]*/;
}).play;
);
Ndef(\pulse2).gui;
Ndef(\pulse3).ar(2);
Ndef(\pulse3).fadeTime = 4;
(
Ndef(\pulse3, { | amp = 0.2, threshold = 0.15 |
    var snd, trig, freq;
    trig = HPZ1.kr( threshold >= ~pulse3.kr );
    trig = Trig1.kr(trig);
    freq = ZeroCrossing.kr(~pulse3.kr.lag(0.2)).lag(1);
    snd = SinOsc.ar( ( Lag3UD.kr( trig, 0.001, LFNoise2.kr(0.08).exprange(0.0125, 0.025) ) ).exprange( 43.654 * 0.01 * LFNoise2.kr(0.04).exprange(0.075, 0.125), 22350.607 ) * [-0.1, 0, 0.1].midiratio, 0.5pi );
    // snd = snd.sign - snd;
    snd = Mix(snd) * Env.perc(0, LFNoise2.kr(0.12).range(1, 1.25)).ar(gate: trig);
    snd = ( snd * Lag3UD.kr( trig, 0.001, LFNoise2.kr(0.12).range(1.2, 1.7)).exprange(1, LFNoise2.kr(0.12).range(1.7, 2.4))).tanh;
    snd = BPeakEQ.ar(snd, LFCub.kr(0.12, 1.5pi).exprange(61.74, 164.81), 0.3, 2);
    snd = (snd * 4).tanh;
    snd = BPeakEQ.ar(snd, LFCub.kr(0.08, 0.5pi).exprange(61.74, 2793.826), 0.4, 6);
    // snd = (snd * 5).atan;
    // snd = RHPF.ar(snd, XLine.kr(800, 100, 0.7), 0.3);
    // snd = BHiShelf.ar(snd, 61.74, 1, 1.5);
    snd = (snd * Lag3UD.kr(trig, 0.001, LFNoise2.kr(0.06).range(0.5, 3)).exprange(1, LFNoise2.kr(0.1).range(3, 10))).tanh;
    snd = Compander.ar(
        snd, snd,
        0.1, 1/3, 1/40,
        0.001, 0.17
    );
    snd = HPF2Casc.ar(snd, 21.827, 10);
    snd = BLowPass4.ar( snd, Lag3UD.kr( trig, 0.01, 1 ).exprange(43.654, 11175.303), LFNoise2.kr(0.12).range(0.25, 0.5) );
    snd = snd * AmpComp.kr(1318.51, 164.81);
    snd = LeakDC.ar(snd);
    // snd = snd * Env.linen(0, 0.3, 0.08).ar(gate: trig);
    snd * amp!2;
    // Splay.ar(snd);
    // Mix(snd)
}).play;
);
Ndef(\pulse3).gui;
Ndef(\pulse4).ar(2);
Ndef(\pulse4).fadeTime = 2;

(
Ndef(\pulse4, { |threshold =0.15, amp = 0.5|
    var rot, trig, clk, seq, gli, imp, pic, b, uno, drand, freq;
    trig = HPZ1.kr( threshold >= ~pulse4.kr );
    trig = Trig1.ar(trig);
    freq = ZeroCrossing.kr(~pulse4.kr.lag(0.2)).lag(1);
    clk = trig; //Impulse.ar(rot/8);
    drand = Drand([/*55, 73, */98, 131, 175, 233],inf);
    seq = Demand.ar(clk,0,Dseq([1,0.5,0.75,1,0.5,0.75],inf));
    gli = Demand.ar(clk,0,Dseq([96,84,84,96,84,96],inf));
    rot = Demand.kr(A2K.kr(clk),0,drand);
    imp = clk*seq;
    pic = Latch.ar(gli,imp);
    b = { | decay = 0.5 |
        var trig = HPZ1.kr( threshold >= ~pulse4.kr );
        decay = freq.reciprocal;
        trig = Trig1.ar(trig);
        EnvGen.ar(Env([0,1,0],[0.001,decay],[0,-4]),trig);//-8
    };
    uno ={ | ton = 0,note = 0, sync = 0, mod = 0, wave = 0, mul = 1 |
        var frq = rot/*.lag(0.1)*/;
        var aliasing = SampleRate.ir/2/512;
        var delta  = s.sampleRate/(2056*2);
        var buf1 = Buffer.alloc(Server.local,delta,2);
        var inp1 = LPF.ar(LFTri.ar(frq,1/(aliasing/frq)),aliasing);//anti aliasing filtering
        var inp2 = LFPulse.ar(frq,mul:2,add:-1);
        var rec1 = RecordBuf.ar([inp1,inp2],buf1,0,1,0,1,1,1);
        var osc  = PlayBuf.ar(2,buf1,(1 * (2 ** (1/12) ** note.round)) + (mod) + ton,sync,0,1);
        var sel = Select.ar(wave,[osc[0],osc[1]]);
        sel*mul!2
    };
    // a = PitchShift.ar(a, 0.4, 0.2, 0.1, 0.05);
    a = uno.(0, 0 + (pic ** b.(1/24, imp) * (0.0125/4) ),imp ) * ( b.(0.5, imp )/**seq*/);
    a = BLowPass4.ar( a, Lag3UD.ar( trig, 0.01, 1 ).exprange(43.654, 11175.303), LFNoise2.kr(0.12).range(0.25, 0.5) );
    // a = Limiter.ar(a);
    a = MoogVCF.ar(a,
        SinOsc.kr(LFNoise2.kr(0.007).range(0.001,2.2)).exprange(932, 1865/*,8372.018, 16744.036*/)
        ,0.66) * amp;
    a
    // Mix.ar(a)
}
).play;
);
Ndef(\pulse4).gui;


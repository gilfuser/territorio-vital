(
Ndef(\processInput, {
	var pulse1, pulse2, pulse3, pulse4, p1mean, p2mean, p3mean, p4mean,
    resp1, resp2, resp3, resp4, r1min, r2min, r3min, r4min,
    galv1, galv2, galv3, galv4;
	pulse1 = ~inputs.subBus(0).kr;
	p1mean = TrigAvg.kr(pulse1, Impulse.kr(1)).lag3(2);
    pulse1 = pulse1 - p1mean * 5;
	pulse2 = ~inputs.subBus(1).kr;
	p2mean = TrigAvg.kr(pulse2, Impulse.kr(0.25)).lag3(2);
    pulse2 = pulse2 - p2mean;
	pulse3 = ~inputs.subBus(2).kr;
	p3mean = TrigAvg.kr(pulse3, Impulse.kr(1)).lag3(2);
    pulse3 = pulse3 - p3mean;
	pulse4 = ~inputs.subBus(3).kr;
	p4mean = TrigAvg.kr(pulse4, Impulse.kr(1)).lag3(2);
    pulse4 = pulse4 - p4mean;
	resp1 = ~inputs.subBus(4).kr.lag(0.4);
	r1min = RunningMin.kr(resp1, Impulse.kr(0.0625)).lag3(16)/*.poll(label:'all - avrg')*/;
    resp1 = resp1 - r1min;
	resp2 = ~inputs.subBus(5).kr.lag(0.4);
	// fake input below. // resp1 must be substituted for resp2 when its available
    resp2 = AllpassN.kr(resp1, 5, LFNoise2.kr(0.01).range(4.0, 5.0), 5);
	r2min = RunningMin.kr(resp2, Impulse.kr(0.0625)).lag3(16);
    resp2 = resp2 - r2min;
	resp3 = ~inputs.subBus(6).kr.lag(0.4);
    resp3 = AllpassN.kr(resp1, 10, LFNoise2.kr(0.01).range(8.0, 10.0), 10); // fake input.
	r3min = RunningMin.kr(resp3, Impulse.kr(0.0625)).lag3(16);
    resp3 = resp3 - r3min;
	resp4 = ~inputs.subBus(7).kr.lag(0.4);
    resp4 = AllpassN.kr(resp1, 15, LFNoise2.kr(0.01).range(12.0, 15.0), 15); // fake input.
	r4min = RunningMin.kr(resp4, Impulse.kr(0.0625)).lag3(16);
    resp4 = resp4 - r4min;
	/*
    galv1 = ~inputs.subBus(8).kr.lag3(5);
	galv2 = ~inputs.subBus(9).kr.lag3(5);
	galv3 = ~inputs.subBus(10).kr.lag3(5);
	galv4 = ~inputs.subBus(11).kr.lag3(5);
    */
	[
        Out.kr(~pulse1, pulse1), Out.kr(~pulse2, pulse2),
        Out.kr(~pulse3, pulse3), Out.kr(~pulse4, pulse4),
        Out.kr(~resp1, resp1), Out.kr(~resp2, resp2),
        Out.kr(~resp3, resp3), Out.kr(~resp4, resp4)
        /*,
        Out.kr(~galv1, galv1), Out.kr(~galv2, galv2),
        Out.kr(~galv3, galv3), Out.kr(~galv4, galv4)
        */
    ]
});
);

/*
Ndef(\processInput).gui;
*/
"Process Input Data - LOADED".postString
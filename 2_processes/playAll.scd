Ndef(\playAll, {
	var in = [Ndef(\pulses_gabba).ar, Ndef(\pulses_dark), Ndef(\pulses_metalic), Ndef(\pulses_say)];
	Pan4.ar(in, \xpos.kr(0), \ypos.kr(0));
})
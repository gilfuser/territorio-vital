{
	var w, meter, fscope, bussesScope, scopeParent, meterParent, fScopeParent;
	w = Window("scope", Rect(0, 0, 500, 250).moveTo(1600, 500), border: true, scroll:true).alwaysOnTop_(true).front;
	w.layout =
	// VLayout(
		HLayout(
			meterParent = View(),
			scopeParent = View()
		//),
		// fScopeParent = View()
	);
	meter = ServerMeterView(aserver: s, parent: meterParent, leftUp: 0@0,	numIns: 2, numOuts: 4);
	bussesScope = Stethoscope(s, numChannels:8, index:0, zoom:1, rate:'control', view: scopeParent);
	// fscope = FreqScopeView(parent: fScopeParent, bounds: 0@0, server: s).freqMode_(1);
	// fscope.active_(true);
	w.onClose_({ fscope.kill });

	q.pxmix = NdefMixer(s, 24);
	q.pxmix.skipjack.dt = 0.05;
	q.pxmix.moveTo(1150, 500);
	ProxyMeter.addMixer(q.pxmix);
	// q.pxmix.parent.alwaysOnTop_(true);

}.defer;
"GUIs - LOADED".postString
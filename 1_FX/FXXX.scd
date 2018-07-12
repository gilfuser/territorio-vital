{
	(
		//sound in
		[ /* Ndef(\orb1), Ndef(\orb2), Ndef(\orb3),*/ Ndef(\orb3) ].do(_.addSpec(\inAmp, \ampx4.asSpec));
		//hole
		[ Ndef(\dry)/*, Ndef(\orb2), Ndef(\orb3)*/ ].do(_.addSpec(\damp, [0, 1]));
		[ Ndef(\dry)/*, Ndef(\orb2), Ndef(\orb3)*/ ].do(_.addSpec(\dtime, [0, 2]));
		[ Ndef(\dry)/*, Ndef(\orb2), Ndef(\orb3)*/ ].do(_.addSpec(\size, [0.5, 3]));
		[ Ndef(\dry)/*, Ndef(\orb2), Ndef(\orb3)*/ ].do(_.addSpec(\diff, [0, 1]));
		[ Ndef(\dry)/*, Ndef(\orb2), Ndef(\orb3)*/ ].do(_.addSpec(\fb, [0, 1]));

		//zRidm
		Ndef(\sayA).addSpec( \up, [ 10, 1000 ]);
		Ndef(\sayA).addSpec( \dn, [ 10, 1000 ]);
		Ndef(\sayA).addSpec( \aTresh, [ 0.005, 0.75, \exp ]);
		Ndef(\sayA).addSpec( \aDecay, [ 0.03, 1 ]);

		//filter
		/*Ndef(\orb1).addSpec(\lbhnp, [0, 4, \lin, 1, 0]);
		Ndef(\orb1).addSpec(\sfreq, \freq);
		Ndef(\orb1).addSpec(\res, [0, 1]);*/

		//pitch
		[ Ndef(\sayB)/*, Ndef(\orb2), Ndef(\orb3)*/ ].do(_.addSpec(\degree, [-14, 14, \lin, 1]));
		[ Ndef(\sayB)/*, Ndef(\orb2), Ndef(\orb3)*/ ].do(_.addSpec(\pitchDisp, [0, 0.5]));
		[ Ndef(\sayB)/*, Ndef(\orb2), Ndef(\orb3)*/ ].do(_.addSpec(\timeDisp, [0, 1]));
		[ Ndef(\sayB)/*, Ndef(\orb2), Ndef(\orb3)*/ ].do(_.addSpec(\slide, [0.02, 2]));

		//1_distort
		/*Ndef(\orb3).addSpec(\dgain, \ampx4.asSpec);
		Ndef(\orb3).addSpec(\sustain, [0.1, 4]);*/

		//wah
		[ /*Ndef(\orb2), */Ndef(\sayC) ].do(_.addSpec(\ring, [0.003, 3, \exp]));
		[ /*Ndef(\orb2), */Ndef(\sayC) ].do(_.addSpec(\rate, [0.2, 20, \exp]));
		[ /*Ndef(\orb2), */Ndef(\sayC) ].do(_.addSpec(\depth, [0, 1]));
		[ /*Ndef(\orb2), */Ndef(\sayC) ].do(_.addSpec(\ggain, [0.001, 1, \amp]));
		[ /*Ndef(\orb2), */Ndef(\sayC) ].do(_.addSpec(\wrq, [0.2, 2]));

		//ring_mod
		// Ndef(\orb2).addSpec(\rfreq, \freq);


		// LINKed stuff
		/*
		[ Ndef(\orb1), Ndef(\orb2), Ndef(\orb3) ].do(_.addSpec(\tempo, [ 0.025, 25 ]));
		[ Ndef(\orb1), Ndef(\orb2), Ndef(\orb3) ].do(_.addSpec(\t_trig, [ 0, 1, 1]));
		[ Ndef(\orb1), Ndef(\orb2), Ndef(\orb3) ].do(_.addSpec( \iphase, [ 0, 1 ]));
		[ Ndef(\orb1), Ndef(\orb2), Ndef(\orb3) ].do(_.addSpec( \dur, [ 0.01, 10 ]));
		*/
		// [ Ndef(\orb1), Ndef(\orb2), Ndef(\orb3) ].do(_.addSpec(\trig, [ 0, 1, 1]));

		//lStrobe
		/*[ Ndef(\orb2), Ndef(\orb3) ].do(_.addSpec(\strobe, [0.25, 12, 1, 0.25]));
		[ Ndef(\orb2), Ndef(\orb3) ].do(_.addSpec(\lscurve, [0, 6, 0, 1]));
		[ Ndef(\orb2), Ndef(\orb3) ].do(_.addSpec(\onTime, [0.16, 16]));
		[ Ndef(\orb2), Ndef(\orb3) ].do(_.addSpec(\offTime, [0.16, 16]));
		[ Ndef(\orb2), Ndef(\orb3) ].do(_.addSpec(\lsphase, [0.16, 16]));*/

		//lTape
		/*[ Ndef(\orb1), Ndef(\orb3) ].do(_.addSpec(\toffset, [0, 1]));
		[ Ndef(\orb1), Ndef(\orb3) ].do(_.addSpec(\depth, [0, 1]));

		//lFakeDuck
		[ Ndef(\orb1), Ndef(\orb2), Ndef(\orb3) ].do(_.addSpec( \dcurve, [ -6, 6 ]));
		[ Ndef(\orb1), Ndef(\orb2), Ndef(\orb3) ].do(_.addSpec( \dwidth, [ 0, 1 ]));

		//lLFO
		[ Ndef(\orb1), Ndef(\orb2), Ndef(\orb3) ].do(_.addSpec(\hifreq, [200, 20000, \exp, 0, 220, units: " Hz"]));
		[ Ndef(\orb1), Ndef(\orb2), Ndef(\orb3) ].do(_.addSpec( \lwidth, [ 0, 1 ]));
		[ Ndef(\orb1), Ndef(\orb2), Ndef(\orb3) ].do(_.addSpec(\sinSawPul, [0, 2, \lin,1, 1]));*/



		//AmpFin
		[ Ndef(\orb1), Ndef(\orb2), Ndef(\orb3) ].do(_.addSpec(\limDrive, \ampx4 ));
		[ Ndef(\orb1), Ndef(\orb2), Ndef(\orb3) ].do(_.addSpec(\ampLimit, \amp ));
		[ Ndef(\orb1), Ndef(\orb2), Ndef(\orb3) ].do(_.addSpec(\postAmp, \ampx4 ));
	);
	0.1.wait;

	q.fx.fxLib.keysValuesDo( { |key,val| ProxyChain.add( key.asSymbol, \filterIn -> val) } );
	0.1.wait;
	q.fx.orb1 = ProxyChain.from( Ndef(\dry), [ /* 'SOUND_IN', */'pitch', 'lTape', 'hole', 'ridm', 'filter', 'lFakeDuck', 'lLFO', 'ampFin' ]);
	q.fx.orb2 = ProxyChain.from( Ndef('orb2'), [ /* 'SOUND_IN', */'ring_mod', 'hole', 'pitch', 'wah', 'lFakeDuck', 'lLFO', 'ampFin' ]);
	q.fx.orb3 = ProxyChain.from( Ndef('dry'), [ /* 'SOUND_IN', */'hole' ]);
	/* q.fx.orb2.add(\WAH)*/
	0.1.wait;
	(
		Ndef(\dry).set( /* \inAmp, 0,*/
			/* pitch*/ \degree, 0, \pitchDisp, 0.001, \timeDisp, 0.1, \slide, 0.2,
			/* lTape*/ \depth, 0.1, \toffset, 0.2,
			/* hole*/ \dtime, 0.667, \damp, 0.05, \size, 0.5, \diff, 0.14, \fb, 0.5,
			/* ridm*/ \up, 666, \dn, 250, \aTresh, 0.55, \aDecay, 0.05,
			/* filter*/ \lbhnp, 1, \sfreq, 632.46, \res, 0.5,
			/* LINKed Stuff*/ \tempo, 1, /*\t_trig, 1, */\iphase, 0, \dur, 1,
			/* lFakeDuck*/ \dcurve, 2, \dwidth, 1,
			/* lLFO*/ \midfreq, 60, \hifreq, 13000, \sinSawPul, 1,'lwidth', 1.0,
			/* ampFin*/ \limDrive, 1.25, \ampLimit, 1, \postAmp, 1.25 );
		Ndef(\orb2).set( /* \inAmp, 0, */
			/* wah*/ \ring, 0.003, \rate, 1, \depth, 0.5, \ggain, 1, \wrq, 0.75,
			/* pitch*/ \degree, 0, \pitchDisp, 0, \timeDisp, 0.01, \slide, 0.2,
			/* LINKed Stuff*/ \tempo, 1, /*\t_trig, 1, */\iphase, 0, \dur, 1,
			/* lFakeDuck*/ \dcurve, 0, \dwidth, 0,
			/* lLFO*/ \midfreq, 60, \hifreq, 13000, \sinSawPul, 1,
			/* ampFin*/ \limDrive, 1, \ampLimit, 1, \postAmp, 1 );
		Ndef(\orb3).set( /*\inAmp, 0,*/
			/* hole*/ \dtime, 0.666,  \damp, 0.13, \size, 0.6, \diff, 0.2, \fb, 0.3333,
			/* pitch*/ \degree, 0, \pitchDisp, 0, \timeDisp, 0.01, \slide, 0.2,
			/* WAH*/ \ring, 0.003, \rate, 1, \depth, 0.5, \ggain, 1, \wrq, 0.75,
			/* LINKed Stuff*/ \tempo, 1, /*\t_trig, 1, */\iphase, 0, \dur, 1,
			/* lFakeDuck*/ \dcurve, 0, \dwidth, 0,
			/* lLFO*/ \midfreq, 60, \hifreq, 13000, \sinSawPul, 1,
			/* ampFin*/ \limDrive, 1, \ampLimit, 1, \postAmp, 1 );
	);
	0.1.wait;
	(
		// q.fx.orb1.add('SOUND_IN', 0 );
		q.fx.orb1.add('pitch', 0 );
		q.fx.orb1.add('lTape', 0 );
		q.fx.orb1.add('hole', 0 );
		q.fx.orb1.add('ridm', 0 );
		q.fx.orb1.add('filter', 0 ); // lpf, bpf, hpf, notch, peak
		q.fx.orb1.add('lFakeDuck', 0 );
		q.fx.orb1.add('lLFO', 0 );
		q.fx.orb1.add('ampFin', 0 );
		// q.fx.orb2.add('SOUND_IN', 0 );
		q.fx.orb2.add('ring_mod', 0 );
		q.fx.orb2.add('hole', 0 );
		q.fx.orb2.add('pitch', 0 );
		q.fx.orb2.add('wah', 0);
		q.fx.orb2.add('lFakeDuck', 0 );
		q.fx.orb2.add('lLFO', 0 );
		q.fx.orb2.add('ampFin', 0);
		// q.fx.orb3.add('SOUND_IN', 0 );
		// q.fx.orb3.add('1_distort', 0 );
		q.fx.orb3.add('hole', 1 );
		q.fx.orb3.add('pitch', 0 );
		q.fx.orb3.add('wah', 0);
		q.fx.orb3.add('lFakeDuck', 0 );
		q.fx.orb3.add('lLFO', 0 );
		q.fx.orb3.add('ampFin', 0);
	);
	//////////////////////////////////////////////////////////////////////
	/*
	Pro: easy to access all params from T.OSC. Con: Needs to much attention on the T.OSC
	~fxGui1 = q.fx.orb1.gui(42).moveTo(1500, 570);
	~fxGui2 = q.fx.orb2.gui(34).moveTo(820, 570);
	*/
	// q.fx.orb2.gui(26).moveTo(1500, 555);
	/* */
	0.1.wait;
	(
		q.thisDir = thisProcess.nowExecutingPath.dirname;
		// Con:It won't be easy to access controlkeys. Pro: Good for liveCoding
		{
			q.o1Pset = NdefPreset( Ndef(\dry) );
			q.o1Pset.loadSettings( q.thisDir ++ "/orb1.pxpreset.scd");
			q.o1PsetGui = NdefPresetGui(q.o1Pset, 42).moveTo(420, 25);

			q.o2Pset = NdefPreset( Ndef(\orb2) );
			q.o2Pset.loadSettings( q.thisDir ++ "/orb2.pxpreset.scd");
			q.o2PsetGui = NdefPresetGui(q.o2Pset, 42).moveTo(960, 25);

			q.o3Pset = NdefPreset( Ndef(\orb3) );
			q.o3Pset.loadSettings( q.thisDir ++ "/orb3.pxpreset.scd");
			q.o3Psetgui = NdefPresetGui(q.o3Pset, 42).moveTo(1500, 25);

		}.defer;
	);
	/*
	{
	q.fxwin = Window("The FXs", Rect( 0, 0, 1040, 690),scroll:true ).front;
	q.fxwin.addFlowLayout;
	q.pchains = [q.fx.orb0, q.fx.orb1/* , q.fx.orb2, q.fx.orb3*/].sort { |px1, px2| px1.key < px2.key };
	q.pChainGuis = q.pchains.keep(3).collect { |px, i|
	var gui = ProxyChainGui(px, 35, q.fxwin);
	//q.fxwin.view.decorator.nextLine.shift(0, 2);
	gui.skipjack.dt = 0.03;
	gui;
	}
	}.defer;
	*/
	// fine tuning with docs,
	ParamGui
	q.fx.orb2.slotsInUse;

	Ndef(\orb1).addSpec(\dcurve, [-8, 8]);
	{}.plot(p.clock.tempo)
	Ndef(\orb0).gui;
	Ndef(\orb0).addSpec(\width, [0, 1]);
	Ndef(\orb0).addSpec(\curve, [-6, 6]);

	(
	Ndef(\grilos)[10] = \filterIn -> {  | in, dtime = 0.1, damp = 0.1, size = 1, diff = 0.707, fb = 0.1 |
		Greyhole.ar( in, dtime, damp, size.lag(0.2), diff, fb );
	};
	);
	/*

	Pdef( \lfo,
		Pbind(
			\type, \set,
			\id, Ndef(\orb0).group,
			\args, #[\iphase, \tempo, \dur],
			\dur, 1, //Pseq([1, 2/3, 1/3, 0.25, 0.5, 0.5, 0.25, 0.5, 0.25, 0.25], inf),
	\iphase, Pfunc({thisThread.clock.beats}),
	\tempo, Pfunc({thisThread.clock.tempo}),
)).play(p.clock).quant_(p.quant);
	*/

	/* Ndef(\orb3)[80] = \filter -> { arg in, lowPass=15000, highPass=40; var l, h;
	l = HPF2Casc.ar( in, highPass);
	h = LPF2Casc.ar( in, lowPass);
	h-l;
	}*/
}.fork;





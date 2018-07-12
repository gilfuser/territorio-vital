{
	q.pulse1 = FilePlayer(q.topDir +/+ "pulse1.txt");
	q.pulse2 = FilePlayer(q.topDir +/+ "pulse2.txt");
	q.pulse = FilePlayer(q.topDir +/+ "pulse.txt");
	q.resp = FilePlayer(q.topDir +/+ "resp.txt");
	q.galv = FilePlayer(q.topDir +/+ "galvanicSkinResponse.txt");
	0.1.wait;
	(
		Tdef(\dataPlay, {
			2880000.do{ |i| // 4 hours of data playing
				~inputs.setAt( 0, q.pulse1.readAtLineInterpret(i % 2400).pop.linlin(0, 1023, 0, 1).lag(0.2) );
				~inputs.setAt( 1, q.pulse2.readAtLineInterpret(i % 2400).pop.linlin(0, 1023, 0, 1).lag(0.2) );
				~inputs.setAt( 2, (q.pulse.readAtLineInterpret(i % 2400)[0]).linlin(0, 1023, 0, 1).lag(0.2) );
				~inputs.setAt( 3, (q.pulse.readAtLineInterpret(i % 2400)[1]).linlin(0, 1023, 0, 1).lag(0.2) );
				~inputs.setAt( 4, q.resp.readAtLineInterpret(i % 6000).lag(0.2) );
				~inputs.setAt( 5, q.resp.readAtLineInterpret(i % 6000).lag(0.2) );
				~inputs.setAt( 6, q.resp.readAtLineInterpret(i % 6000).lag(0.2) );
				~inputs.setAt( 7, q.resp.readAtLineInterpret(i % 6000).lag(0.2) );
				~inputs.setAt( 8, q.galv.readAtLineInterpret(i % 3000).linlin(0, 1023, 0, 1 ).lag(0.2) );
				~inputs.setAt( 9, q.galv.readAtLineInterpret(i % 3000).linlin(0, 1023, 0, 1).lag(0.2) );
				~inputs.setAt( 10, q.galv.readAtLineInterpret(i % 3000).linlin(0, 1023, 0, 1).lag(0.2) );
				~inputs.setAt( 11, q.galv.readAtLineInterpret(i % 3000).linlin(0, 1023, 0, 1).lag(0.2) );
				0.005.wait;
			};
			20.do{
				"RESET READ-DATA TDEF".postString;
				1.0.wait;
			};
		}).play;
	);
	0.1.wait;
	{Tdef(\dataPlay).gui}.defer;
}.fork;

"DataPlay - LOADED".postString
q.maMasta = MasterFX(s, 2, ['00_in', /*'stereoSum', */'par_EQ', 'comp', 'filter', 'ampFin']);
q.maMasta.add('00_in', 1);
// q.maMasta.add('stereoSum', 1);
// q.maMasta.add('par_EQ', 0);
// q.maMasta.add('comp', 1);
// q.maMasta.add('filter', 0);
q.maMasta.add('ampFin', 1);
q.maMasta.gui("MASTA!", 20);


/*
MasterFX.clear('localhost')
*/

/*Spec.add( \pFreq, \freq.asSpec );
Spec.add( \pDb, [-60, 32, \lin, 0, 1] );
Spec.add( \pRq, \rq.asSpec );*/

Ndef('zz_mastafx').set('postAmp', 1.5/*, 'wet60', 1.0, 'wet10', 1*/);

"MASTA FX - LOADED".postString;

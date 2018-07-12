//>>>>>>>>>>>>>>>>> TO DO! >>>>>>>>>  Influx and MKtlLoop >>>>>>>>>>>>>>

q = q ? ();
{
    "0_globals/0_loadGlobalUtils.scd".loadRelative;
    "0_globals/1_GUIs.scd".loadRelative;

    0.1.wait;
    "1_Communication/busses*".loadRelative;
    0.1.wait;
    // comment below if there is no input from Arduino... port will close on: cmd + .
    "1_Communication/arduinoReceive_serialPort*".loadRelative;

    //comment below out if there is no Serial Port input.
    /*
	"8_dataPlay*".loadRelative;
	*/
    0.1.wait;
    "1_Communication/processInputData*".loadRelative;
    0.1.wait;
    "1_FX/0_fxLib*".loadRelative;
    0.6.wait;
    "1_FX/1_masterFX*".loadRelative;
    0.1.wait;
    "2_processes/pulses_dark.scd".loadRelative;
    0.1.wait;
    "2_processes/pulses_gabba.scd".loadRelative;
    0.1.wait;
    "2_processes/pulses_say.scd".loadRelative;
    0.1.wait;
    "2_processes/pulses_metalic.scd".loadRelative;
    0.1.wait;
    "2_processes/respira.scd".loadRelative;
    0.4.wait;
    // "1_FX/FXXX*".loadRelative;
    // 0.4.wait;
    // Pdefn(\scaleA, Scale.choose(7, 12).tuning_(Tuning.choose(12)));
}.fork;
/*
/
//
///
////
/////
//////
////////
//////////
////////////
//////////////
////////////////
//////////////////
////////////////////
///////////////////////
(q.topDir +/+ "0_globals/0_loadGlobalUtils.scd").openDocument;
///////////////////////
(q.topDir +/+ "0_globals//1_GUIs.scd").openDocument;
////////////////////////////
(q.topDir +/+ "1_Communication/busses.scd").openDocument;
//////////////////////////////////
(q.topDir +/+ "1_Communication/arduinoReceive_serialPort.scd").openDocument;
//////////////////////////////////////////
(q.topDir +/+ "7_dataRec.scd").openDocument;
////////////////////////////////////////////
(q.topDir +/+ "8_dataPlay.scd").openDocument;
/////////////////////////////////////////////
(q.topDir +/+ "1_Communication/processInputData.scd").openDocument;
//////////////////////////////////////////////
(q.topDir +/+ "1_FX/0_fxLib.scd").openDocument;
//////////////////////////////////////////
(q.topDir +/+ "1_FX/1_masterFX.scd").openDocument;
//////////////////////////////////////////////
(q.topDir +/+ "2_processes/pulses_gabba.scd").openDocument;
(q.topDir +/+ "2_processes/pulses_say.scd").openDocument;
(q.topDir +/+ "2_processes/pulses_metalic.scd").openDocument;
(q.topDir +/+ "2_processes/pulses_dark.scd").openDocument;
(q.topDir +/+ "2_processes/respira.scd").openDocument;
////////////////////////////////////////////
(q.topDir +/+ "1_FX/FXXX.scd").openDocument;
/*
// open this folder programmatically, e.g. while working on setup
defer{ thisProcess.nowExecutingPath.dirname.openOS };
*/

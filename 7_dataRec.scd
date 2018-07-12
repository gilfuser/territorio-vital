q.ardudata = FileWriter( q.topDir +/+ "arduOut.txt", "w", false);

(
Tdef(\dataRec, {
    // s.record; // record the sound while recording the data. Good to checking
	60000.do{
		q.ardudata.writeLine(
			~inputs.subBus(3).getSynchronous.asArray; // choose the data to be recorded.
		);
		0.005.wait;
	};
	"recording data is done".postln;
	//s.stopRecording
});
);
Tdef(\dataRec).gui;
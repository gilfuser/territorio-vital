q = q ? ();
/*
q.port.close;
30.do {q.port.read.asAscii.postln};
    ~test = ~test ?? Bus.control(s, 1);
~test.getSynchronous
*/
{
    q.arduIn = 12; // number of inputs
    ~inputs = ~inputs ?? Bus.control(s, q.arduIn.value);
    ~inputs.getnSynchronous;
    { q.port = SerialPort("/dev/ttyACM0", 115200, crtscts: true); CmdPeriod.doOnce({ q.port.close}); s.sync; }.fork;
    0.2.wait;
    (
        Tdef(\arduRecv, {
            var headers = (255 .. ( 255 - (q.arduIn.value - 1) ) ).invert;
            var next = 0;
            var byte, str, res;
            // headers.do{ |head i|
            //
            // }
            9999999.do { |i|
                switch ( q.port.read,
                    /*
                    */
                    244 , {
                        str = "";
                        while( { byte = q.port.read; byte !=245 }, {
                            str= str++byte.asAscii;
                        });
                        res= str.asInteger;
                        ~inputs.setAt(0, res.linlin(0, 1023, 0, 1)) },
                    245 , {
                        str = "";
                        while( { byte = q.port.read; byte !=246 }, {
                            str= str++byte.asAscii;
                        });
                        res= str.asInteger;
                        ~inputs.setAt(1, res.linlin(0, 1023, 0, 1)) },
                    246 , {
                        str = "";
                        while( { byte = q.port.read; byte !=247 }, {
                            str= str++byte.asAscii;
                        });
                        res= str.asInteger;
                        ~inputs.setAt(2, res.linlin(0, 1023, 0, 1)) },
                    247 , {  // resp 1
                        str = "";
                        while( { byte = q.port.read; byte !=248 }, {
                            str= str++byte.asAscii;
                        });
                        res= str.asInteger;
                        ~inputs.setAt(3, res.linlin(0, 1023, 0, 1))
                        // ~test.set(res.linlin(0, 1023, 0, 1))
                        },
                    /*
                    */
                    248 , {
                        str = "";
                        while( { byte = q.port.read; byte !=249 }, {
                            str= str++byte.asAscii;
                        });
                        res= str.asInteger;
                        ~inputs.setAt(4, res.linlin(0, 1023, 0, 1)) },
                    249 , {
                        str = "";
                        while( { byte = q.port.read; byte !=250 }, {
                            str= str++byte.asAscii;
                        });
                        res= str.asInteger;
                        ~inputs.setAt(5, res.linlin(0, 1023, 0, 1)) },
                    250 , {
                        str = "";
                        while( { byte = q.port.read; byte !=251 }, {
                            str= str++byte.asAscii;
                        });
                        res= str.asInteger;
                        ~inputs.setAt(6, res.linlin(0, 1023, 0, 1)) },
                    251 , {
                        str = "";
                        while( { byte = q.port.read; byte !=252 }, {
                            str= str++byte.asAscii;
                        });
                        res= str.asInteger;
                        ~inputs.setAt(7, res.linlin(0, 1023, 0, 1)) },
                    252 , {
                        str = "";
                        while( { byte = q.port.read; byte !=253 }, {
                            str= str++byte.asAscii;
                        });
                        res= str.asInteger;
                        ~inputs.setAt(8, res.linlin(0, 1023, 0, 1)) },
                    253 , {
                        str = "";
                        while( { byte = q.port.read; byte !=254 }, {
                            str= str++byte.asAscii;
                        });
                        res= str.asInteger;
                        ~inputs.setAt(9, res.linlin(0, 1023, 0, 1)) },
                    254 , {
                        str = "";
                        while( { byte = q.port.read; byte !=255 }, {
                            str= str++byte.asAscii;
                        });
                        res= str.asInteger;
                        ~inputs.setAt(10, res.linlin(0, 1023, 0, 1)) },
                    255 , {
                        str = "";
                        while( { byte = q.port.read; byte !=244 }, {
                            str= str++byte.asAscii;
                        });
                        res= str.asInteger;
                        ~inputs.setAt(11, res.linlin(0, 1023, 0, 1)) }

                    /*
                    headers[next] , {
                    str = "";
                    while( { byte = q.port.read; byte != headers[ next + 1 % headers.size ] }, {
                    str= str++byte.asAscii;
                    });
                    res= str.asInteger;
                    ~inputs.setAt(next, res);
                    next = next + 1 % headers.size }
                    */
                )
            };
            "RESET TDEF".postString;
        })/*.play*/;
    );

    {Tdef(\arduRecv).gui}.defer;
    /*
    Tdef(\arduRecv).stop;
    */
    0.2.wait;
    100.do {~inputs.getnSynchronous.postln; 0.1.wait; };
    10.wait;
    "receive inputs from Arduino to MFdef(\arduino) - loaded".postString;
}.fork
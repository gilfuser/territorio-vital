~inputs = ~inputs ?? Bus.control(s, 12); // number of inputs
~pulse1 = ~pulse1 ?? Bus.control.set(0);
~pulse2 = ~pulse2 ?? Bus.control.set(0);
~pulse3 = ~pulse3 ?? Bus.control.set(0);
~pulse4 = ~pulse4 ?? Bus.control.set(0);
~resp1 = ~resp1 ?? Bus.control.set(0);
~resp2 = ~resp2 ?? Bus.control.set(0);
~resp3 = ~resp3 ?? Bus.control.set(0);
~resp4 = ~resp4 ?? Bus.control.set(0);
~galv1 = ~galv1 ?? Bus.control.set(0);
~galv2 = ~galv2 ?? Bus.control.set(0);
~galv3 = ~galv3 ?? Bus.control.set(0);
~galv4 = ~galv4 ?? Bus.control.set(0);

"Busses to carry the inputs: ~pulse1, ~pulse2, ~pulse3, ~pulse4, ~resp1, ~resp2, ~resp3, ~resp4, ~galv1, ~galv2, ~galv3, ~galv4 - LOADED".postString;
package test;

type stream0 = Stream(Bit(4));

streamlet mux2<i:int, t:type> {
  in : stream0 [i] in,
  overflow: Stream(Bit(i)) out,
  out : stream0 out,
};

implement temp of mux2<8, typename Bit(10)> {
  
};

implement tmux<n:int, t : type> of mux2<n, typename stream0> {
  instance adders(temp) [8],
  instance and_gate(tmux),
  for i in 0-1->N./2 {
    self.inputs[i*2] => adders[i].a,
    self.inputs[i*2+1] => adders[i].b,
    adders[i].overflow => self.overflow[i],
    adders[i].overflow => and_gate.input[i],
    adders[i].out =1=> self.out,
  }
  and_gate.output => global_overflow,
  
};


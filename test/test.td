package test;

const flag = true;
const num_instance = 8;
const num_stream = 2;

type stream0 = Stream(Bit(4));

streamlet sl0<i:int, t:type> { //define a streamlet with templates
  in : stream0 in,
  out : stream0 out,
  
  in_array : t [num_stream] in,
  out_array : t [num_stream] out,
};


streamlet sl1 {
  in : stream0 in,
  out : stream0 out,
  
  in_array : stream0 [num_stream] in,
  out_array : stream0 [num_stream] out,
};

impl temp_impl of sl0<1, type Bit(1)> {
  
};
impl tmux<n: int, ts: impl of sl0<num_instance, type Bit(1)>> of sl0<n, type stream0> {
  instance test_inst(ts),
  
  test_inst.out => test_inst.in,
  
  process{},
};
impl test of sl0<1, type Bit(1)> {
  instance inst0(tmux<1, impl test>),
};

//////////////////////////////REGION2

impl temp_impl2 of sl1 {
  
};
impl tmux2<n: int, ts: impl of sl1> of sl0<n, type stream0> {
  instance test_inst(ts),
  
  test_inst.out => test_inst.in,
  
  process{},
};
impl test2 of sl1 {
  instance inst0(tmux2<1,impl temp_impl2>),
};

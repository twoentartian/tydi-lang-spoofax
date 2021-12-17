package test;

type stream0 = Stream(Bit(4));

const val = 1;

type Group com {
  a: Bit(4),
  b: Bit(4),
  const val = 0,
};

const com_value = type com.val;

streamlet sl0<i:int, t:type> {
  const val = 0,
};

const test0 = streamlet sl0.val;

impl tmux<n: int> of sl0<n, type stream0> {

  const val = 0,
  
  process{},
};

const test1 = impl tmux.val;

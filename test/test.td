package test;

type stream0 = Stream(Bit(4));
const val = 1; // this val will be shadowed.
type Group com {
  a: Bit(4),
  b: Bit(4),
  const val = 0, //define a const value in type com
};

const com_value = type com.val; //access the const value in com.

streamlet sl0<i:int, t:type> {
  const val = 0, //define a const value in streamlet sl0
};

const test0 = streamlet sl0<1, type Bit(10)>.val; //access the const value in sl0.

impl tmux<n: int> of sl0<n, type stream0> {

  const val = 0, //define a const value in streamlet implement tmux
  
  process{},
};

const test1 = impl tmux<1>.val; //access the const value in tmux.
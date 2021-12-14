# Tydi language specification (pocket edition)

## Literals

### Comment

Comments in Tydi is similar to the C-style line comments. Block comments is currently not supported.

```cpp
//This is a comment in Tydi-lang
```

### Int 

```cpp
0 //normal integer 0
0x01234567894abcdef // hex integer
0x01234567894ABCDEF // hex integer is case insensitive
0o01234567 // octal integer
0b01010101 // binary integer
0b0000_0001 // you can use "_" as a separator anywhere except the beginning of the integer.
```

###Float

```cpp
1.0
22.00205
```

### String

```cpp
"123" // this is a string
```

### Boolean literal

```cpp
true
false // notice that "true" and "false" are case sensitive
```



## Const values

### Basic const values

You can define variables as many other programming languages to generate the hardware components. However, in Tydi-lang, all variables must be mutable, means they cannot be changed after definition. Tydi-lang support three built-in data types: ```bool```, ```int``` and ```string```. 

```cpp
const eight : int = 8;
const string : str = "Hello";
const flag : bool = true;
const f:float = 1.0;
```

Tydi-lang also supports type inference. For this case the type of the const will be inferenced from the type of literal.

````cpp
const eight = 8;
const string = "Hello";
const flag = true;
const f = 1.0;
````

### Const value expression

You can use arithmetic operations on const values to calculate new values. These calculation must be able to be performed on the front end stage. In other words, all values will be evaluated at the front end stage.

#### Arithmetic operations for integer 

```cpp
const number0 :int = 1;
const number1 :int = 2;

const add = number0 + number1; // add = 1+2 = 3
const minus = number1 - number0; // minus = 2-1 = 1
const times = number0 * number1; // times = 1*2 = 2
const div0 = number0 ./ number1; // div0 = 1/2 = 0, please notice that div follows the integer divide rules.
const div1 = number1 ./ number0; // div1 = 2/1 = 2

const mod = number0 % number1; // mod = 1%2 = 1
const left_shift = number0 << number1; // left_shift = 1<<2 = ob100 = 4
const right_shift = number0 >> number1; // right_shift = 1>>2 = 0

const power = number1 ^ number0; //power = 2^1 = 2

const bitwise_and = number0 & number1; //bitwise_and = 0b01 & 0b10 = 0b00 = 0
const bitwise_or = number0 | number1; //bitwise_and = 0b01 & 0b10 = 0b11 = 3
const bitwise_not = ~ (4) number0; //bitwise_not = ~ 0b0001 = 0b1110 = 14, notice that the expression "4" indicates the bit length of the data, becuase we don't specify the integer bit length when we declare it.
```

#### Arithmetic operations for floating point

Basic arithmetic operations such as addition, minus, multiplication, and power are also applicable for floating point numbers where the result type will be float.

```cpp
const number0 :float = 1.0;
const number1 :float = 2.0;
const int0 : int = 1;

const add = number0 + number1; // add = 1.0+2.0 = 3.0
const add2 = int0 + number1; // add = 1+2.0 = 3.0
const minus = number1 - number0; // minus = 2.0-1.0 = 1.0
const times = number0 * number1; // times = 1.0*2.0 = 2.0

const power = number1 ^ number0; //power = 2.0^1.0 = 2.0
```

Logarithm computation is useful for calculating bit length. Tydi lang supports logarithm as following code.

```cpp
const log = log 2 (8); //log_lower = log2(8) = 3.0
const log = log 2.0 (8.0); //log_lower = log2.0(8.0) = 3.0, the inputs data type can be int or float, the output type is always float.
```

To convert a floating point number to an integer number, you can use following three converting functions.

```cpp
const int0 = round(2.5); //int0 = 3
const int1 = round(2.4); //int1 = 2

const int2 = floor(2.5); //int2 = 2, round up
const int3 = ceil(2.5); //int3 = 3, round down
```

#### Logical operations

Logical operations only support bool values.

```cpp
const flag0 = true;
const flag1 = false;

const logical_and = flag0 && flag1; // logical_and = true && false = false
const logical_or = flag0 || flag1; // logical_or = true || false = true
const logical_not = ! flag0;  // logical_and = !true = false
```

#### Comparison operation

Comparison operations only support integer values.

```cpp
const value0 = 1;
const value1 = 2;

const comparision0 = value0 == value1; //equal = (1==2) = false
const comparision1 = value0 != value1; //equal = (1!=2) = true
const comparision2 = value0 < value1; //equal = (1<2) = true
const comparision3 = value0 <= value1; //equal = (1<=2) = true
const comparision4 = value0 > value1; //equal = (1>2) = false
const comparision5 = value0 >= value1; //equal = (1>=2) = false

const comparision6 = 1.0==1.0;//Notice: comparision among floating point is possible but may suffer from floating point error
```

### Array const values 

Defining an array is useful for generating parallelized hardware components. In Tydi-lang, you can define an array as follow. NOTICE: all expressions in an array must have the same type.

```cpp
const array_of_int : int[] = {1,2,3};
const array_of_str : str[] = {"1","2","3"};
const flags : bool[] = {true,true,false};
```

Similarly, the type inference is also possible.

```cpp
const array_of_int = {1,2,3}; // an array of integer
const array_of_str = {"1","2","3"}; // an array of string
const flags = {true,true,false}; // an array of bool
```

You can also use integer step to represent an array. An integer step contains three integer expressions, which are "start value", "step value" and "stop value". NOTICE: this representation only works for integer.

```cpp
const int_array = 0-1->5; // int_array = {0,1,2,3,4}, an array starts from 0 until 5 with a step of 1.
```

#### Array operations

To access an element of an array.

```cpp
const a = int_array[0]; // the type of a will be infered as int
```

Append data to the array.

```cpp
const a = int_array + 5; // a = {0,1,2,3,4,5}, append 5 at the end of the array
const b = 5 + int_array; // a = {5,0,1,2,3,4}, append 5 at the begin of the array
```

### Const data operation across types

Tydi-lang also provides limited auto conversion between different const data types. For example, appending an integer or bool at the end of a string is possible.

```cpp
const str0 = " hello ";
const flag = true;
const str1 = str0 + 1; //str1 = "hello 1"
const str2 = 1 + str0; //str1 = "1 hello"
const str3 = flag + str0; //str1 = "true hello"
```



## Logical data type


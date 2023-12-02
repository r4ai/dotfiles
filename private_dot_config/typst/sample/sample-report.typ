#import "../math.typ": *
#import "../template.typ": report, code-info
#show: report.with(
  title: [
    #text(font: "Noto Emoji")[#emoji.crab] \
    計算機科学基礎実験 \
    第一回レポート \
    Rustによるプログラミング演習
  ],
  author: [
    情報科学科 \
    Rai
  ]
)

= 課題内容

== 課題1: Rustでハローワールドを出力する

Rustのプログラミング言語を使用して、コンソールに「Hello, World!」と出力するプログラムを作成してください。

プログラムの実行結果は @code:task-helloworld のようになることを確認してください。

#code-info(
  label: "code:task-helloworld",
)
```txt
$ cargo run
   Compiling hello-world v0.1.0 (/home/r4ai/Projects/hello-world)
    Finished dev [unoptimized + debuginfo] target(s) in 0.25s
     Running `target/debug/hello-world`
Hello, World!
```

== 課題2: RustでFizzBuzzを実装する

Rustのプログラミング言語を使用して、1から100までの整数を順番に出力するプログラムを作成してください。

ただし、以下の条件を満たすようにしてください。

- 3の倍数の場合は「Fizz」を出力する
- 5の倍数の場合は「Buzz」を出力する
- 3の倍数かつ5の倍数の場合は「FizzBuzz」を出力する

プログラムの実行結果は以下のようになることを確認してください。

```txt
$ cargo run
   Compiling fizzbuzz v0.1.0 (/home/r4ai/Projects/fizzbuzz)
    Finished dev [unoptimized + debuginfo] target(s) in 0.25s
     Running `target/debug/fizzbuzz`
1
2
Fizz
4
Buzz
Fizz
7
... (中略)
94
Buzz
Fizz
97
98
Fizz
Buzz
```

== 課題3: Rustでクイックソートを実装する

Rustのプログラミング言語を使用して、クイックソートを実装してください。

クイックソートは、与えられたいくつかの要素を、 所定の順序にしたがって並び替えるソートアルゴリズムです。 クイックソートには次の特徴があります (要素の個数を$N$とします)。

- 部分問題を再帰的に解くアルゴリズムである (分割統治法)
- 最悪時の計算量は$O(N^2)$
- 最良時と平均時の計算量は$O(N log N)$

以下に示すアルゴリズムは、 サイズ$N$の配列$A$を昇順に並び替えるクイックソートの動作を表したものです。

$A[X](X= floor(N/2))$を軸としてソートを行う。

1. 空の配列$L, R$を用意し、次の操作を$i=0,1, dots.h.c, N-1$について行う。
  1. $i=X$ならば何も行わない。
  2. $i!=X$かつ$A[i]<A[X]$ならば$A[i]$を$L$の末尾に追加する。
  3. $i!=X$かつ$A[i]>=A[X]$ならば$A[i]$を$R$の末尾に追加する。
2. $L, R$をクイックソートを用いて再帰的にソートする。空配列の場合は何も変わらない。
3. $L$の要素、$A[X], R$の要素をこの順につなげてできる配列を出力する。

参考文献：アルゴ式「Q.4 クイックソート」、https://algo-method.com/tasks/442

プログラムの実行結果は以下のようになることを確認してください。

```txt
$ cargo run
   Compiling quicksort v0.1.0 (/home/r4ai/Projects/quicksort)
    Finished dev [unoptimized + debuginfo] target(s) in 0.25s
     Running `target/debug/quicksort`
1
2
3
4
5
6
7
8
9
10
```

= アルゴリズム

== 課題1: Rustでハローワールドを出力する <sec:algorithm-helloworld>

以下に、ハローワールドを出力するアルゴリズムを示す。

1. 「Hello, World!」を出力する。

== 課題2: RustでFizzBuzzを実装する <sec:algorithm-fizzbuzz>

以下に、FizzBuzzを実装するアルゴリズムを示す。

1. $i=1,2,dots.h.c,100$について、次の操作を行う。
  1. $i$が3の倍数かつ5の倍数ならば「FizzBuzz」を出力する。
  2. $i$が3の倍数ならば「Fizz」を出力する。
  3. $i$が5の倍数ならば「Buzz」を出力する。
  4. いずれでもない場合は$i$を出力する。

== 課題3: Rustでクイックソートを実装する <sec:algorithm-quicksort>

以下に、クイックソートを実装するアルゴリズムを示す。

1. $A[X](X= floor(N/2))$を軸としてソートを行う。
2. 空の配列$L, R$を用意し、次の操作を$i=0,1, dots.h.c, N-1$について行う。
  1. $i=X$ならば何も行わない。
  2. $i!=X$かつ$A[i]<A[X]$ならば$A[i]$を$L$の末尾に追加する。
  3. $i!=X$かつ$A[i]>=A[X]$ならば$A[i]$を$R$の末尾に追加する。
3. $L, R$をクイックソートを用いて再帰的にソートする。空配列の場合は何も変わらない。
4. $L$の要素、$A[X], R$の要素をこの順につなげてできる配列を出力する。

= プログラム

== 課題1: Rustでハローワールドを出力する

@sec:algorithm-helloworld をRustで実装したプログラムを @code:hello-world に示す。

#code-info(
  caption: "helloworld.rs",
  label: "code:hello-world",
  show-line-numbers: true,
  start-line: 1,
)
```rs
fn main() {
    println!("Hello, World!");
}
```

== 課題2: RustでFizzBuzzを実装する

@sec:algorithm-fizzbuzz をRustで実装したプログラムを @code:fizzbuzz に示す。

#code-info(
  caption: "fizzbuzz.rs",
  label: "code:fizzbuzz",
  show-line-numbers: true,
  start-line: 1,
)
```rs
fn main() {
    for i in 1..=100 {
        if i % 15 == 0 {
            println!("FizzBuzz");
        } else if i % 3 == 0 {
            println!("Fizz");
        } else if i % 5 == 0 {
            println!("Buzz");
        } else {
            println!("{}", i);
        }
    }
}
```

== 課題3: Rustでクイックソートを実装する

@sec:algorithm-quicksort をRustで実装したプログラムを @code:quicksort に示す。

#code-info(
  caption: "quicksort.rs",
  label: "code:quicksort",
  show-line-numbers: true,
  start-line: 1,
)
```rs
fn quicksort<T: Ord + Copy>(a: &mut [T]) {
    if a.len() <= 1 {
        return;
    }

    let pivot = a.len() / 2;
    let mut l = Vec::new();
    let mut r = Vec::new();

    for i in 0..a.len() {
        if i == pivot {
            continue;
        }

        if a[i] < a[pivot] {
            l.push(a[i]);
        } else {
            r.push(a[i]);
        }
    }

    quicksort(&mut l);
    quicksort(&mut r);

    for i in 0..l.len() {
        a[i] = l[i];
    }
    a[l.len()] = a[pivot];
    for i in 0..r.len() {
        a[l.len() + 1 + i] = r[i];
    }
}

fn main() {
    let mut a = [6, 3, 8, 2, 9, 1, 4, 7, 5, 10];
    quicksort(&mut a);
    for i in 0..a.len() {
        println!("{}", a[i]);
    }
}
```

= 実行結果

== 課題1: Rustでハローワールドを出力する

@code:hello-world を実行した結果を @fig:hello-world-result に示す。

#figure(
  image("./imgs/result-helloworld.png"),
  caption: "helloworld.rsの実行結果",
) <fig:hello-world-result>

== 課題2: RustでFizzBuzzを実装する

@code:fizzbuzz を実行した結果を @fig:fizzbuzz-result に示す。なお、出力結果が長すぎるため、一部のみを抜粋している。

#figure(
  image("./imgs/result-fizzbuzz.png"),
  caption: "fizzbuzz.rsの実行結果",
) <fig:fizzbuzz-result>

== 課題3: Rustでクイックソートを実装する

@code:quicksort を実行した結果を @fig:quicksort-result に示す。

#figure(
  image("./imgs/result-quicksort.png"),
  caption: "quicksort.rsの実行結果",
) <fig:quicksort-result>

= 考察

== 課題1: Rustでハローワールドを出力する

Rustのプログラミング言語を使用して、コンソールに「Hello, World!」と出力するプログラムを作成した。

== 課題2: RustでFizzBuzzを実装する

Rustのプログラミング言語を使用して、1から100までの整数を順番に出力するプログラムを作成した。

== 課題3: Rustでクイックソートを実装する

Rustのプログラミング言語を使用して、クイックソートを実装した。クイックソートの計算量は、最悪時は @eq:quicksort-worst-order 、最良時と平均時は @eq:quicksort-avg-order である。

$ O(N^2) $ <eq:quicksort-worst-order>

$ O(N log N) $ <eq:quicksort-avg-order>

よって、クイックソートはバブルソートや挿入ソートと比較して、計算量が少ないアルゴリズムであると言える。また、クイックソートは並列化が容易であるため、並列計算に適しており、さらなる高速化が期待できる。

= おまけ

== 有名分布

=== 正規分布

$X$を確率変数、$mu in RR, sigma > 0$とする。$X$の確率密度関数が、

$ f(x) = 1/sqrt(2 pi sigma^2) exp[-(x-mu)^2/(2 sigma^2)] $

#let sim = math.class("relation", $tilde.op$)

となるとき、 $X$は平均$mu$、分散$sigma^2$の正規分布に従うといい、$X sim N(mu, sigma^2)$と表す。

==== 積率母関数の導出

$ E[e^(t X)] &= integral_(-oo)^(oo) e^(t x) f(x) space dif x \
  &= integral_(-oo)^(oo) e^(t x) 1/sqrt(2 pi sigma^2) exp[-(x-mu)^2/(2 sigma^2)] dif x \
  &= 1/sqrt(2 pi sigma^2) integral_(-oo)^(oo) exp[-(x-mu)^2/(2 sigma^2) + t x] dif x \
  &= 1/sqrt(2 pi sigma^2) integral_(-oo)^(oo) exp[-(x-mu)^2/(2 sigma^2) + t x] dif x \
  &= 1/sqrt(2 pi sigma^2) integral_(-oo)^(oo) exp[- {x-(mu + sigma^2 t)}^2/(2 sigma^2) + mu t + (sigma^2 t^2)/2] dif x \
  &= 1/sqrt(2 pi sigma^2) exp[mu t + (sigma^2 t^2)/2] integral_(-oo)^(oo) exp[- {x-(mu + sigma^2 t)}^2/(2 sigma^2)] dif x $

ここで、$display(y=(x-(mu + sigma^2 t))/(sqrt(2 sigma^2)))$とおくと、$display(dif y =  1/sqrt(2 sigma^2) dif x)$であり、

$ E[e^(t X)]
  &= 1/sqrt(2 pi sigma^2) exp[mu t + (sigma^2 t^2)/2] sqrt(2 sigma^2) integral_(-oo)^(oo) e^(-y^2) dif y \
  &= 1/sqrt(2 pi sigma^2) exp[mu t + (sigma^2 t^2)/2] sqrt(2 pi sigma^2) &(because integral_(-oo)^(oo) e^(-x^2) dif x = sqrt(pi)) \
  &= exp[mu t + (sigma^2 t^2)/2] $

を得る。

よって、正規分布の積率母関数は、

$ E[e^(t X)] = exp[mu t + (sigma^2 t^2)/2] $

である。

==== 期待値と分散の導出

積率母関数より、正規分布の期待値は、

$ E[X] &= lr(dif/(dif t) E[e^(t X)] |)_(t=0) \
       &= lr(dif/(dif t) exp[mu t + (sigma^2 t^2)/2] |)_(t=0) \
       &= (mu + sigma^2 t) exp lr([mu t + (sigma^2 t^2)/2] |)_(t=0) \
       &= mu $

である。

また、正規分布の2次積率は、

$ E[X^2] &= lr(dif^2/(dif t^2) E[e^(t X)] |)_(t=0) \
         &= dif/(dif t) (mu + sigma^2 t) exp lr([mu t + (sigma^2 t^2)/2] |)_(t=0) \
         &= sigma^2 exp [mu t + (sigma^2 t^2)/2] + (mu + sigma^2 t)^2 exp lr([mu t + (sigma^2 t^2)/2] |)_(t=0) \
         &= sigma^2 + mu^2 $

である。よって、正規分布の分散は、

$ V[X] &= E[X^2] - E[X^2] \
       &= sigma^2 + mu^2 - mu^2 \
       &= sigma^2 $

である。

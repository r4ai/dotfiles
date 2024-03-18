#import "@local/jsreport:0.1.1": report, code-info, callout, create-callout, callouts
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

以下に示すアルゴリズムは、 サイズ$N$の配列$A$を昇順に並び替えるクイックソートの動作を表したものです @quicksort-algorithm 。

$A[X](X= floor(N/2))$を軸としてソートを行う。

1. 空の配列$L, R$を用意し、次の操作を$i=0,1, dots.h.c, N-1$について行う。
  1. $i=X$ならば何も行わない。
  2. $i!=X$かつ$A[i]<A[X]$ならば$A[i]$を$L$の末尾に追加する。
  3. $i!=X$かつ$A[i]>=A[X]$ならば$A[i]$を$R$の末尾に追加する。
2. $L, R$をクイックソートを用いて再帰的にソートする。空配列の場合は何も変わらない。
3. $L$の要素、$A[X], R$の要素をこの順につなげてできる配列を出力する。

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
       &= mu $ <eq:moment-1>

である。

また、正規分布の2次積率は、

$ E[X^2] &= lr(dif^2/(dif t^2) E[e^(t X)] |)_(t=0) \
         &= dif/(dif t) (mu + sigma^2 t) exp lr([mu t + (sigma^2 t^2)/2] |)_(t=0) \
         &= sigma^2 exp [mu t + (sigma^2 t^2)/2] + (mu + sigma^2 t)^2 exp lr([mu t + (sigma^2 t^2)/2] |)_(t=0) \
         &= sigma^2 + mu^2 $ <eq:moment-2>

である。よって、 @eq:moment-1 と @eq:moment-2 より正規分布の分散は、

$ V[X] &= E[X^2] - E[X^2] \
       &= sigma^2 + mu^2 - mu^2 \
       &= sigma^2 $

である。

#pagebreak()

== Callout

=== デフォルト Callout

#callout("note")[
  これはノートです。
]

#callout("warning")[
  これは警告です。
]

#callout("quote")[
  これは引用です。
]

#callout("rocket")[
  これはロケットです。
]

#callout("todo")[
  これはTODOです。
]

#callout("unknown")[
  与えられた種類のCalloutが存在しない場合、noteとして扱われます。
]

タイトル付きCallout：

#callout("note", title: "コラム")[
  C言語は、1972年にAT&Tベル研究所で開発されたプログラミング言語である。
]

#callout("warning", title: [`Deno`の_*注意点*_])[
  Node.jsと完璧な互換性を持つわけではない。
]

=== カスタム Callout

#create-callout(
  "spark",
  (
    "Spark",
    image.decode("<svg width=\"15\" height=\"15\" viewBox=\"0 0 15 15\" fill=\"none\" xmlns=\"http://www.w3.org/2000/svg\"><path d=\"M8.69667 0.0403541C8.90859 0.131038 9.03106 0.354857 8.99316 0.582235L8.0902 6.00001H12.5C12.6893 6.00001 12.8625 6.10701 12.9472 6.27641C13.0319 6.4458 13.0136 6.6485 12.8999 6.80001L6.89997 14.8C6.76167 14.9844 6.51521 15.0503 6.30328 14.9597C6.09135 14.869 5.96888 14.6452 6.00678 14.4178L6.90974 9H2.49999C2.31061 9 2.13748 8.893 2.05278 8.72361C1.96809 8.55422 1.98636 8.35151 2.09999 8.2L8.09997 0.200038C8.23828 0.0156255 8.48474 -0.0503301 8.69667 0.0403541ZM3.49999 8.00001H7.49997C7.64695 8.00001 7.78648 8.06467 7.88148 8.17682C7.97648 8.28896 8.01733 8.43723 7.99317 8.5822L7.33027 12.5596L11.5 7.00001H7.49997C7.353 7.00001 7.21347 6.93534 7.11846 6.8232C7.02346 6.71105 6.98261 6.56279 7.00678 6.41781L7.66968 2.44042L3.49999 8.00001Z\" fill=\"currentColor\" fill-rule=\"evenodd\" clip-rule=\"evenodd\"></path></svg>")
  )
)

独自のCalloutも定義できます：

```typ
#import "@local/jsreport:0.1.0": callout, create-callout

#create-callout(
  "spark",
  (
    "Spark",
    image.decode("<svg width=\"15\" height=\"15\" viewBox=\"0 0 15 15\" fill=\"none\" xmlns=\"http://www.w3.org/2000/svg\"><path d=\"M8.69667 0.0403541C8.90859 0.131038 9.03106 0.354857 8.99316 0.582235L8.0902 6.00001H12.5C12.6893 6.00001 12.8625 6.10701 12.9472 6.27641C13.0319 6.4458 13.0136 6.6485 12.8999 6.80001L6.89997 14.8C6.76167 14.9844 6.51521 15.0503 6.30328 14.9597C6.09135 14.869 5.96888 14.6452 6.00678 14.4178L6.90974 9H2.49999C2.31061 9 2.13748 8.893 2.05278 8.72361C1.96809 8.55422 1.98636 8.35151 2.09999 8.2L8.09997 0.200038C8.23828 0.0156255 8.48474 -0.0503301 8.69667 0.0403541ZM3.49999 8.00001H7.49997C7.64695 8.00001 7.78648 8.06467 7.88148 8.17682C7.97648 8.28896 8.01733 8.43723 7.99317 8.5822L7.33027 12.5596L11.5 7.00001H7.49997C7.353 7.00001 7.21347 6.93534 7.11846 6.8232C7.02346 6.71105 6.98261 6.56279 7.00678 6.41781L7.66968 2.44042L3.49999 8.00001Z\" fill=\"currentColor\" fill-rule=\"evenodd\" clip-rule=\"evenodd\"></path></svg>")
  )
)

#callout("spark")[
  Sparking!!
]
```

#callout("spark")[
  Sparking!!
]

== 参考文献テスト

ハリーポッターと不死鳥の騎士団 @harry は、J・K・ローリングが2003年に発表した、小説『ハリーポッター』シリーズの第5巻である。

#lorem(40) @electronic

#set text(lang: "en")
#bibliography("reference.yaml", style: "ieee")

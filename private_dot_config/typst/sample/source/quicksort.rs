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

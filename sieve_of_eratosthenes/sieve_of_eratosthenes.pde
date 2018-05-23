int border = 5;
int curr_num = 1;
int curr_mul;
IntList range;
IntList multiples;
color[] colors = {color(255,0,0), // red
                  color(0,255,0), // green
                  color(0,0,255), // blue
                  color(0,255,255), // cyan
                  color(255,0,255), // magenta
                  color(255,255,0), // yellow
                  color(204,102,0), // brown
                  color(102,178,255), // light blue
                  color(178,102,255), // purple
                  color(204,255,153), // lime
                };
int curr_col = -1;
boolean had_unmarked_multiples = true;

IntList init_matrix(int n) {
  /** Creates a range from 1 to n (inclusive), and draws an empty matrix
  for that range. */
  range = new IntList();
  for (int i = 0; i < n; i += 1) {
    range.append(i + 1);
    fill(255, 255, 255);
    rect(border + (i % 10) * 50, border + (i / 10) * 50, 40, 40);
    fill(0, 0, 0);
    text(i + 1, border + 15 + (i % 10) * 50, border + 25 + (i / 10) * 50); 
  }
  return range;
}

IntList multiples_of(int n, int m) {
  /** Returns a list of multiples of n between 2*n and m (inclusive). */
  multiples = new IntList();
  for (int i = n * 2; i <= m; i += n) {
    multiples.append(i);
  }
  return multiples;
}

void setup() {
  size(500, 500);
  range = init_matrix(100);
  multiples = new IntList();
  textAlign(CENTER, CENTER);
}

void draw() {
  if (multiples.size() == 0 && !had_unmarked_multiples) {
    println(curr_num);
    int is_prime = range.remove(0);
    if (is_prime != 0) {
      strokeWeight(5);
      fill(255,255,255);
      rect(border + ((is_prime - 1) % 10) * 50, border + ((is_prime - 1) / 10) * 50, 40, 40);
      fill(0,0,0);
      text(is_prime, border + 20 + ((is_prime - 1) % 10) * 50, border + 20 + ((is_prime - 1) / 10) * 50);
    }
  } else if (multiples.size() == 0) {
    curr_num += 1;
    if (range.get(curr_num - 1) != 0) {
      curr_col += 1;
      multiples = multiples_of(curr_num, 100);
      had_unmarked_multiples = false;
      strokeWeight(5);
      stroke(colors[curr_col]);
      fill(255,255,255);
      rect(border + ((curr_num - 1) % 10) * 50, border + ((curr_num - 1) / 10) * 50, 40, 40);
      strokeWeight(1);
      stroke(0,0,0);
      fill(0,0,0);
      text(curr_num, border + 20 + ((curr_num - 1) % 10) * 50, border + 20 + ((curr_num - 1) / 10) * 50);
      //print(curr_num); print(" "); println(range.get(curr_num - 1));
      //println(range);
      //println(multiples);
    }
  } else {
    curr_mul = multiples.remove(0);
    if (range.get(curr_mul - 1) != 0) {
      had_unmarked_multiples = true;
    }
    //println(range.get(curr_mul - 1));
    fill(colors[curr_col]);
    rect(border + ((curr_mul - 1) % 10) * 50, border + ((curr_mul - 1) / 10) * 50, 40, 40);
    fill(0, 0, 0);
    text(curr_mul, border + 20 + ((curr_mul - 1) % 10) * 50, border + 20 + ((curr_mul - 1) / 10) * 50);
    range.set(curr_mul - 1, 0);
  }
  delay(100);
}

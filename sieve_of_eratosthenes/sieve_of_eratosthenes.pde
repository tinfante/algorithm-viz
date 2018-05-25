int border = 5;
color BLACK = color(0,0,0);
color WHITE = color(255,255,255);
color BG = color(127,127,127);
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

int N;
IntList range;
IntList multiples;
int curr_num;
int curr_mul;
int curr_col;
boolean has_unmarked_multiples;
boolean do_end_animation;
int pc;


IntList make_range(int n) {
  range = new IntList();
  for (int i = 0; i < n; i += 1) {
    range.append(i+1);
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


void draw_box(int num, color fill_color, color stroke_color, int stroke_weight) {
  strokeWeight(stroke_weight);
  stroke(stroke_color);
  fill(fill_color);
  rect(border + ((num % 10) * 50), border + ((num / 10) * 50), 40, 40);
  fill(BLACK);
  text(num + 1,
       (border + 20) + ((num % 10) * 50),
       (border + 20) + ((num / 10) * 50)); 
}


void draw_empty_matrix(int n) {
  for (int i = 0; i < n; i += 1) {
    draw_box(i, WHITE, BLACK, 1);
  }
}


void setup() {
  size(500,500);
  textAlign(CENTER, CENTER);
  background(BG);
  border = 5;
  N = 100;
  range = make_range(N);
  draw_empty_matrix(N);
  curr_num = 1;
  multiples = new IntList();
  curr_col = -1;
  has_unmarked_multiples = false;
  do_end_animation = false;
}

void draw() {
  if (do_end_animation) {
    if (range.size() != 0) {
      pc = range.remove(0);
      if (pc != 0) {
        if (pc != curr_num) {
          draw_box(pc - 1, WHITE, BLACK, 5);
        }
      }
    } else {
      do_end_animation = false;
      delay(3000);
      setup();
    }
    
  } else if (multiples.size() == 0) {
    curr_num += 1;
    if (range.get(curr_num-1) != 0) {
      curr_col += 1;
      multiples = multiples_of(curr_num, N);
      draw_box(curr_num - 1, WHITE, colors[curr_col], 5);
      has_unmarked_multiples = false;
      for (int i = 0; i < multiples.size(); i += 1) {
        if (range.get(multiples.get(i) -1) != 0) {
          has_unmarked_multiples = true;
        }
      }
      if (!has_unmarked_multiples) {
        do_end_animation = true;
      }
    }
  } else {
    curr_mul = multiples.remove(0);
    if (range.get(curr_mul - 1) != 0) {
      draw_box(curr_mul - 1, colors[curr_col], BLACK, 1);
      range.set(curr_mul - 1, 0);
    }
  }
  saveFrame("frames/####.tif");
  delay(200);
}

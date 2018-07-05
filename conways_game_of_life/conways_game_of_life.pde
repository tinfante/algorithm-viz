boolean [][] board;
boolean [][] next_board;
int H = 100;
int W = 100;

int fill_color = 0;
int nofill_color = 255;
int fill_with;

int [][] neighbours;

int [][] blinker = {{0,0}, {0,2}, {1,1}, {1,2},{2,1}};


void setup() {
  size(600,600);
  board = new boolean[H][W];
  board = empty_board(board);
  draw_board(board);
  create_shape(board, blinker, 50, 50);
}


boolean [][] empty_board(boolean b[][]) {
  for (int i=0; i<H; i++) {
    for (int j=0; j<W; j++) {
      b[i][j] = false;
    }}
  return b;
}


int [][] get_neighbours(int x, int y) {
  int [][] nbs = { {x-1, y-1}, {x-1, y}, {x-1, y+1},
                   {x,   y-1},           {x,   y+1},
                   {x+1, y-1}, {x+1, y}, {x+1, y+1} };
  return nbs;
}

void draw_board(boolean b[][]) {
  for (int i=0; i<H; i++) {
    for (int j=0; j<W; j++) {
      fill_with = (b[i][j] == true) ? fill_color: nofill_color;
      fill(fill_with);
      rect(i*6, j*6, 6, 6);
      }}}


void create_shape(boolean[][] b, int shape[][], int at_x, int at_y) {
  for (int p=0; p<shape.length; p++) {
    if (shape[p][0] + at_x < H && shape[p][1] + at_y < W) {
      b[shape[p][0] + at_x][shape[p][1] + at_y] = true;
    }}}


void draw() {
  draw_board(board);
}

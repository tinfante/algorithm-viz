boolean [][] board;
boolean [][] board_copy;
int H = 100;
int W = 100;

int fill_color = 0;
int nofill_color = 255;
int fill_with;

int [][] neighbours;
int count;
int nx;
int ny;

int [][] glider = {{0,0}, {0,2}, {1,1}, {1,2},{2,1}};
int [][] blinker = {{0,0}, {0,1}, {0,2}};

void setup() {
  size(600,600);
  board = new boolean[H][W];
  board = empty_board(board);
  draw_board(board);
  create_shape(board, glider, 50, 50);
  create_shape(board, blinker, 30, 70);
  board_copy = new boolean[H][W];
  neighbours = new int[8][2];
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
  delay(100);
  draw_board(board);
  for (int i=0; i<H; i++) {
    for (int j=0; j<W; j++) {
      if (board[i][j] == true) {
        board_copy[i][j] = true;
      } else {
        board_copy[i][j] = false;
      }}}
  for (int i=0; i<H; i++) {
    for (int j=0; j<W; j++) {
      neighbours = get_neighbours(i, j);
      count = 0;
      for (int n=0; n<8; n++) {
        nx = neighbours[n][0];
        ny = neighbours[n][1];
        if (nx >= 0 && nx < H && ny >= 0 && ny < W) {
          if (board_copy[nx][ny] == true) {
            count += 1;
          }}}
      if (count == 2) {
        board[i][j] = board_copy[i][j];
      } else if (count == 3) {
        board[i][j] = true;
      } else {
        board[i][j] = false;
      }}}}

boolean [][] board;
boolean [][] board_copy;
int H = 200;
int W = 100;

int fill_color = color(102,255,102);
int nofill_color = color(0,0,0);
int fill_with;

int [][] neighbours;
int count;
int nx;
int ny;

int [][] glider = {{0,0}, {0,2}, {1,1}, {1,2},{2,1}};
int [][] blinker = {{0,0}, {0,1}, {0,2}};

float randf;


void setup() {
  size(1200,600);
  board = new boolean[H][W];
  random_board(board);
  draw_board(board);
  board_copy = new boolean[H][W];
  neighbours = new int[8][2];
}

// Unused.
void empty_board(boolean b[][]) {
  for (int i=0; i<H; i++) {
    for (int j=0; j<W; j++) {
      b[i][j] = false;
      }}}
    
    
void random_board(boolean b[][]) {
  for (int i=0; i<H; i++) {
    for (int j=0; j<W; j++) {
      randf = random(1);
      if (randf > 0.995) {
        create_shape(b, glider, i, j);
      }
    }}}


void copy_board(boolean b[][], boolean bc[][]) {
  for (int i=0; i<H; i++) {
    for (int j=0; j<W; j++) {
      bc[i][j] = b[i][j];
      }}}


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


void update_board(boolean[][] b, boolean[][] bc) {
  for (int i=0; i<H; i++) {
    for (int j=0; j<W; j++) {
      neighbours = get_neighbours(i, j);
      count = 0;
      for (int n=0; n<neighbours.length; n++) {
        nx = neighbours[n][0];
        ny = neighbours[n][1];
        if (nx >= 0 && nx < H && ny >= 0 && ny < W) {
          if (bc[nx][ny] == true) {
            count += 1;
          }}}
      if (count == 2) {
        b[i][j] = bc[i][j];
      } else if (count == 3) {
        b[i][j] = true;
      } else {
        b[i][j] = false;
      }}}}


void draw() {
  draw_board(board);
  copy_board(board, board_copy);
  update_board(board, board_copy);
  delay(50);
}

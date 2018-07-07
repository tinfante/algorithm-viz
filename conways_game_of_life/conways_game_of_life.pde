boolean [][] board;
boolean [][] board_copy;
int H = 300;
int W = 150;
// So... I've got height and width flipped. Apparently, in Processing,
// indexing of a 2d array is done first by columns, then by rows???
// See: https://processing.org/tutorials/2darray/
int cell_size = 5;
int xpix = H * cell_size;
int ypix = W * cell_size;

int fill_color = color(102,255,102);
int nofill_color = color(0,0,0);
int fill_with;

int [][] neighbours;
int count;
int nx;
int ny;

int [][] blinker = {{0,0}, {0,1}, {0,2}};
int [][] glider = {{0,0},        {0,2}, 
                          {1,1}, {1,2},
                          {2,1}};

float randf;


void setup() {
  surface.setSize(xpix,ypix);
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
      if (randf > 0.98) {
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
      rect(i*cell_size, j*cell_size, cell_size, cell_size);
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
  //saveFrame("frames/####.png");
  delay(50);
}

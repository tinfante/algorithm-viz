boolean [][] world;
int H = 100;
int W = 100;

int [][] blinker = {{0,0}, {0,2}, {1,1}, {1,2},{2,1}};


void setup() {
  size(600,600);
  world = new boolean[H][W];
  for (int i=0; i<H; i++) {
    for (int j=0; j<W; j++) {
      world[i][j] = false;
      rect(i*6, j*6, 6, 6);
    }}
  create(blinker, 50, 50);
}

void create(int shape[][], int at_x, int at_y) {
  for (int p=0; p<shape.length; p++) {
    if (shape[p][0] + at_x < H && shape[p][1] + at_y < W) {
      world[shape[p][0] + at_x][shape[p][1] + at_y] = true;
    }}}

void draw() {
  for (int i=0; i<H; i++) {
    for (int j=0; j<W; j++) {
      if (world[i][j] == true) {
        fill(0);
      } else {
        fill(255);
      }
      rect(i*6, j*6, 6, 6);
    }}}

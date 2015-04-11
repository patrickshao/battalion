int xScreen = 1000;
int yScreen = 700;
Node[][] grid;
int xSize = 10;
int ySize = 10;
int nodeSize = 50;
int bxSize = xScreen/xSize;
int bySize = yScreen/ySize;

void setup() {
  size(xScreen,yScreen);
  makeGrid(xSize,ySize);
}

void draw(){
  
}

void makeGrid(int x,int y) {
  //Setup the nodes
  grid = new Node[x][y];
  for (int i = 0; i < x; i++) {
    for(int j = 0; j <y; j++) {
      grid[i][j] = new Node(i,j);
      ellipse(bxSize*(i+0.5),bySize*(j+0.5),50,50);
    }
  }
  
  //instantiate neighbors
  for (int i = 0; i < x; i++) {
    for (int j = 0; j < y; j++) {
      //Set up low/high parameters
      //Ensures we don't add nodes outside of grid
      int loX = max(i-1,0);
      int hiX = min(i+1,x-1);
      int loY = max(j-1,0);
      int hiY = min(j+1,y-1);
      
      //Loop through neighbors and add them
      for (int r = loX; r <= hiX; r++) {
        for (int c = loY; c <= hiY; c++) {
          //Make sure we are not adding self as a neighbor
          if (r != i && c != j ) {
            grid[i][j].addNeighbor(grid[r][c]);
          }
        }
      }
      
    }
  }
  
}

void mousePressed() {
  
}

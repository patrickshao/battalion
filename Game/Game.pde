int xScreen = 900;
int yScreen = 620;
int xField = 600;
int yField = 600;
int offset = 10;
Node[][] grid;
int xSize = 10;
int ySize = 10;
int bxSize = xField/xSize;
int bySize = yField/ySize;
int nodeSize = 45;
Node selected;
int prevX;
int prevY;
int currentPlayer = 1;

void setup() {
  size(xScreen,yScreen);
  makeGrid(xSize,ySize);
}

void draw(){
  background(150);
  fill(255);
  rect(offset,offset,xField,yField);
  drawGrid(xSize,ySize);
}

void makeGrid(int x,int y) {
  //Setup the nodes
  grid = new Node[x][y];
  for (int i = 0; i < x; i++) {
    for(int j = 0; j <y; j++) {
      grid[i][j] = new Node(i,j);
      //ellipse(bxSize*(i+0.5),bySize*(j+0.5),nodeSize,nodeSize);
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

void drawGrid(int x, int y) {
  for (int i = 0; i < x; i++) {
    for(int j = 0; j <y; j++) {
      fill(255);
      stroke(0);
      //If the node is selected, highlight it
      if (selected != null && grid[x][y]==selected) {
        stroke(255,255,0);
      }
      ellipse(bxSize*(i+0.5)+offset,bySize*(j+0.5)+offset,nodeSize,nodeSize);
    }
  }
}

/*
 * Draws the GUI on the side, 
 * 
 */
void drawGUI() {
}

void mousePressed() {
  int x = mouseX/bxSize;
  int y = mouseY/bySize;
  //If click outside grid bounds, do nothing
  if (mouseX <= offset || mouseX >= xField+offset || mouseY <= offset || mouseY >= yField+offset) {
    return;
  }
  //only select if not selected already and the node is owned by player
  if (selected == null && grid[x][y].getPlayer() == currentPlayer) {
    selected = grid[x][y];
    //if there is a selected node
  } else if (selected != null) {
    //checks if the currently selected node is not a player
    selected.move(grid[x][y],selected.getAmount());
    //Add a line to clear up the selected node
  }
}

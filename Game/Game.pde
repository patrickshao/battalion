PImage bgImage;
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
int nodeSize = (int)(bxSize*(.90));
Node selected;
int prevX;
int prevY;
int currentPlayer = 1;
boolean isStart = true;
int numStartPos = 3;
int currAdded = 0;

color p1C = color(255,0,0);
color p2C = color(0,0,255);

void setup() {
  bgImage = loadImage("images/background.jpg");
  size(xScreen,yScreen);
  makeGrid(xSize,ySize);
}

void draw(){
  background(150);
  image(bgImage,0,0);
  noFill();
  noStroke();
  rect(offset,offset,xField,yField);
  drawGrid(xSize,ySize);
  drawGUI();
}

void makeGrid(int x,int y) {
  //Setup the nodes
  grid = new Node[x][y];
  for (int i = 0; i < x; i++) {
    for(int j = 0; j <y; j++) {
      grid[i][j] = new Node(i,j);
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
  int pOwner;
  int unitVal;
  ArrayList<Node> nList;
  for (int i = 0; i < x; i++) {
    for(int j = 0; j <y; j++) {
      //default color settings
      fill(255);
      stroke(0);
      
      //If the node is selected, highlight it
      if (selected != null && grid[i][j].equals(selected)) {
        stroke(255,255,0);
      }
      
      //Check for color change
      pOwner = grid[i][j].getPlayer();
      if (pOwner == 1) {
        fill(p1C);
      } else if (pOwner ==2) {
        fill(p2C);
      }
      
      //Draw a connection
      nList = grid[i][j].getNeighbor
      fill(0,255,0);
      
      //Draw the nodes
      ellipse(bxSize*(i+0.5)+offset,bySize*(j+0.5)+offset,nodeSize,nodeSize);
      
      //Draw the unit numbers
      fill(0);
      unitVal = grid[i][j].getAmount();
      //Only draw units if higher than 0 (non-empty node)
      if (unitVal > 0) {
        textSize(20);
        textAlign(CENTER);
        text(unitVal,i*bxSize+(bxSize/2)+offset, j*bySize+(bySize/2)+offset);
      }
    }
  }
}

/*
 * Draws the GUI on the side, 
 * 
 */
void drawGUI() {
  //Calculate location of where to place the text
  int xGUIStart = xField+2*offset;
  int yGUIStart = offset;
  int xShift = (xScreen - xGUIStart)/2;
  
  int textS = 32;
  if (currentPlayer == 1) {
    fill(p1C);
  }
  else {
    fill(p2C);
  }
  textSize(textS);
  textAlign(CENTER);
  text("Player "+ currentPlayer+"'s Turn",xGUIStart+xShift, yGUIStart+textS);
}

void mousePressed() {
  int x = mouseX/bxSize;
  int y = mouseY/bySize;
  if (!isStart) {
    //If click outside grid bounds, do nothing
    if (mouseX <= offset || mouseX >= xField+offset || mouseY <= offset || mouseY >= yField+offset) {
      return;
    }
    //only select if not selected already and the node is owned by player
    if (selected == null && grid[x][y].getPlayer() == currentPlayer) {
      int mx = (mouseX-10)%bxSize;
      int my = (mouseY-10)%bySize;
      float dist = sqrt(pow(bxSize/2-mx,2)+pow(bySize/2-my,2));
      if (dist <= nodeSize/2) {
        selected = grid[x][y];
      }
    //if there is a selected node
    } else if (selected != null) {
      if (selected.isConnected(grid[x][y])) {
        selected.move(grid[x][y],selected.getAmount());
        System.out.println("move");
        switchPlayer();
                
      } else {
        selected.addConnected(grid[x][y]);
        grid[x][y].addConnected(selected);
        System.out.println("add Connection");
        switchPlayer();
      }
      //Add a line to clear up the selected node
    } 
  }
    //the setup phase.
    else {
        grid[x][y].setPlayer(currentPlayer);
        grid[x][y].setAmount(1);
        currAdded++;
        currentPlayer = currentPlayer%2+1;
      if (currAdded >= numStartPos*2) {
        isStart = false;
      }
    }
  
}

void switchPlayer() {
  currentPlayer = currentPlayer%2+1;
  for(int i = 0; i<xSize; i++) {
    for(int j = 0; j<ySize; j++) {
      if(grid[i][j].getPlayer() != 0) {
        grid[i][j].setAmount(grid[i][j].getAmount()+1);
      }    
    }
  }
  selected = null;
}

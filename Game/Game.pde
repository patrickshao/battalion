//Text input implementation inside game was obtained from Daniel Shiffman,http://www.learningprocessing.com  Example 18-1: User input

PImage bgImage;
PImage uImage;
int xScreen = 900;
int yScreen = 620;
int xField = 600;
int yField = 600;
int offset = 10;
Node[][] grid;
int xSize = 5;
int ySize = 5;
int bxSize = xField/xSize;
int bySize = yField/ySize;
int nodeSize = (int)(bxSize*(.80));
Node selected;
int prevX;
int prevY;
int currentPlayer = 1;
boolean isStart = true;
int numStartPos = 3;
int currAdded = 0;

import static javax.swing.JOptionPane.*;

String saved = "";

//Some GUI stuff
int xGUIStart = xField+2*offset;
int yGUIStart = offset;
int xShift = (xScreen - xGUIStart)/2;

color p1C = color(255,0,0);
color p2C = color(0,0,255);

void setup() {
  bgImage = loadImage("images/background.jpg");
  size(xScreen,yScreen);
  makeGrid(xSize,ySize);
}

void draw(){
  background(150);
  imageMode(CORNER);
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
  float iCenter;
  float jCenter;
  ArrayList<Node> nList;
  for (int i = 0; i < x; i++) {
    for(int j = 0; j <y; j++) {
      //Some variables to save calculations
      iCenter = i*bxSize+(bxSize/2)+offset;
      jCenter = j*bySize+(bySize/2)+offset;
      
      //default color settings
      fill(255);
      stroke(0);
      strokeWeight(1);
      
      //Check for color change
      pOwner = grid[i][j].getPlayer();
      if (pOwner == 1) {
        fill(p1C);
      } else if (pOwner ==2) {
        fill(p2C);
      }
      
      //Draw connections
      nList = grid[i][j].getConnected();
      stroke(0,180,0);
      for (Node n: nList) {
        float in = n.getX();
        float jn = n.getY();
        //Avoid redrawing connections
        if ((in <= i && jn <= j) || (in < i && jn > j)) {
          continue;
        }
        float iNeighb = in*bxSize+(bxSize/2)+offset;
        float jNeighb = jn*bySize+(bySize/2)+offset;
        strokeWeight(10);
        line(iCenter,jCenter,iNeighb,jNeighb);
      }
      
      //Outlines for Nodes
      strokeWeight(1);
      stroke(0);     
      //If the node has been highlighted, highlight it
      if (pOwner == currentPlayer && !isStart) {
        stroke(0,255,0);
        strokeWeight(3);
      }
      if (selected != null && grid[i][j].equals(selected)) {
        stroke(255,255,0);
        strokeWeight(5);
      }
      
      //Draw the nodes
      ellipse(bxSize*(i+0.5)+offset,bySize*(j+0.5)+offset,nodeSize,nodeSize);
      
      //Apply sprites
      drawSprite(grid[i][j].getType(),iCenter,jCenter);
      
      //Draw the unit numbers
      unitVal = grid[i][j].getAmount();
      //Only draw units if higher than 0 (non-empty node)
      if (unitVal > 0) {
        fill(255);
        textSize(nodeSize/4);
        textAlign(CENTER);
        text(unitVal,iCenter+nodeSize/4,jCenter+nodeSize/4);
      }
    }
  }
}

void drawSprite(char t, float x, float y) {
  imageMode(CENTER);
  if (t == 'r') {
    uImage = loadImage("images/heavy.png");
  } else if (t == 'p') {
    uImage = loadImage("images/archer.png");
  } else if (t == 's') {
    uImage = loadImage("images/light.png");
  } else {
    return; //Else do not draw a sprite
  }
  image(uImage,x,y);
}

/*
 * Draws the GUI on the side, 
 * 
 */
void drawGUI() {
  fill(255);
  rect(xGUIStart+xShift, yGUIStart+40,240,50);
  int textS = 32;
  if (currentPlayer == 1) {
    fill(p1C);
  }
  else {
    fill(p2C);
  }
  textSize(textS);
  textAlign(CENTER);
  text("Player "+ currentPlayer+"'s Turn",xGUIStart+xShift, yGUIStart+textS+20);
  fill(200);
  rectMode(CENTER);
  rect(xGUIStart+(xScreen-xGUIStart)/2,yGUIStart+yScreen/2,160,35);
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


void mousePressed() {
  int x = mouseX/bxSize;
  int y = mouseY/bySize;
  //If click outside grid bounds, do nothing
    if (mouseX <= offset || mouseX >= xField+offset || mouseY <= offset || mouseY >= yField+offset) {
      return;
    }
  if (!isStart) {
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
      int maxAmount = selected.getAmount();
      int sendAmount = maxAmount;
      if (selected.isConnected(grid[x][y])) {
        saved = showInputDialog("Please enter unit amount to move. (Default move all units).");
        if (saved == null) {
          exit();
        } else if (saved == "") {
        } else if (!saved.matches("[0-9]+$")) {
           showMessageDialog(null, "Invalid Number, sending default unit amount.", 
          "Alert", ERROR_MESSAGE);
          selected.move(grid[x][y],grid[x][y].getAmount());
        } else {
          if (Integer.parseInt(saved) > maxAmount) {
            showMessageDialog(null, "Number too high, sending default unit amount.", 
            "Alert", ERROR_MESSAGE);
          } else {
            sendAmount = Integer.parseInt(saved);
          }
        }
        selected.move(grid[x][y],sendAmount);
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
        if (currAdded == 0|| currAdded == 1) {
          grid[x][y].setType('r');                    
        } else if (currAdded == 2 || currAdded ==3) {
          grid[x][y].setType('p');
        } else {
          grid[x][y].setType('s');
        }
        currAdded++;
        currentPlayer = currentPlayer%2+1;
      if (currAdded >= numStartPos*2) {
        isStart = false;
      }
    }
  
}

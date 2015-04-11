class Node{
  
  ArrayList<Node> neighbors;
  ArrayList<Node> connected;
  //0 is uncontrolled, 1 is player 1, 2 is player 2
  int controllingPlayer;
  int rocks, papers, scissors;
  int x, y;
  
  public Node(int x, int y){
    this.x=x;
    this.y=y;
    rocks=0;
    papers=0;
    scissors=0;
    connected=new ArrayList<Node>(0);
    neighbors=new ArrayList<Node>(0);
    int controllingPlayer=0;
  }
    
}

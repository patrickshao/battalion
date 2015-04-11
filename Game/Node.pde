class Node{
  
  private ArrayList<Node> neighbors;
  private ArrayList<Node> connected;
  //0 is uncontrolled, 1 is player 1, 2 is player 2
  private int controllingPlayer;
  private char type;
  private int amount;
  private int x, y;
  
  public Node(int x, int y){
    this.x=x;
    this.y=y;
    amount=0;
    type = '';
    connected=new ArrayList<Node>(0);
    neighbors=new ArrayList<Node>(0);
    int controllingPlayer=0;
  }
  
  public void setPlayer(int i){
    controllingPlayer=i;
  }
  
  public void addNeighbor(Node n){
    neighbors.add(n);
  }
  
  public void addConnected(Node n){
    connected.add(n);
  }
  
  public boolean isNeighbor(Node n){
    if (neighbors.contains(n)){return true};
    return false;
  }
  
  public boolean isConnected(Node n){
    if (connected.contains(n)){return true};
    return false;
  
  public void setAmount(int i){
    amount=i;
  }
  
  public int getAmount(){
    return amount;
  }
  
  public void setType(char c){
    type = c;
  }
  
  public char getType(){
    return type;
  }
  
  public int getPlayer(){
    return controllingPlayer;
  }
  
  public void setPlayer(int p){
    controllingPlayer=p;
  }
  
  public void move(Node target, int moving){
    if(connected.contains(target)){
      if(moving<=amount){
        if(target.getPlayer()==0){
        target.setPlayer(controllingPlayer);
        target.setType(type);
        target.setAmount(moving);
        amount-=moving;
        }
        else if(target.getPlayer()==controllingPlayer){
          if(target.getType()==type){
            target.setAmount(target.getAmount()+moving);
            amount-=moving;
          }
          else{
            println("Move blocked");
          }
        }
        else{
          //attack(target, moving);
        }
      }
      else{
        println("Illegal amount");
      }
    }
    else{
      println("Target not connected");
    }
  }
  
//  public void attack(Node n, int amount){
//    opponent=
//  
//  }
    
}

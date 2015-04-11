class Node{
  
  private ArrayList<Node> neighbors;
  private ArrayList<Node> connected;
  //0 is uncontrolled, 1 is player 1, 2 is player 2
  private int controllingPlayer;
  private int r, p, s;
  private int x, y;
  
  public Node(int x, int y){
    this.x=x;
    this.y=y;
    r=0;
    p=0;
    s=0;
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
  
  public void addR(int i){
    r+=i;
  }
  
  public void addS(int i){
    s+=i;
  }
  
  public void addP(int i){
    p+=i;
  }
  
  public void setR(int i){
    r=i;
  }
  
  public void setS(int i){
    s=i;
  }
  
  public void setP(int i){
    p=i;
  }
  
  public int getR(){
    return r;
  }
  
  public int getS(){
    return s;
  }
  
  public int getP(){
    return p;
  }
  
  public int getPlayer(){
    return controllingPlayer;
  }
  
  public void attack(Node n){
    
  
  }
    
}

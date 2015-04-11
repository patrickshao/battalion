class DialogBox{
  // Learning Processing
  // Daniel Shiffman
  // http://www.learningprocessing.com
  
  // Example 18-1: User input
  
  PFont f= createFont("Arial",16,true);;
  
  // Variable to store text currently being typed
  String typing = "";
  
  // Variable to store saved text when return is hit
  String saved = "";
  
  int x,y,w,l;
  boolean isActive;
  
  public DialogBox(int x,int y,int w,int l){
    this.x=x;
    this.y=y;
    this.l=l;
    this.w=w;
  }
  
  //instructions for draw, taken from the internet.
  void drawBox() {
    fill(150);
    rect(this.x,this.y,this.l,this.w);
    int indent = 25;
    
    // Set the font and fill for text
    textFont(f);
    fill(0);
    
    // Display everything
    text(typing,indent,90);
    text(saved,indent,130);
  }
  
  public boolean isActive(){
    return isActive();
  }
  
  public void toggleActive(){
    isActive = !isActive;
  }
  
  String getSaved(){
    return saved;
  }
    
}

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
//  void draw() {
//    background(255);
//    int indent = 25;
//    
//    // Set the font and fill for text
//    textFont(f);
//    fill(0);
//    
//    // Display everything
//    text("Click in this applet and type. \nHit return to save what you typed. ", indent, 40);
//    text(typing,indent,90);
//    text(saved,indent,130);
//  }
  
  //move this part of keypressed into game. Make a dialog box called db.
  void keyPressed() {
    if db.isActive(){
      // If the return key is pressed, save the String and clear it
      if (key == '\n' ) {
        saved = typing;
        // A String can be cleared by setting it equal to ""
        typing = ""; 
      } else {
        // Otherwise, concatenate the String
        // Each character typed by the user is added to the end of the String variable.
        typing = typing + key; 
      }
    }
  }
  
  String getSaved(){
    return saved;
  }
    
}

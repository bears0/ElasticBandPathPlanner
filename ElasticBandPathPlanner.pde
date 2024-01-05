PVector rectStart = new PVector();
PVector rectEnd = new PVector();

PVector pathStart = new PVector();
PVector pathEnd = new PVector();
boolean firstPointPlaced = false;
boolean lastPointPlaced = false;
Path path;
boolean pathReady = false;
boolean showPreview = false;

ArrayList<Rectangle> rects = new ArrayList<Rectangle>();

void setup(){
  size(800,800);
  frameRate(60);
}

void draw(){
  background(51);
  
  for(int i = 0; i < rects.size(); i++){
    rects.get(i).show();
  }
  
  if(showPreview){
    fill(200);
    stroke(0);
    strokeWeight(0);
    rect(rectStart.x, rectStart.y, rectEnd.x, rectEnd.y);
  }
  
  drawStartEndPoints();
  if(pathReady){
    path.showBubbles();
  }
}

void mousePressed(){
  if(mouseButton == RIGHT){
    rectStart.x = mouseX;
    rectStart.y = mouseY;
    rectEnd.x = mouseX-rectStart.x;
    rectEnd.y = mouseY-rectStart.y;
    showPreview = true;
  }
  if(mouseButton == LEFT){
    if(!firstPointPlaced){
      pathStart = new PVector(mouseX, mouseY);
      firstPointPlaced = true;
    } else if (!lastPointPlaced){
      pathEnd = new PVector(mouseX, mouseY);
      lastPointPlaced = true;
      path = new Path(pathStart, pathEnd, 10, 20);
      pathReady = true;
    } else {
      pathStart = new PVector(0,0);
      pathEnd = new PVector(0,0);
      firstPointPlaced = false;
      lastPointPlaced = false;
      pathReady = false;
    }
  }
}

void mouseDragged(){
  rectEnd.x = mouseX-rectStart.x;
  rectEnd.y = mouseY-rectStart.y;
}

void mouseReleased(){
  if(mouseButton == RIGHT){
    rectEnd.x = mouseX-rectStart.x;
    rectEnd.y = mouseY-rectStart.y;
    rects.add(new Rectangle(rectStart, rectEnd));
    rectEnd.x = 0;
    rectEnd.y = 0;
    showPreview = false;
  }
}

void drawStartEndPoints(){
  if(firstPointPlaced){
    fill(0,255,0);
    stroke(0);
    strokeWeight(3);
    ellipse(pathStart.x, pathStart.y, 15, 15);
  }
  if(lastPointPlaced){
    fill(255,0,0);
    stroke(0);
    strokeWeight(3);
    ellipse(pathEnd.x, pathEnd.y, 15, 15);
  }
}

void keyPressed(){
  if(key == ' '){
    rects.clear();
  }
}

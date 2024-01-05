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
Grid grid = new Grid();

void setup(){
  size(800,800);
  frameRate(60);
}

void draw(){
  background(51);
  
  if(showPreview){
    fill(200);
    stroke(0);
    strokeWeight(0);
    rect(rectStart.x, rectStart.y, rectEnd.x, rectEnd.y);
  }

  grid.show();

  for(int i = 0; i < rects.size(); i++){
    rects.get(i).show();
  }
  
  drawStartEndPoints();
  if(pathReady){
    path.showBubbles();
  }

  PVector pvTemp = grid.getClosestObstacle(mouseX/10, mouseY/10); // Coordinates of closest obstacle in pixels
  PVector pv = new PVector(pvTemp.x, pvTemp.y); // Coordinates of closest obstacle in pixels
  PVector mv = new PVector(mouseX, mouseY);
  PVector dist = pvTemp.sub(mv);
  float d = max(dist.mag()-5,1); // Subtract 5 to get the distance from the edge of the obstacle
  println(pv.x);
  if(pv.x > -1){
    //println(d);
    ellipse(mouseX, mouseY, d*2, d*2);
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
    grid.addRect((int)rectStart.x/10, (int)rectStart.y/10, mouseX/10, mouseY/10);
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
    grid.clear();
  }
}

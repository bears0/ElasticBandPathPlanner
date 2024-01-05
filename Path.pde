class Path {
  ArrayList<Bubble> bubbles = new ArrayList<Bubble>();
  PVector start;
  PVector end;
  float startLength = 0;
  float spacing = 10;
  float bubbleSize = 10;
  
  Path(PVector start, PVector end, float spacing, float bubbleSize){
    this.start = new PVector(start.x, start.y);
    this.end = new PVector(end.x, end.y);
    this.spacing = spacing;
    this.bubbleSize = bubbleSize;
    
    generateBubbles();
  }
  
  void generateBubbles(){
    float rise = end.y - start.y;
    float run = end.x - start.x;
    
    PVector p = end.sub(start); // Get the vector from start to end
    startLength = p.mag(); // Get the length of the initial line.
    int count = (int)(startLength / spacing); // number of bubbles
    println(count);
    float d = startLength / count; // the spacing between bubbles
    println(d);
    for(int i = 0; i < (int)count+1; i++){
      println(run/count);
      Bubble b = new Bubble(new PVector(start.x+(i*(run/count)), start.y+(i*rise/count)), bubbleSize);
      bubbles.add(b);
    }
  }
  
  void showBubbles(){
    for(int i = 0; i < bubbles.size(); i++){
      bubbles.get(i).show();
    }
  }
}

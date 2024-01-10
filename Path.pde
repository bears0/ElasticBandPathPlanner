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
    
    //generateBubbles();
  }
  
  void generateBubbles(ArrayList<Coord> route){
    
    for(int i = 0; i < route.size(); i++){
      PVector pos = new PVector(route.get(i).x*10+5, route.get(i).y*10+5);
      bubbles.add(new Bubble(new PVector(pos.x, pos.y), bubbleSize));
    }
  }
  
  void shrink(Grid grid){
    float kt = 0.1; // Tension force factor
    float kr = 0.07;
    int steps = 5;
    for(int step = 0; step < steps; step++){
      // Remove or add bubbles
      for(int i = 1; i < bubbles.size()-1; i++){
        PVector bm1 = bubbles.get(i-1).pos.copy();
        PVector b = bubbles.get(i).pos.copy();
        PVector bp1 = bubbles.get(i+1).pos.copy();
        float d1 = b.copy().sub(bm1).mag();
        float d2 = b.copy().sub(bp1).mag();
        print(d1);
        print(", ");
        println(d2);
        if(d1+d2 < 25){
          bubbles.remove(i);
        }
      }
      
      // Calculate repulsion force
      for(int i = 1; i < bubbles.size()-1; i++){
        PVector pos = bubbles.get(i).pos.copy();
        PVector closestObstacle = grid.getClosestObstacle((int)pos.x/10, (int)pos.y/10);
        PVector awayFromObstacle = pos.copy().sub(closestObstacle).mult(1);
        float m = awayFromObstacle.copy().mag();
        if(m < 60){
          bubbles.get(i).d = m*2;
          bubbles.get(i).setRepulsionForce(awayFromObstacle.copy().mult(min(60,(60-m)/m)*kr));
          //println(bubbles.get(i).repulsionForce);
        } else {
          bubbles.get(i).d = 120;
          bubbles.get(i).setRepulsionForce(new PVector(0,0));
        }
      }
      
      // calculate tension force
      for(int i = 1; i < bubbles.size()-1; i++){
        // Get unit vector in direction of previous bubble.
        PVector bm1 = bubbles.get(i-1).pos.copy();
        PVector b = bubbles.get(i).pos.copy();
        PVector bp1 = bubbles.get(i+1).pos.copy();
        PVector uv1 = bm1.sub(b);//.normalize();
        PVector uv2 = bp1.sub(b);//.normalize();
        PVector d = uv1.add(uv2).copy();
        PVector force = d.mult(kt).copy();
        //println("uv1: " + uv1 + " uv2: " + uv2 + " force: " + force);
        bubbles.get(i).setTensionForce(force);
      }
      
      // Apply tension force
      for(int i = 1; i < bubbles.size()-1; i++){
        PVector tensionForce = bubbles.get(i).tensionForce.copy();
        PVector repulsionForce = bubbles.get(i).repulsionForce.copy();
        PVector totalForce = tensionForce.add(repulsionForce);
        bubbles.get(i).pos.add(totalForce);
      }
    }
  }
  
  void showBubbles(){
    stroke(255);
    strokeWeight(1);
    for(int i = 0; i < bubbles.size(); i++){
      bubbles.get(i).show();
    }
    stroke(0,0,255);
    strokeWeight(4);
    for(int i = 0; i < bubbles.size()-1; i++){
      line(bubbles.get(i).pos.x, bubbles.get(i).pos.y, bubbles.get(i+1).pos.x, bubbles.get(i+1).pos.y);
    }
  }
}

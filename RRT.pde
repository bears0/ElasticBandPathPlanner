class RRT {
  Coord start, end = new Coord(0,0);
  int numIterations = 10;
  Tree tree = new Tree();
  boolean complete = false;
  ArrayList<Coord> route = new ArrayList<Coord>();
  ArrayList<Integer> octants = new ArrayList<Integer>();
  int[] octantCount = new int[8];
  
  RRT(Coord startPoint, Coord endPoint, int k){
    this.start = startPoint;
    this.end = endPoint;
    this.numIterations = k;
    tree.addVertice(start);
  }
  
  void show(){
    tree.show();
    stroke(0,255,0);
    strokeWeight(3);
    for(int i = 0; i < route.size()-1; i++){
      line(route.get(i).x*10+5, route.get(i).y*10+5, route.get(i+1).x*10+5, route.get(i+1).y*10+5);
    }
  }
  
  void showRoute(){
    stroke(0,255,0);
    strokeWeight(3);
    for(int i = 0; i < route.size()-1; i++){
      line(route.get(i).x*10+5, route.get(i).y*10+5, route.get(i+1).x*10+5, route.get(i+1).y*10+5);
    }
  }
  
  void generateTree(Grid g){
    int startTime = millis();
    for(int i = 0; i < numIterations; i++){
      Coord q_rand = new Coord((int)random(0, 79), (int)random(0,79));
      Coord q_near = nearestVertex(q_rand);
      Coord q_new = newPoint(q_near, q_rand);
      //q_near = nearestVertex(q_new);
      if(!tree.exists(q_new) && g.grid[q_new.x][q_new.y] != 1){
        tree.addVertice(q_near, q_new);
        tree.addLine(q_near, q_new);
        if(end.dist(q_new) < 2){
          complete = true;
          //tree.addVertice(q_new, new Coord(end.x, end.y)); // Add the goal position and it's parent node, q_new.
          //tree.addLine(q_new, new Coord(end.x, end.y));
          println("Route found in " + i + " iterations!");
          break;
        }
      } else {
        i-=1;
        //println("Space occupied");
      }
    }
    int endTime = millis();
    println("RRT generated in " + (endTime-startTime) + " ms!");
    for(int i = 0; i < octants.size(); i++){
      octantCount[octants.get(i)]++;
    }
    //println(octantCount);
    octantCount = new int[8];
  }
  
  void createRoute(Coord goal){
    route.add(end);
    backtrack(goal);
    println("Total number of points in the path: " + route.size());
  }
  
  void backtrack(Coord goal){
    if(goal.x == tree.getStartX() && goal.y == tree.getStartY()){
      route.add(goal);
      return;
    }
    route.add(goal);
    backtrack(goal.parent);
  }
  
  void reset(){
    tree.reset();
    tree.addVertice(start);
    route.clear();
    complete = false;
  }
  
  void setStartPoint(Coord start){
    this.start = start;
  }
  
  void setEndPoint(Coord end){
    this.end = end;
  }
  
  Coord nearestVertex(Coord q_rand){
    Coord nearest = new Coord(0,0);
    float maxDist = MAX_FLOAT;
    float dist;
    for(int i = 0; i < tree.getSize(); i++){
      dist = tree.getVertice(i).dist(q_rand);
      if(dist < maxDist){
        maxDist = dist;
        nearest = tree.getVertice(i);
      }
    }
    //println(nearest);
    return nearest;
  }
  
  Coord newPoint(Coord q_near, Coord q_rand){
    float dy = q_rand.y - q_near.y;
    float dx = q_rand.x - q_near.x;
    int octant = 0;
    float angle = atan2(dy,dx);
    if(angle < 0){
      angle += 2*PI; // Value from 0 - 360 degrees
    }
    
    angle *= (180/PI);
    
    if(angle >= 0 && angle < 22.5){
      octant = 0;
    } else if (angle >= 22.5 && angle < 67.5){
      octant = 1;
    } else if (angle >= 67.5 && angle < 112.5){
      octant = 2;
    } else if (angle >= 112.5 && angle < 157.5){
      octant = 3;
    } else if (angle >= 157.5 && angle < 202.5){
      octant = 4;
    } else if (angle >= 202.5 && angle < 247.5){
      octant = 5;
    } else if (angle >= 247.5 && angle < 292.5){
      octant = 6;
    } else if (angle >= 292.5 && angle < 337.5){
      octant = 7;
    } else {
      octant = 0;
    }
    
    octants.add(octant);
    switch(octant){
      case 0:
        return new Coord(q_near.x+1, q_near.y);
      case 1:
        return new Coord(q_near.x+1, q_near.y+1);
      case 2:
        return new Coord(q_near.x, q_near.y+1);
      case 3:
        return new Coord(q_near.x-1, q_near.y+1);
      case 4:
        return new Coord(q_near.x-1, q_near.y);
      case 5:
        return new Coord(q_near.x-1, q_near.y-1);
      case 6:
        return new Coord(q_near.x, q_near.y-1);
      case 7:
        return new Coord(q_near.x+1, q_near.y-1);
      default:
        return new Coord(q_near.x, q_near.y);
    }
    
  }
  
}

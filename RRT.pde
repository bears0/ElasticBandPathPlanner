class RRT {
  Coord start = new Coord(0,0);
  int numIterations = 10;
  Tree tree = new Tree();
  
  ArrayList<Integer> octants = new ArrayList<Integer>();
  int[] octantCount = new int[8];
  
  RRT(Coord startPoint, int k){
    this.start = startPoint;
    this.numIterations = k;
    tree.addVertice(start);
  }
  
  void show(){
    tree.show();
  }
  
  void generateTree(Grid g){
    int startTime = millis();
    for(int i = 0; i < numIterations; i++){
      Coord q_rand = new Coord((int)random(0, 79), (int)random(0,79));
      Coord q_near = nearestVertex(q_rand);
      Coord q_new = newPoint(q_near, q_rand);
      //q_near = nearestVertex(q_new);
      if(!tree.exists(q_new) && g.grid[q_new.x][q_new.y] != 1){
        tree.addVertice(q_new);
        tree.addLine(q_near, q_new);
      } else {
        i-=1;
        println("Space occupied");
      }
    }
    int endTime = millis();
    println(endTime - startTime);
    for(int i = 0; i < octants.size(); i++){
      octantCount[octants.get(i)]++;
    }
    println(octantCount);
    octantCount = new int[8];
  }
  
  void reset(){
    tree.reset();
    tree.addVertice(start);
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

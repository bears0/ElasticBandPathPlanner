class Tree {
  ArrayList<Coord> verts = new ArrayList<Coord>();
  ArrayList<Coord> leftover = new ArrayList<Coord>();
  ArrayList<Line> lines = new ArrayList<Line>();
  
  Tree(){
    
  }
  
  void show(){
    for(int i = 0; i < lines.size(); i++){
      stroke(255);
      strokeWeight(1);
      line(lines.get(i).start.x*10+5, lines.get(i).start.y*10+5, lines.get(i).end.x*10+5, lines.get(i).end.y*10+5);
    }
    for(int i = 0; i < verts.size(); i++){
      Coord v = verts.get(i);
      stroke(0);
      strokeWeight(1);
      fill(255);
      ellipse(v.x*10+5, v.y*10+5, 4, 4);
    }
  }
  
  boolean exists(Coord pos){
    for(int i = 0; i < verts.size(); i++){
      if(pos.x == this.verts.get(i).x && pos.y == this.verts.get(i).y){
        return true;
      }
    }
    return false;
  }
  
  void countNeighbors(int n){
    int count = 0;
    Coord point = new Coord(verts.get(n).x, verts.get(n).y);
    ArrayList<Coord> neighborCells = new ArrayList<Coord>();
    neighborCells.add( new Coord(point.x+1, point.y)   );
    neighborCells.add( new Coord(point.x+1, point.y+1) );
    neighborCells.add( new Coord(point.x, point.y+1)   );
    neighborCells.add( new Coord(point.x-1, point.y+1) );
    neighborCells.add( new Coord(point.x-1, point.y)   );
    neighborCells.add( new Coord(point.x-1, point.y-1) );
    neighborCells.add( new Coord(point.x, point.y-1)   );
    neighborCells.add( new Coord(point.x+1, point.y-1) );


    for(int j = 0; j < 8; j++){
      if( exists( neighborCells.get(j) ) ){
        count++;
      }
    }

    verts.get(n).neighbors = count;
  }
  
  void printNeighborCount(){
    for(int i = 0; i < verts.size(); i++){
      println(verts.get(i).neighbors);
    }
  }
  
  void reset(){
    verts.clear();
    lines.clear();
  }
  
  void addVertice(Coord pos) {
    verts.add(new Coord(pos.x, pos.y));
  }
  
  void addLine(Coord start, Coord end){
    Line l = new Line(start, end);
    lines.add(l);
  }
  
  Coord getVertice(int i){
    return verts.get(i);
  }
  
  int getSize(){
    return this.verts.size();
  }
}

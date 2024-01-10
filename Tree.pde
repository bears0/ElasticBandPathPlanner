class Tree {
  ArrayList<Coord> verts = new ArrayList<Coord>();
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
  
  void reset(){
    verts.clear();
    lines.clear();
  }
  
  int getStartX(){
    return verts.get(0).x;
  }
  
  int getStartY(){
    return verts.get(0).y;
  }
  
  void addVertice(Coord parent, Coord child) {
    verts.add(new Coord(child.x, child.y, parent));
    parent.addChild(child);
  }
  
  void addVertice(Coord parent) {
    verts.add(new Coord(parent.x, parent.y));
  }
  
  void addLine(Coord start, Coord end){
    Line l = new Line(start, end);
    lines.add(l);
  }
  
  Coord getVertice(int i){
    return verts.get(i);
  }
  
  Coord getLastVertice(){
    //println(verts.size()-1);
    return verts.get(verts.size()-1);
  }
  
  int getSize(){
    return this.verts.size();
  }
}

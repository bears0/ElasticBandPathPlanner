class Coord {
  int x, y;
  Coord parent;
  ArrayList<Coord> children = new ArrayList<Coord>();
  
  Coord(int _x, int _y){
    this.x = _x;
    this.y = _y;
  }
  
  Coord(int _x, int _y, Coord parent){
    this.x = _x;
    this.y = _y;
    this.parent = parent;
  }
  
  float dist(Coord p2){
    return sqrt( pow(p2.x-this.x, 2) + pow(p2.y-this.y, 2) );
  }
  
  void addChild(Coord c){
    this.children.add(c);
  }
  
  void addParent(Coord c){
    this.parent = c;
  }
  
}

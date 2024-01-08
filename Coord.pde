class Coord {
  int x, y;
  
  Coord(int _x, int _y){
    this.x = _x;
    this.y = _y;
  }
  
  float dist(Coord p2){
    return sqrt( pow(p2.x-this.x, 2) + pow(p2.y-this.y, 2) );
  }
}

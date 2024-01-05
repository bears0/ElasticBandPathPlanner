class Rectangle{
  PVector p1;
  PVector p2;
  
  Rectangle(PVector start, PVector end){
    this.p1 = new PVector(start.x, start.y);
    this.p2 = new PVector(end.x, end.y);

  }
  
  void show(){
    fill(255);
    stroke(0);
    strokeWeight(0);
    rect(p1.x, p1.y, p2.x, p2.y);
  }
  
}

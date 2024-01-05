class Bubble {
  float r;
  PVector pos;
  
  Bubble(PVector pos, float r){
    this.pos = new PVector(pos.x, pos.y);
    this.r = r;
  }
  
  void show(){
    fill(0,0,0,0);
    stroke(255);
    strokeWeight(2);
    ellipse(pos.x, pos.y, r, r);
  }
  
}

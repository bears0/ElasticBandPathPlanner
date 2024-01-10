class Bubble {
  float d;
  PVector pos;
  PVector tensionForce;
  PVector repulsionForce;
  
  Bubble(PVector pos, float d){
    this.pos = new PVector(pos.x, pos.y);
    this.d = d;
  }
  
  void show(){
    fill(0,0,0,0);
    stroke(255,255,255,45);
    strokeWeight(1);
    ellipse(pos.x, pos.y, d, d);
  }
  
  void setTensionForce(PVector f){
    this.tensionForce = f;
  }
  
  void setRepulsionForce(PVector f){
    this.repulsionForce = f;
  }
  
}

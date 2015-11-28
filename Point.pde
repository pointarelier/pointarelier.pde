class Point{
  float x;
  float y;
  float z;
  float ang;
  float vitesse;
  String numero;
  color c;
  
  Point(float _x,float _z,float _ang, int _num){
    //x=_x;
    x=_x+random(5);
    z=_z;
    z=_z+random(2,20);
    //z=_z*1.1;
    c=0;
    numero=str(_num);
    ang=_ang;
    vitesse=random(0.1);
  }
  void aff(PGraphics gr){
    gr.pushMatrix();
    gr.rotate(ang);
    gr.translate(x,0,z);
    gr.rotateZ(-ang);
    gr.rotateX(-PI/2);
    gr.stroke(c);
    gr.strokeWeight(5);
    gr.fill(0);
    gr.point(0,0);
    gr.textSize(3);
    gr.text(numero,0,0);
    
    gr.popMatrix();
    
    ang=(ang+vitesse)%(PI*2);
  }
}
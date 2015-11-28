import peasy.*;
Intervalometre intervalometre;
int renderCount=0;
boolean boolRender=false;

PeasyCam cam;

Point [] lsPoint = new Point[1000];
PFont arial;

float ang=0;
int x=1;

PGraphics canvas;

void setup() {
  size(250, 350, P3D);
  // fullScreen(P3D);
  arial=loadFont("ArialMT-48.vlw");

  intervalometre = new Intervalometre(1000);

  //creation du canevas (scene plus grande que l'image aperçue)
  canvas = createGraphics(2500, 3500, P3D);
  canvas.beginDraw();
  canvas.clear();
  //rend transparent l'intérieur des typos
  canvas.hint(DISABLE_DEPTH_TEST);
  canvas.textMode(MODEL);
  canvas.textFont(arial);
  //canvas.frustum(-10, 0, 0, 10, 10, 200); //gestion du "clipping" de la camera (perspective et objet proche)

  canvas.endDraw();

  //librairie PesayCam pour la gestion de la camera
  cam = new PeasyCam(this, canvas, 100);
  cam.setMinimumDistance(50);
  cam.setMaximumDistance(500);
  cam.rotateX(-1.4452541);
  cam.rotateY(0.0);
  cam.rotateZ(0);
  cam.lookAt(0, 0, 360/2);
  cam.setDistance(325);

  //noSmooth();
  for (int i=0; i<lsPoint.length; i++) {
    float countZ = map(i, 0, lsPoint.length, 0, 300);
    float countX = map(i, 0, lsPoint.length, 0, 100);
    lsPoint[i]=new Point(random(0.1, countX), countZ, random(PI), i+1);
  }
  lsPoint[0].z=-2;
  lsPoint[1].z=0;
  lsPoint[2].z=2;
}

void draw() {
  //fond pour l'apercu mais le rendu sera sur du transparent
  background(255);

  canvas.beginDraw();
  canvas.clear();
  canvas.perspective(PI/3.0, (float) width/height, 0.0001, 1000); //réduit la distance minimum de vision "near" 

  canvas.pushMatrix();

  /* //rectangle de plan "sol" 
   canvas.fill(255);
   canvas.rectMode(CENTER);
   rect(0, 0, 100, 100);
   */

  //println(cam.getPosition());
  println(cam.getRotations());
  println(cam.getDistance());


  for (int i=0; i<lsPoint.length; i++) {
    lsPoint[i].aff(canvas);
    //tracé des traits d'un numéro à l'autre (peut-etre à rajouter dans la class Point)
    /*if (i!=0) {
     float xi=lsPoint[i].x*cos(lsPoint[i].ang);
     float yi=lsPoint[i].x*sin(lsPoint[i].ang);
     float xh=lsPoint[i-1].x*cos(lsPoint[i-1].ang);
     float yh=lsPoint[i-1].x*sin(lsPoint[i-1].ang);
     canvas.strokeWeight(0.5);
     canvas.line(xi, yi, lsPoint[i].z, xh, yh, lsPoint[i-1].z);
     }*/
  }

  canvas.popMatrix();
  canvas.endDraw();
  //creation de l'aperçu avec coef de réduction par raport au canvas
  float co=0.3;
  image(canvas, 0, 0, 250, 350);

  if (boolRender==true) {
    
    if (intervalometre.verifierIntervalle()) {
      canvas.save(renderCount+".png");
      renderCount++;
    }
    if (renderCount==300) {
      boolRender=false;
      renderCount=0;
    }
  }
}

  void keyPressed() {
    boolRender=true;
  }
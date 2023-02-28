import com.tempestasludi.processing.nurbs.*;

//import nervoussystem.obj.*;

// Need G4P library
import g4p_controls.*;
// You can remove the PeasyCam import if you are not using
// the GViewPeasyCam control or the PeasyCam library.
import peasy.*;

PShape axes;
PShape block;
PShape ball;
PShape pointBlob;
static int pointcounter, segments, surfaceCounter;
static{
  pointcounter=0;//for automatic labeling of points. DO NOT TOUCH.
  segments=25;//level of detail for the Non-Uniform Rational B-Splines. You can touch this as needed, just keep it abpve zero.
  surfaceCounter=0;//for automatic naming of NURBS faces. NO TOUCHIE!
}
  
public void setup() {
  size(480, 320, P3D);
  createGUI();
  customGUI();
  initializeShapes();

  // Place your setup code here
}

public void draw() {
  background(230);
  PGraphics pg = ViewFinder.getGraphics();
  PeasyCam pcam = ViewFinder.getPeasyCam();
  pcam.setSuppressRollRotationMode();
  pg.beginDraw();
  pg.resetMatrix();
  pcam.feed();
  pg.background(230);
  pg.shape(axes);
  pg.shape(block);//this is temporary.
  pg.endDraw();
}

// Use this method to add additional statements
// to customise the GUI controls
public void customGUI() {
  leReporter.setTextEditEnabled(false);
  MessageBoard.setTextEditEnabled(false);
  PeasyCam pcam = ViewFinder.getPeasyCam();
  pcam.setMinimumDistance(0.1);
  pcam.setMaximumDistance(800.0);
}
public void initializeShapes() {
  axes = createShape();
  axes.beginShape(LINES); // This allows a single shape to be a trio of perpendicular line axes.
  axes.noFill(); //Otherwise we get a very ugly octahedron.
  axes.stroke(255,0,0);
  axes.vertex(400,0,0);
  axes.vertex(-400,0,0);
  axes.stroke(0,255,0);
  axes.vertex(0,400,0);
  axes.vertex(0,-400,0);
  axes.stroke(0,0,255);
  axes.vertex(0,0,400);
  axes.vertex(0,0,-400);
  axes.endShape();
  block = createShape(BOX, 20);
  block.setFill(color(255));
  block.setStroke(color(0));
  pointBlob=createShape(SPHERE, 1);
  pointBlob.setFill(color(244,244,255),195);
  pointBlob.setStroke(color(233,233,255),195);
  
}

//converters

public PVector[] pointsToVectors(P3dPoint[] points){
  PVector[] result = new PVector[points.length];
  for (int i=0; i<points.length;i++){
    result[i]=points[i].getPosition();
  }
  return result;
}

public PVector[][] pointsToVectors(P3dPoint[][] points){
  PVector[][] result = new PVector[points.length][points[0].length];
  for (int i=0; i<points.length; i++) {
    for (int j=0; j<points[i].length; j++) {
      result[i][j]=points[i][j].getPosition();
    }
  }
  return result;
}

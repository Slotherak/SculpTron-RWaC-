import com.tempestasludi.processing.nurbs.*;

// Need G4P library
import g4p_controls.*;
// You can remove the PeasyCam import if you are not using
// the GViewPeasyCam control or the PeasyCam library.
import peasy.*;

PShape axes;
P3dShape block;
P3dPoint originPoint;
PShape pointBlob;
int[] SurfColor;
static int pointcounter, segments, surfaceCounter, primCounter, worldWidth;
static {
  pointcounter=0;//for automatic labeling of points. DO NOT TOUCH.
  segments=25;//level of detail for the Non-Uniform Rational B-Splines. You can touch this as needed, just keep it abpve zero.
  surfaceCounter=0;//for automatic naming of NURBS faces. NO TOUCHIE!
  primCounter=0;//the price of laziness is restriction. Touch and die. You should know what this does by now.
  worldWidth=400;//THIS IS WHAT YOU MUST EDIT TO CHANGE THE WORKING SPACE! It is the half of the virtual working space's length. DO NOT MAKE NEGATIVE.
}

public void setup() {
  size(480, 320, P3D);
  createGUI();
  customGUI();
  SurfColor = new int[]{200, 255, 244};
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
  pg.shape(block);
  originPoint.draw(pg);
  block.draw(pg);
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
  axes.stroke(255, 0, 0);
  axes.vertex(worldWidth, 0, 0);
  axes.vertex(-worldWidth, 0, 0);
  axes.stroke(0, 255, 0);
  axes.vertex(0, worldWidth, 0);
  axes.vertex(0, -worldWidth, 0);
  axes.stroke(0, 0, 255);
  axes.vertex(0, 0, worldWidth);
  axes.vertex(0, 0, -worldWidth);
  axes.endShape();
  block = new P3dShape();
  block.setFill(color(255));
  block.setStroke(color(0));
  pointBlob=createShape(SPHERE, 1);
  pointBlob.setFill(color(244, 244, 255, 175));
  pointBlob.setStroke(color(233, 233, 255, 195));
  originPoint=new P3dPoint(0,0,0,"origin");
}

//converters

public PVector[] pointsToVectors(P3dPoint[] points) {
  PVector[] result = new PVector[points.length];
  for (int i=0; i<points.length; i++) {
    result[i]=points[i].getPosition();
  }
  return result;
}

public PVector[][] pointsToVectors(P3dPoint[][] points) {
  PVector[][] result = new PVector[points.length][points[0].length];
  for (int i=0; i<points.length; i++) {
    for (int j=0; j<points[i].length; j++) {
      result[i][j]=points[i][j].getPosition();
    }
  }
  return result;
}

public PVector[][] dummyValues() {
  //because we can't have nice and cooperative code libraries, this is a placeholder fix
  //for the problem of needing to instantiate a NurbsSurface with no actual values, as
  //the NS is not actually needed at all, except by the compiler. Because reasons.
  PVector[][] dummy = new PVector[5][5];
  for (int i=0; i<5; i++) {
    for (int j=0; j<5; j++) {
      dummy[i][j] = new PVector((i - 2) * 100, (j - 2) * 100, 0);//this is from the surface example. yes I'm that lazy.
    }
  }
  return dummy;
}

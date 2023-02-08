//import nervoussystem.obj.*;

import peasy.*;

// Need G4P library
import g4p_controls.*;
// You can remove the PeasyCam import if you are not using
// the GViewPeasyCam control or the PeasyCam library.
import peasy.*;

PShape cube;
public void setup() {
  size(480, 320, P3D);
  createGUI();
  customGUI();
  // Place your setup code here
}

public void draw() {
  background(230);
  PGraphics pg = ViewFinder.getGraphics();
  PeasyCam pcam = ViewFinder.getPeasyCam();
  pg.beginDraw();
  pg.resetMatrix();
  pcam.feed();
  pg.background(230);
  pg.box(20);
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

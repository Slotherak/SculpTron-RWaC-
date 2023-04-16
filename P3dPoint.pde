class P3dPoint extends Nurbs implements Comparable<P3dPoint> {
  private PVector position;//for convenience, we add a simple array for the particular location of a point in 3d space
  private float x, y, z;//as well as individual coordinates.
  private String ID;//if we don't name it something, what even is the point? (I'll see myself out now)

  P3dPoint(float xIn, float yIn, float zIn, String IDIn) {
    x=xIn;
    y=yIn;
    z=zIn;
    ID=IDIn;
    position= new PVector(xIn, yIn, zIn);//No need to reiterate the individual coordinates of the point in an array...
  }

  P3dPoint(PVector positionIn, String IDIn) {
    x=positionIn.array()[0];//no need to reiterate a positional array's coordinates individually...
    y=positionIn.array()[1];
    z=positionIn.array()[2];
    ID=IDIn;
    position=positionIn;
  }

  P3dPoint(float xIn, float yIn, float zIn) {
    x=xIn;
    y=yIn;
    z=zIn;
    position= new PVector(xIn, yIn, zIn);//No need to reiterate the individual coordinates of the point in an array...
    //NOOOOOOOOOO-- i'm just messing with ya.
    ID=""+pointcounter;
    pointcounter++;//This auto-assigns a number ID to any point you were too lazy to name. ya bum.
  }

  P3dPoint(PVector positionIn) {//don't know why you would even need this constructor...
    x=positionIn.array()[0];//no need to reiterate a positional array's coordinates individually...
    y=positionIn.array()[1];
    z=positionIn.array()[2];
    position= positionIn;
    ID=""+pointcounter;
    pointcounter++;
  }

  public float getX() {
    return x;
  }

  public float getY() {
    return y;
  }

  public float getZ() {
    return z;
  }

  public String getID() {
    return ID;
  }

  public PVector getPosition() {
    return position;
  }

  public void setX(float x) {
    this.x=x;
    this.position.array()[0]=x;
  }

  public void setY(float y) {
    this.y=y;
    this.position.array()[1]=y;
  }

  public void setZ(float z) {
    this.z=z;
    this.position.array()[2]=z;
  }

  public void getID(String ID) {
    this.ID=ID;
  }

  public void setPosition(PVector position) {
    this.position.array()[0]=position.array()[0];
    this.position.array()[1]=position.array()[1];
    this.position.array()[2]=position.array()[2];
    this.x=position.array()[0];
    this.y=position.array()[1];
    this.z=position.array()[2];
  }

  public int compareTo(P3dPoint p) {
    int difference =(int) (this.x + (this.y + (2 * worldWidth)) + (this.z + (worldWidth * 4)));
    difference-=(int) (p.x + (p.y + (2 * worldWidth)) + (p.z + (worldWidth * 4)));
    return difference;
  }

  public void draw() {
    PShape pointBlob=createShape(SPHERE, 1);
    pointBlob.setFill(color(244, 244, 255, 195));
    pointBlob.setStroke(color(233, 233, 255, 195));
    pushMatrix();
    translate(x, y, z);
    shape(pointBlob);
    popMatrix();
  }
}

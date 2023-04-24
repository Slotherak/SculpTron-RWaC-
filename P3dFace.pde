public class P3dFace extends NurbsSurface {
  private P3dLine[] border;
  private PShape polygon;
  private int type;
  private ArrayList<String> adjoiningFaces;
  private String ID;
  private PVector normal;
  //Necessary fields for NurbsSurface class instantiation
  private PVector[][] points;
  private float[][] weights;
  private int sDegree, tDegree;
  private float[] sKnotVector, tKnotVector;

  P3dFace(PVector[][] points) {//due to programming restraints, this constructor will create "3D surfaces" as faces.
    super(points);
    this.points=points;
    this.type=1;
    this.weights=new float[points.length][points[0].length];
    {
      for (int i=0; i<points.length; i++){
        for (int j=0; j<points[i].length; j++){
          this.weights[i][j]=1.0;
        }
      }
    }
    this.sDegree=points.length-1;
    this.tDegree=points[0].length-1;
    int[] tD = new int[points.length];
    for (int i=0; i<tD.length; i++) {
      tD[i]=points[i].length-1;
    }
    java.util.Arrays.sort(tD);
    this.tDegree=tD[0];
    this.sKnotVector=null;
    this.tKnotVector=null;
    this.border=this.pVectorArrayToBorders(points);
    this.adjoiningFaces=new ArrayList<String>(4);//because we are dealing with a supposedly square surface, we logically will only have four adjacent faces.
    this.ID=Integer.toString(surfaceCounter);
    surfaceCounter++;
    this.polygon= createShape(RECT, 0, 0, border[0].getVector().mag(),border[1].getVector().mag());
    this.normal=PVector.cross(border[0].getVector(),border[1].getVector(),this.normal);
  }

  P3dFace(PVector[][] points, String ID) {//due to programming restraints, this constructor will create 3D surfaces as faces.
    super(points);
    this.points=points;
    this.type=1;
    this.weights=new float[points.length][points[0].length];
    {
      for (int i=0; i<points.length; i++){
        for (int j=0; j<points[i].length; j++){
          this.weights[i][j]=1.0;
        }
      }
    }
    this.sDegree=points.length-1;
    this.tDegree=points[0].length-1;
    int[] tD = new int[points.length];
    for (int i=0; i<tD.length; i++) {
      tD[i]=points[i].length-1;
    }
    java.util.Arrays.sort(tD);
    this.tDegree=tD[0];
    this.sKnotVector=null;
    this.tKnotVector=null;
    this.border=this.pVectorArrayToBorders(points);
    this.adjoiningFaces=new ArrayList<String>(4);//because we are dealing with a supposedly square surface, we logically will only have four adjacent faces.
    this.ID=ID;
    this.polygon= createShape(RECT, 0, 0, border[0].getVector().mag(), border[1].getVector().mag());
    this.normal=PVector.cross(border[0].getVector(),border[1].getVector(),this.normal);
  }

  P3dFace(P3dLine[] border, String ID) {
    super(dummyValues());//Straight lines don't necessitate a 3d face, only a planar surface.
    this.points=null;
    this.weights=null;
    this.sDegree=1;
    this.tDegree=1;
    this.sKnotVector=null;
    this.tKnotVector=null;
    this.ID=ID;
    this.border=border;
    this.adjoiningFaces=new ArrayList<String>(border.length);//Every edge is shared between two faces and only two faces. Therefore this cannot be larger than border.length.
    this.polygon= createShape();
    this.polygon.beginShape();
    for (int i=0; i<border.length; i++) {
      this.polygon.vertex(border[i].getP1().getX(), border[i].getP1().getY(), border[i].getP1().getZ());
    }
    this.polygon.endShape(CLOSE);
    this.type=0;
    this.normal=PVector.cross(border[0].getVector(),border[1].getVector(),this.normal);
  }

  P3dFace(P3dLine[] border) {
    super(dummyValues());
    this.points=null;
    this.weights=null;
    this.sDegree=1;
    this.tDegree=1;
    this.sKnotVector=null;
    this.tKnotVector=null;
    this.ID=Integer.toString(surfaceCounter);
    surfaceCounter++;
    this.border=border;
    this.adjoiningFaces=new ArrayList<String>(border.length);
    this.polygon= createShape();
    polygon.beginShape();
    for (int i=0; i<border.length; i++) {
      polygon.vertex(border[i].getP1().getX(), border[i].getP1().getY(), border[i].getP1().getZ());
    }
    polygon.endShape(CLOSE);
    this.type=0;
    this.normal=PVector.cross(border[0].getVector(),border[1].getVector(),this.normal);
  }

  P3dFace(P3dPoint[][] points, String ID) {
    super(pointsToVectors(points));
    this.ID=ID;
    this.weights=new float[points.length][points[0].length];
    {
      for (int i=0; i<points.length; i++){
        for (int j=0; j<points[i].length; j++){
          this.weights[i][j]=1.0;
        }
      }
    }
    this.type=1;
    this.sDegree=points.length-1;
    this.tDegree=points[0].length-1;
    int[] tD = new int[points.length];
    for (int i=0; i<tD.length; i++) {
      tD[i]=points[i].length-1;
    }
    java.util.Arrays.sort(tD);//Do not remove, this sorts the temporary array tD to see what the highest degree is.
    this.tDegree=tD[0];
    this.sKnotVector=null;
    this.tKnotVector=null;
    this.border=this.pVectorArrayToBorders(pointsToVectors(points));
    this.adjoiningFaces=new ArrayList<String>(4);//because we are dealing with a supposedly square surface, we logically will only have four adjacent faces.
    this.polygon= createShape();
    polygon.beginShape();
    for (int i=0; i<border.length; i++) {
      polygon.vertex(border[i].getP1().getX(), border[i].getP1().getY(), border[i].getP1().getZ());
    }
    polygon.endShape(CLOSE);
    this.normal=PVector.cross(border[0].getVector(),border[1].getVector(),this.normal);
  }

  P3dFace(P3dPoint[][] points) {
    super(pointsToVectors(points));
    this.ID=Integer.toString(surfaceCounter);
    surfaceCounter++;
    this.weights=new float[points.length][points[0].length];
    {
      for (int i=0; i<points.length; i++){
        for (int j=0; j<points[i].length; j++){
          this.weights[i][j]=1.0;
        }
      }
    };
    this.type=1;
    this.sDegree=points.length-1;
    this.tDegree=points[0].length-1;
    int[] tD = new int[points.length];
    for (int i=0; i<tD.length; i++) {
      tD[i]=points[i].length-1;
    }
    java.util.Arrays.sort(tD);//Do not remove, this sorts the temporary array tD to see what the highest degree is.
    this.tDegree=tD[0];
    this.sKnotVector=null;
    this.tKnotVector=null;
    this.border=this.pVectorArrayToBorders(pointsToVectors(points));
    this.adjoiningFaces=new ArrayList<String>(4);//because we are dealing with a supposedly square surface, we logically will only have four adjacent faces. the fifth is for overflow.
    this.polygon= createShape();
    polygon.beginShape();
    for (int i=0; i<border.length; i++) {
      polygon.vertex(border[i].getP1().getX(), border[i].getP1().getY(), border[i].getP1().getZ());
    }
    polygon.endShape(CLOSE);
    this.normal=PVector.cross(border[0].getVector(),border[1].getVector(),this.normal);
  }

  private P3dLine[] pVectorArrayToBorders(PVector[][] points) {//this is not to be called outside of this class.
    ArrayList<PVector> borderList= new ArrayList<PVector>();
    P3dLine l1, l2, l3, l4;
    for (int i=0; i<points.length; i++) {
      for (int j=0; j<points[i].length; j++) {
        if (i==0) {
          borderList.add(points[i][j]);
        }
      }
    }
    borderList.trimToSize();
    l1=new P3dLine((PVector[]) borderList.toArray());
    borderList.clear();
    for (int i=0; i<points.length; i++) {
      for (int j=0; j<points[i].length; j++) {
        if (j==0) {
          borderList.add(points[i][j]);
        }
      }
    }
    borderList.trimToSize();
    l3=new P3dLine((PVector[]) borderList.toArray());
    borderList.clear();
    for (int i=0; i<points.length; i++) {
      for (int j=0; j<points[i].length; j++) {
        if (i==points.length-1) {
          borderList.add(points[i][j]);
        }
      }
    }
    borderList.trimToSize();
    l2=new P3dLine((PVector[]) borderList.toArray());
    borderList.clear();
    for (int i=0; i<points.length; i++) {
      for (int j=0; j<points[i].length; j++) {
        if (j==points[i].length-1) {
          borderList.add(points[i][j]);
        }
      }
    }
    borderList.trimToSize();
    l4=new P3dLine((PVector[]) borderList.toArray());
    return new P3dLine[]{l1, l2, l3, l4};
  }

  public P3dLine[] getBorder() {
    return this.border;
  }

  public int getType() {
    return this.type;
  }

  public ArrayList<String> getAdjoiningFaces() {
    return this.adjoiningFaces;
  }

  public String getID() {
    return this.ID;
  }

  public PVector[][] getPoints() {
    return this.points;
  }

  public float[][] getWeights() {
    return this.weights;
  }

  public int getSDegree() {
    return this.sDegree;
  }

  public int getTDegree() {
    return this.tDegree;
  }

  public float[] getSKnotVector() {
    return this.sKnotVector;
  }

  public float[] getTKnotVector() {
    return this.tKnotVector;
  }

  public void setBorder(P3dLine[] border) {
    this.border=border;
  }

  public void setType(int type) {
    this.type=type;
  }

  public void setAdjoiningFaces(ArrayList<String> adjoiningFaces) {//you shouldn't have to call this ideally, but for completeness' sake...
    this.adjoiningFaces=adjoiningFaces;
  }

  public void setID(String ID) {
    this.ID=ID;
  }

  public void setPoints(PVector[][] points) {
    this.points=points;
  }

  public void setWeights(float[][] weights) {
    this.weights=weights;
  }

  public void setSDegree(int sDegree) {
    this.sDegree=sDegree;
  }

  public void setTDegree(int tDegree) {
    this.tDegree=tDegree;
  }

  public void setSKnotVector(float[] sKnotVector) {
    this.sKnotVector=sKnotVector;
  }

  public void setTKnotVector(float[] tKnotVector) {
    this.tKnotVector=tKnotVector;
  }
  //hmmm... how to make it recognize arbitrary dots as a possible planar surface....
  //of course!! Planes can be defined by their normal vectors!
  public boolean verifyPlanarSurface(P3dPoint[][] points) {
    PVector pointAlpha, pointBeta, pointGamma;
    pointAlpha=points[0][0].getPosition();
    pointBeta=points[0][1].getPosition();
    pointGamma=points[1][0].getPosition();
    //operation explanation: All groups of three arbitrary points represent at least one 2-dimensional
    //plane in a 3-dimensional space. The addition of a fourth point however removes this guarantee.
    //Therefore, as long as we have at least three points that we know are coplanar, because any 3
    //WILL be coplanar, then we can cross multiply against all other points to verify that they are
    //on the same plane(s)! these points CANNOT be linear, or else this fails...!
    PVector vecOne = new PVector();
    PVector vecTwo = new PVector();
    vecOne = PVector.sub(pointAlpha, pointBeta, vecOne);
    vecTwo = PVector.sub(pointAlpha, pointGamma, vecTwo);
    if (PVector.angleBetween(vecOne, vecTwo)%PI!=0) {//making sure we have a non-linear set of points
      PVector[][] realPoints = pointsToVectors(points);
      PVector testVector = new PVector();
      PVector controlVector = new PVector();
      PVector.cross(vecOne, vecTwo, controlVector).normalize();
      PVector resultVector = new PVector();
      for (PVector[] P : realPoints) {
        for (PVector p : P) {
          testVector.set(PVector.lerp(pointAlpha, p, 1));
          if (!P.equals(realPoints[0])) {
            if (PVector.cross(testVector, vecOne, resultVector).normalize().equals(controlVector)) {
              continue;
            } else {
              return false;
            }
          } else if (P.equals(realPoints[0])) {
            if (PVector.cross(testVector, vecTwo, resultVector).normalize().equals(controlVector)) {
              continue;
            } else if (p.equals(pointAlpha)) {
              continue;
            } else {
              return false;
            }
          }
        }
      }
      return true;
    } else {
      return false;
    }
  }
  
  public void rotate(float[] rot){
    this.polygon.rotateX(rot[0]);
    this.polygon.rotateY(rot[1]);
    this.polygon.rotateZ(rot[2]);
    
  }

  public void draw(PGraphics pg) {
    switch(this.type) {
    case 0:
      fill(SurfColor[0], SurfColor[1], SurfColor[2]);
      stroke(SurfColor[0], SurfColor[1], SurfColor[2]);
      pushMatrix();
      pg.shape(this.polygon);
      popMatrix();
      break;
    case 1:
      fill(SurfColor[0], SurfColor[1], SurfColor[2]);
      stroke(SurfColor[0], SurfColor[1], SurfColor[2]);
      pushMatrix();
      super.draw(pg, segments);
      noFill();
      pg.shape(this.polygon);
      popMatrix();
      break;
    default:
      for (P3dLine p : border){
        stroke(SurfColor[0],SurfColor[1],SurfColor[2]);
        p.draw(pg);
      }
    }
  }
}

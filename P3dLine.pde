public class P3dLine extends NurbsCurve {
  private P3dPoint p1, p2;
  private String ID;
  private int type;//0 is a linear line segment. 1 is a NURBS curve object, with added features.
  private P3dPoint[] c1;
  private PVector[] c2;
  private float[] weights;
  private int degrees;
  private float[] knotVector;

  P3dLine(String ID, P3dPoint[] c1) {
    super(pointsToVectors(c1));
    this.ID=ID;
    this.type=1;
    this.c1=c1;
    this.p1=null;
    this.p2=null;
    this.weights=null;
    this.degrees=c1.length-1;
    this.knotVector=null;
    this.c2=new PVector[c1.length];
    for (int i=0; i < (c2.length-1) ; i++) this.c2[i]=(c1[i].getPosition());
  }
  
  P3dLine(P3dPoint p1, P3dPoint p2, String ID) {
    super(new PVector[]{p1.getPosition(),p2.getPosition()});
    this.p1=p1;
    this.c1=null;
    if (p1.getPosition()==p2.getPosition()) {
      this.p2=p1;
    } else {
      this.p2=p2;
    }
    this.degrees=0;
    this.ID=ID;
    this.type=0;//only two points? no curve for you!
    this.weights=null;
    this.c2=null;
    this.knotVector=null;
  }
  
  P3dLine(P3dPoint[] c1) {
    super(pointsToVectors(c1));
    this.p1=null;
    this.c1=c1;
    this.p2=null;
    ID=(c1[0].getID()+" <~ "+(c1.length-1)+" ~> "+c1[c1.length-1].getID());
    this.c2=new PVector[c1.length];
    for (int i=0; i < (c2.length-1) ; i++) this.c2[i]=(c1[i].getPosition());
    this.type=1;
    this.weights=null;
    this.degrees=c1.length-1;
    this.knotVector=null;
  }
  
  P3dLine(PVector[] c2) {
    super(c2);
    this.p1=null;
    this.c1=new P3dPoint[c2.length];
    for (int i=0; i < (c1.length-1) ; i++) this.c1[i]= new P3dPoint(c2[i]);
    this.p2=null;
    ID=(c1[0].getID()+" <~ "+(c1.length-1)+" ~> "+c1[c1.length-1].getID());
    this.c2=c2;
    this.type=1;
    this.weights=null;
    this.degrees=c1.length-1;
    this.knotVector=null;
  }
  
  P3dLine(P3dPoint p1, P3dPoint p2) {
    super(new PVector[]{p1.getPosition(),p2.getPosition()});
    this.p1=p1;
    this.c1=null;
    if (p1.getPosition()==p2.getPosition()) {
      this.p2=p1;
    } else {
      this.p2=p2;
    }
    ID=(p1.getID()+" <--> "+p2.getID());
    this.type=0;//zero is the straight line feature.
    this.degrees=0;
    this.weights=null;
    this.c2=null;
    this.knotVector=null;
  }
  
  public P3dPoint getP1() {
    return p1;
  }
  
  public P3dPoint getP2() {
    return p2;
  }
  
  public String getID() {
    return ID;
  }
  
  public P3dPoint[] getC1() {
    return c1;
  }
  
  public int getDegrees() {
    return degrees;
  }
  
  public float[] getWeights() {
    return weights;
  }
  
  public PVector[] getC2() {
    return c2;
  }
  
  public float[] getKnotVector() {
    return knotVector;
  }
  
  public void setP1(P3dPoint p1) {
    this.p1=(this.type==0?p1:null);
  }
  
  public void setP2(P3dPoint p2) {
    this.p2=(this.type==0?p2:null);
  }
  
  public void setID(String newID) {
    ID=newID;
  }
  
  public void setC1(P3dPoint[] c1) {
    this.c1=(this.type==1?c1:null);
  }
  
  public void setWeights(float[] w) {
    this.weights=(this.type==1?w:null);
  }
  
  public void setKnotVector(float[] k) {
    this.weights=(this.type==1?k:null);
  }
  
  public void setC2(PVector[] c2) {
    this.c2=(this.type==1?c2:null);
  }
  
  public void setDegrees(int d) {
    this.degrees=(this.type==1?d:0);//the degree of a linear function is zero. otherwise it's a degree of n-1.
  }
  
  public P3dLine subdivideLine() {
    if (this.type==1) {
      return null;//we don't handle the subdivision of curved lines. That will be a future development. Maybe.
    } else {
      float x = (this.getP1().getX() + this.getP2().getX()/2);
      float y = (this.getP1().getY() + this.getP2().getY()/2);
      float z = (this.getP1().getZ() + this.getP2().getZ()/2);
      //now we split
      P3dPoint p3 = new P3dPoint(x, y, z);//this sets the midway point between the endpoints...
      P3dLine l2= new P3dLine(p3, this.getP2());//this uses the existing p2 as the official p3, don't let the math confuse you...
      this.setP2(p3);//this sets the current lne as half of its original self.
      return l2;//allows the new line to exist outside of this function. otherwise it would just be collected and tossed out.
    }
  }
  
  
}

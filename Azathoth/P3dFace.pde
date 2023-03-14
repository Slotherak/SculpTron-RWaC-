public class P3dFace extends NurbsSurface {
  private P3dLine[] border;
  private int type;
  private ArrayList<String> adjoiningFaces;
  private String ID;
  //Necessary fields for NurbsSurface class instantiation
  private PVector[][] points;
  private float[][] weights;
  private int sDegree, tDegree;
  private float[] sKnotVector, tKnotVector;

  P3dFace(PVector[][] points) {//due to programming restraints, this constructor will create "3D surfaces" as faces.
    super(points);
    this.points=points;
    this.type=1;
    this.weights=null;
    this.sDegree=points.length-1;
    this.tDegree=points[0].length-1;
    int[] tD = new int[points.length];
    for (int i=0; i<tD.length; i++){
      tD[i]=points[i].length-1;
    }
    java.util.Arrays.sort(tD);
    this.tDegree=tD[0];
    this.sKnotVector=null;
    this.tKnotVector=null;
    this.border=this.pVectorArrayToBorders(points);
    this.adjoiningFaces=new ArrayList<String>(5);//because we are dealing with a supposedly square surface, we logically will only have four adjacent faces. the fifth is for overflow.
    this.ID=Integer.toString(surfaceCounter);surfaceCounter++;
  }
  
  P3dFace(PVector[][] points, String ID) {//due to programming restraints, this constructor will create 3D surfaces as faces.
    super(points);
    this.points=points;
    this.type=1;
    this.weights=null;
    this.sDegree=points.length-1;
    this.tDegree=points[0].length-1;
    int[] tD = new int[points.length];
    for (int i=0; i<tD.length; i++){
      tD[i]=points[i].length-1;
    }
    java.util.Arrays.sort(tD);
    this.tDegree=tD[0];
    this.sKnotVector=null;
    this.tKnotVector=null;
    this.border=this.pVectorArrayToBorders(points);
    this.adjoiningFaces=new ArrayList<String>(5);//because we are dealing with a supposedly square surface, we logically will only have four adjacent faces. the fifth is for overflow.
    this.ID=ID;
  }
  
  P3dFace(P3dLine[] border, String ID) {
    super(null);//Straight lines don't necessitate a 3d face, only a planar surface.
    this.points=null;
    this.weights=null;
    this.sDegree=1;
    this.tDegree=1;
    this.sKnotVector=null;
    this.tKnotVector=null;
    this.ID=ID;
    this.border=border;
    this.adjoiningFaces=new ArrayList<String>(border.length);//Every edge is shared between two faces and only two faces. Therefore this cannot be larger than border.length.
  }
  
  P3dFace(P3dLine[] border){
    super(null);
    this.points=null;
    this.weights=null;
    this.sDegree=1;
    this.tDegree=1;
    this.sKnotVector=null;
    this.tKnotVector=null;
    this.ID=Integer.toString(surfaceCounter);surfaceCounter++;
    this.border=border;
    this.adjoiningFaces=new ArrayList<String>(border.length);
  }
  
  P3dFace(P3dPoint[][] points, String ID){
    super(pointsToVectors(points));
    this.ID=ID;
    this.weights=null;
    this.type=1;
    this.sDegree=points.length-1;
    this.tDegree=points[0].length-1;
    int[] tD = new int[points.length];
    for (int i=0; i<tD.length; i++){
      tD[i]=points[i].length-1;
    }
    java.util.Arrays.sort(tD);//Do not remove, this sorts the temporary array tD to see what the highest degree is.
    this.tDegree=tD[0];
    this.sKnotVector=null;
    this.tKnotVector=null;
    this.border=this.pVectorArrayToBorders(pointsToVectors(points));
    this.adjoiningFaces=new ArrayList<String>(5);//because we are dealing with a supposedly square surface, we logically will only have four adjacent faces. the fifth is for overflow.
  }
  
  P3dFace(P3dPoint[][] points){
    super(pointsToVectors(points));
    this.ID=Integer.toString(surfaceCounter);surfaceCounter++;
    this.weights=null;
    this.type=1;
    this.sDegree=points.length-1;
    this.tDegree=points[0].length-1;
    int[] tD = new int[points.length];
    for (int i=0; i<tD.length; i++){
      tD[i]=points[i].length-1;
    }
    java.util.Arrays.sort(tD);//Do not remove, this sorts the temporary array tD to see what the highest degree is.
    this.tDegree=tD[0];
    this.sKnotVector=null;
    this.tKnotVector=null;
    this.border=this.pVectorArrayToBorders(pointsToVectors(points));
    this.adjoiningFaces=new ArrayList<String>(5);//because we are dealing with a supposedly square surface, we logically will only have four adjacent faces. the fifth is for overflow.
  }
  
  private P3dLine[] pVectorArrayToBorders(PVector[][] points){//this is not to be called outside of this class.
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
  
  public P3dLine[] getBorder(){
    return this.border;
  }
  
  public int getType(){
    return this.type;
  }
  
  public ArrayList<String> getAdjoiningFaces(){
    return this.adjoiningFaces;
  }
  
  public String getID(){
    return this.ID;
  }
  
  public PVector[][] getPoints(){
    return this.points;
  }
  
  public float[][] getWeights(){
    return this.weights;
  }
  
  public int getSDegree(){
    return this.sDegree;
  }
  
  public int getTDegree(){
    return this.tDegree;
  }
  
  public float[] getSKnotVector(){
    return this.sKnotVector;
  }
  
  public float[] getTKnotVector(){
    return this.tKnotVector;
  }
  
  public void setBorder(P3dLine[] border){
    this.border=border;
  }
  
  public void setType(int type){
    this.type=type;
  }
  
  public void setAdjoiningFaces(ArrayList<String> adjoiningFaces){//you shouldn't have to call this ideally, but for completeness' sake...
    this.adjoiningFaces=adjoiningFaces;
  }
  
  public void setID(String ID){
    this.ID=ID;
  }
  
  public void setPoints(PVector[][] points){
    this.points=points;
  }
  
  public void setWeights(float[][] weights){
    this.weights=weights;
  }
  
  public void setSDegree(int sDegree){
    this.sDegree=sDegree;
  }
  
  public void setTDegree(int tDegree){
    this.tDegree=tDegree;
  }
  
  public void setSKnotVector(float[] sKnotVector){
    this.sKnotVector=sKnotVector;
  }
  
  public void setTKnotVector(float[] tKnotVector){
    this.tKnotVector=tKnotVector;
  }
  ////hmmm... how to make it recognize arbitrary dots as a possible planar surface....
  //public boolean verifyPlanarSurface(P3dPoint[][] points) {
  //  return true;
  //}
}

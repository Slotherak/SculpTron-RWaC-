public class P3dShape {
  /*
  THIS IS IT PEOPLE! THIS IS IT!!
   
   The new and improved version of PShape is being finally typed up!
   
   
   Nah, just kidding. This is not going to be the same by a long shot.
   */
  //Fields
  private ArrayList<P3dFace> faces;
  private ArrayList<P3dLine> edges;
  private ArrayList<P3dPoint> vertices;
  private ArrayList<PVector> verticeVectors;
  private String ID;
  private float[] rotation;
  private float[] scale;
  private float[] position;
  private boolean solid;

  P3dShape() {//default constructor for those who need it because they couldn't be arsed to provide details.
    this.vertices=new ArrayList<P3dPoint>(27);
    this.edges=new ArrayList<P3dLine>(12);
    this.faces=new ArrayList<P3dFace>(6);
    for (int i=0; i < this.vertices.size()/9; i++) {
      for (int j=0; j<this.vertices.size()/9; j++) {
        for (int k=0; k<this.vertices.size()/9; k++) {
          this.vertices.set(((i*9)+(j*3)+k),new P3dPoint(((i*3)-3),((j*3)-3),((k*3)-3)));
        }
      }
    }
    this.verticeVectors=new ArrayList<PVector>(27);
    for (int i=0; i<this.verticeVectors.size()/9; i++) {
      for (int j=0; j<this.verticeVectors.size()/9; j++) {
        for (int k=0; k<this.verticeVectors.size()/9; k++) {
          this.verticeVectors.set(((i*9)+(j*3)+k), this.vertices.get(((i*9)+(j*3)+k)).getPosition());
        }
      }
    }
    this.ID=Integer.toString(primCounter);
    primCounter++;
    
    
  }
}

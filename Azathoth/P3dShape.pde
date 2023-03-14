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
      for (int j=0; j < this.vertices.size()/9; j++) {
        for (int k=0; k < this.vertices.size()/9; k++) {
          this.vertices.set(((i*9)+(j*3)+k),new P3dPoint(((i*3)-3),((j*3)-3),((k*3)-3)));
        }
      }
    }
    this.verticeVectors=new ArrayList<PVector>(27);
    for (int i=0; i < this.verticeVectors.size()/9; i++) {
      for (int j=0; j < this.verticeVectors.size()/9; j++) {
        for (int k=0; k < this.verticeVectors.size()/9; k++) {
          this.verticeVectors.set(((i*9)+(j*3)+k), this.vertices.get(((i*9)+(j*3)+k)).getPosition());
        }
      }
    }
    this.solid=true;
    this.rotation=new float[] {0, 0, 0};
    this.scale=new float[] {0, 0, 0};
    this.position=new float[] {0, 0, 0};
    /*ok, the vertices are set up in a cubic system at locations separated by 3 units, in a 3x3x3 formation.
    but, the indices are on a 0-26 scale. so the first iterator goes through the X values.
    the second one goes through the Y values, and the innermost one handles the Z values.
    i.e., x1y1z1-x1y1z3, then x1y2z1... x1y3z3, then x2y1z1... x3y3z3. a base three system.
    so which ones are the edges? whenever our number in base 3 happens to be an extrema in at least two variables.
    hoo boy...
                       8 17 26
              7 16 25  5 14 23
     6 15 24  4 13 22  2 11 20
     3 12 21  1 10 19
     0  9 18
     back     middle   front
    first point will always start with at least one -3 value...
    0x3, 6x2, 18x2, 2x2, 8x1, 20x1, 24x1.
    second point will have exactly one 0 value, and be featured once...
    (0)1, 3, 9,(2) 5, 11,(6) 7, 15,(18) 21, 19,(8) 17,(20) 23,(24) 25.
    */
    ArrayList<P3dLine> edges;
    edges = new ArrayList<>(12);
    P3dPoint[] bufferx, buffery, bufferz;
    bufferx=new P3dPoint[] {this.vertices.get(0), this.vertices.get(9), this.vertices.get(18)};
    buffery=new P3dPoint[] {this.vertices.get(0), this.vertices.get(3), this.vertices.get(6)};
    bufferz=new P3dPoint[] {this.vertices.get(0), this.vertices.get(1), this.vertices.get(2)};
    edges.set(0,new P3dLine(bufferx, true));
    edges.set(1,new P3dLine(buffery, true));
    edges.set(2,new P3dLine(bufferz, true));
    bufferx=new P3dPoint[] {this.vertices.get(2), this.vertices.get(11), this.vertices.get(20)};
    buffery=new P3dPoint[] {this.vertices.get(2), this.vertices.get(5), this.vertices.get(8)};
    bufferz=new P3dPoint[] {this.vertices.get(18), this.vertices.get(19), this.vertices.get(20)};
    edges.set(3,new P3dLine(bufferx, true));
    edges.set(4,new P3dLine(buffery, true));
    edges.set(5,new P3dLine(bufferz, true));
    bufferx=new P3dPoint[] {this.vertices.get(6), this.vertices.get(15), this.vertices.get(24)};
    buffery=new P3dPoint[] {this.vertices.get(18), this.vertices.get(21), this.vertices.get(24)};
    bufferz=new P3dPoint[] {this.vertices.get(6), this.vertices.get(7), this.vertices.get(8)};
    edges.set(6,new P3dLine(bufferx, true));
    edges.set(7,new P3dLine(buffery, true));
    edges.set(8,new P3dLine(bufferz, true));
    bufferx=new P3dPoint[] {this.vertices.get(8), this.vertices.get(17), this.vertices.get(26)};
    buffery=new P3dPoint[] {this.vertices.get(20), this.vertices.get(24), this.vertices.get(26)};
    bufferz=new P3dPoint[] {this.vertices.get(24), this.vertices.get(25), this.vertices.get(26)};
    edges.set(9,new P3dLine(bufferx, true));
    edges.set(10,new P3dLine(buffery, true));
    edges.set(11,new P3dLine(bufferz, true));
    edges.trimToSize();
    this.edges=edges;
    /*
    back     middle   front
                      8 17 26
             7 16 25  5 14 23
    6 15 24  4 13 22  2 11 20
    3 12 21  1 10 19
    0 9  18
    x edges are 0 mod 3. 0, 3, 6, 9. 0-18, 2-20, 6-24, 8-26.
    y edges are 1 mod 3. 1, 4, 7, 10. 0-6, 2-8, 18-24, 20-26.
    z edges are 2 mod 3. 2, 5, 8, 11. 0-2, 6-8, 18-20, 24-26.
    */
    ArrayList<P3dFace> faces = new ArrayList<>(6);
    P3dLine[] fbuffer = new P3dLine[]{this.edges.get(0),this.edges.get(1),this.edges.get(6),this.edges.get(7)};
    faces.set(0,new P3dFace(fbuffer));//back
    P3dLine[] fbuffer2 = new P3dLine[]{this.edges.get(0),this.edges.get(8),this.edges.get(2),this.edges.get(5)};
    faces.set(0,new P3dFace(fbuffer2));//bottom
    P3dLine[] fbuffer3 = new P3dLine[]{this.edges.get(1),this.edges.get(5),this.edges.get(4),this.edges.get(2)};
    faces.set(0,new P3dFace(fbuffer3));//left
    fbuffer = new P3dLine[]{this.edges.get(3),this.edges.get(10),this.edges.get(9),this.edges.get(4)};
    faces.set(0,new P3dFace(fbuffer));//front
    fbuffer2 = new P3dLine[]{this.edges.get(9),this.edges.get(11),this.edges.get(6),this.edges.get(0)};
    faces.set(0,new P3dFace(fbuffer2));//top
    fbuffer3 = new P3dLine[]{this.edges.get(7),this.edges.get(11),this.edges.get(10),this.edges.get(8)};
    faces.set(0,new P3dFace(fbuffer3));//right
    this.faces=faces;//all because you couldn't be bothered to add the BARE MINIMUM. Shame on you.
    this.ID=Integer.toString(primCounter);
    primCounter++;
  }
  
  P3dShape(P3dPoint[] points, P3dLine[] edges, P3dFace[] faces, String ID, boolean solid, float[] scale, float[] rot, float[] pos){
    ArrayList<P3dPoint> vertices = new ArrayList<>();
    for (P3dPoint p : points) {
      vertices.add(p);
    }
    vertices.trimToSize();
    this.vertices=vertices;
    this.edges=new ArrayList<>();
    for (P3dLine l : edges) {
      this.edges.add(l);
    }
    this.edges.trimToSize();
    this.faces=new ArrayList<>();
    for (P3dFace f : faces) {
      this.faces.add(f);
    }
    this.faces.trimToSize();
    this.ID=ID;
    this.solid=solid;
    this.scale=scale;
    this.position=pos;
    this.rotation=rot;
    this.verticeVectors=new ArrayList<PVector>(this.vertices.size());
    for (int i=0; i < this.vertices.size();i++){
      this.verticeVectors.set(i,this.vertices.get(i).getPosition());
    }
    //SEE HOW MUCH FASTER THAT WAS??? YOU MONSTER...
  }
}

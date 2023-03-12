# SculpTron-RWaC-
The New Version of the RWaC initiative program, AZATHOTH!

This originally was going to be a GP Blocks project. However, although that door hasn't fully shut yet, it is definitely blocked off. Maybe we can excavate the doorway later.

This will be made in Processing, a spin-off library of the good old Java programming language. It has full compatibility with Raspberry Pis, and Arduino was built with Processing, so this will be the one we use.

With the strongest copyleft license available, development is now slowly underway. Having to rewrite the graphical sections, so this is more tedious than before. 

THE GOOD NEWS:
We have NURBS support! that's right, we are making curved surfaces possible with Slic3r! However...

THE BAD NEWS:
Due to the fact of Java Inheritance structuring preventing more than one class being a superclass of another, this is going to take some finessing to get the desired result. Hopefully, this won't take too much fussing with the code. 

THE BREAKDOWN OF WHAT'S WHAT:

P3dPoint is a subclass of PVector, because PVector is good, but I needed a way of identifying the individual points and displaying them uniformly.

P3dLine is a subclass of NurbsCurve, from the NURBS library. This is intentionally done, as the NurbsCurve class is an extension of PVector. This adds a lot of extra constructors since it now has to handle inputs of PVector[] AND P3dPoint[]. Still optimizing this one.

P3dFace is a subclass of NurbsSurface, which is also from the Nurbs library. NurbsSurface is an extension of NurbsCurve. This is the major focus of concentration currently, as this is not exactly ideal for calculations. A nurbs spline is wonderful, but a two dimensional one is very suspect to not be where it says it is... and we can't have a 3 dimensional shape that isn't a solid polyhedron/primitive object, otherwise we get a papery shell of zero width and zero structural stability.

P3dShape is currently not a subclass of any class, and is meant to be a reworked PShape for 3D use only. PShape works in 3 dimensions... just not in a user-friendly way. Having to reiterate vertexes multiple times is tedious, and it takes a total of 16 vertice assignments to make the 12 vertices of a cube properly connected to each other, and then there's the problem of the shapes not always looking right with fill or nofill, so I'm just going to redesign it from the ground up with more geometrically convenient and intuitive code. This is unfinished, do not try to use this yet. Please.

"gui" is the interface for the user to conveniently make the shape they want, and provides multiple interactive features. This is from the G4P GUI designer, please do not touch this class.

Azathoth is the base program, the Main class. This starts up the whole thing. It is far from finished, but it's still (semi-) functional so far.

class Cherry extends Topping
{
  float Radius;
  public Cherry( Scoop setOnScoop )
  {
    super( setOnScoop );
    Radius = setOnScoop.Radius * 0.25;
  }
  
  public void draw()
  {
    pushMatrix();
    translateToLocation();
    fill( 255, 0, 0 );
    sphere( Radius );
     // TODO: Add stem!
    popMatrix();
  }
}

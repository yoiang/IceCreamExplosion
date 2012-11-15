class Sprinkle extends Topping
{
  color Color;
  // scale?
  public Sprinkle( Scoop setOnScoop )
  {
    super( setOnScoop );
  }
  
  public void draw()
  {
    pushMatrix();
    translateToLocation();
    fill( Color );
    // TODO: rotate to perpendicular to sphere?
    
    popMatrix();
  }
}

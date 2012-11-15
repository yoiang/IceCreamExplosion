abstract class Topping extends FallingObject
{
  Scoop onScoop;
  float RotateY;
  public Topping(Scoop setOnScoop)
  {
    super( new PVector( random( -setOnScoop.Radius / 2.0f, setOnScoop.Radius / 2.0f ), -1.0f * setOnScoop.Radius, random( -setOnScoop.Radius / 2.0f, setOnScoop.Radius / 2.0f ) ), -100.0f, 50.0f );
    
    onScoop = setOnScoop;
    

    RotateY = random( 0, 360 );

  }
  
  public abstract void draw();
  
  public void translateToLocation()
  {
    super.translateToLocation();
    rotateY( RotateY );    
  }
}

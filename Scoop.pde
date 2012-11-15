class Scoop extends FallingObject
{
  public float Radius;
  color FillColor;
  public float RandomRotateYRate, RandomRotateY;

  ArrayList Toppings;

  public Scoop( PVector setLocation, float setFallingOffsetY, float setRadius )
  {
    super( setLocation, setFallingOffsetY, 100.0f );

    Radius = setRadius;

    Location = new PVector( setLocation.x, setLocation.y, setLocation.z );

    FillColor = color( random( 50, 255 ), random( 50, 255 ), random( 50, 255 ) );

    Toppings = new ArrayList(); // TODO: MOVE TO UHH
    Toppings.add( new Cherry( this ) );

    RandomRotateY = random( 0, 360 );
    RandomRotateYRate = random( -1, 1 );
  }

  public void draw( float RotateY )
  {
    translateToLocation();
    fill( FillColor );

    pushMatrix();
    rotateY( RotateY * RandomRotateYRate );   
    pushMatrix();
    rotateY( RandomRotateY );   
    texturedSphere( Radius, IceCreamTexture );
    popMatrix();

    drawToppings();
    popMatrix();
  }

  public void drawToppings()
  {
    for( int TravToppings = 0; TravToppings < Toppings.size(); ++TravToppings )
    {
      Topping drawTopping;
      drawTopping = (Topping)Toppings.get( TravToppings );
      if ( isSettled() && !drawTopping.isSettled() )
      {
        drawTopping.settle();
      }
      drawTopping.draw();
    }
  }
}


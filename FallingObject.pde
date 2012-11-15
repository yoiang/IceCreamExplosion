class FallingObject
{
  public PVector Location; // TODO: change to rotation offsets and drop translation?
  public float FallingOffsetY;
  public float FallingRate; // TODO: change to per time value
  
  public FallingObject( PVector setLocation, float setFallingOffsetY, float setFallingRate )
  {
    Location = new PVector( setLocation.x, setLocation.y, setLocation.z );
    FallingOffsetY = setFallingOffsetY;    
    FallingRate = setFallingRate;
  }
  
  public boolean isSettled()
  {
    return FallingOffsetY == 0;
  }

  public void settle()
  {
    if ( FallingRate < 0 ) // TODO: is this necessary? assume always falling in positive Y?
    {
      if ( FallingOffsetY > 0 )
      {
        FallingOffsetY += FallingRate;
      } 
      else if ( FallingOffsetY < 0 )
      {
        FallingOffsetY = 0;
      }
    } else if ( FallingRate > 0 )
    {
      if ( FallingOffsetY < 0 )
      {
        FallingOffsetY += FallingRate;
      } 
      else if ( FallingOffsetY > 0 )
      {
        FallingOffsetY = 0;
      }
    }
  }
  
  public void translateToLocation()
  {
    translate( Location.x, Location.y + FallingOffsetY, Location.z );
  }
}

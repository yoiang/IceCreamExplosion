import processing.video.*;

PImage Counter, Cone, IceCreamTexture;
ArrayList Scoops;
float TotalOffset;
float ScreenScale;

Capture Background;

void setup() {
  size(640, 480, P3D);
  
  String[] CounterImages = { "Counter1.jpg", "Counter2.jpg", "Counter3.jpg" };
  Counter = loadImage( CounterImages[ (int)random(0, 2) ] );
  
  Cone = loadImage("icpfront.png");
  IceCreamTexture = loadImage("IceCreamTexture.jpg");
  noStroke();
  sphereDetail(20);
  
  texturedSphereDetail(10);
  
  Scoops = new ArrayList();
  TotalOffset = 0.0f;
  ScreenScale = 1.0f;
  
  String[] cameras = Capture.list();
  if ( cameras.length > 0 )
  {
    Background = new Capture(this, cameras[0]);
    Background.start();
  } else
  {
  }
}

void draw() {
  if ( Background != null && Background.available() )
  {
    Background.read();
    image(Background, 0, 0);
  }

  if ( TotalOffset * ScreenScale > height / 2 - 50 * ScreenScale )
  {
    ScreenScale *= 0.5;
  }

  background(color(50,50,255));

  lights();
  translate(width / 2, height / 2 );
  scale( ScreenScale, ScreenScale, ScreenScale );
  
  drawBackground();
  drawCounter();
  
  pushMatrix();  
  float RotateY = map(mouseX, 0, width, -PI, PI);
  for( int TravScoops = 0; TravScoops < Scoops.size(); ++TravScoops )
  {
    Scoop drawScoop = (Scoop)( Scoops.get(TravScoops) );
    if ( !drawScoop.isSettled() )
    {
      drawScoop.settle();
    }
    drawScoop.draw( RotateY );
  }
  popMatrix();
  
  pushMatrix();
  translate(0,0,100);
  fill( 255 );
  drawCone();
  popMatrix();
}

void mouseClicked()
{
//  println("Mouse Clicked"); // TODO: Why is mouse click not always registering?
  if ( Scoops.size() > 0 )
  {
    Scoop PreviousScoop = (Scoop)Scoops.get( Scoops.size() - 1 );
    if ( !PreviousScoop.isSettled() ) // TODO: better way to prevent flood?
    {
      return;
    }
    
    float setRadius = random( PreviousScoop.Radius / 1.5, PreviousScoop.Radius + PreviousScoop.Radius / 10);
    float setFallingOffsetY = -0.8 * height / ScreenScale;

    Scoop addScoop = new Scoop( new PVector( 0.0f, -1 * PreviousScoop.Radius, 0.0f ), setFallingOffsetY, setRadius );
    Scoops.add( addScoop );

    TotalOffset += abs( addScoop.Location.y );

  } else
  {
    float setFallingOffsetY = -0.8 * height / ScreenScale;

    Scoop addScoop = new Scoop( new PVector( 0.0f, -10.0f, 0.0f ), setFallingOffsetY, 88.0f );
    Scoops.add( addScoop );

    TotalOffset += abs( addScoop.Location.y );
  }
}

void keyPressed() 
{
  switch ( key )
  {
    case 'r':
      Scoops = new ArrayList();
      TotalOffset = 0.0f;
      ScreenScale = 1.0f;
    break;
  }
}

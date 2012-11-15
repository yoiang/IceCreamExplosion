
void drawCounter()
{
  beginShape(QUAD_STRIP);
  textureMode(NORMAL);
  texture(Counter);

  vertex(-900, 190, -500, 0, 0);
  vertex(900, 190, -500, 1, 0);
  vertex(-900, 190, 500, 0, 1);
  vertex(900, 190, 500, 1, 1);

  vertex(-900, 210, 510, 0, 0);
  vertex(900, 210, 510, 1, 0 );
  
  vertex(-900, 230, 510, 0, 0);
  vertex(900, 230, 510, 1, 0 );

  vertex(-900, 230, 400, 0, 1);
  vertex(900, 230, 400, 1, 1 );

  vertex(-900, 1000, 400, 0, 0);
  vertex(900, 1000, 400, 1, 0 );

  endShape();

  beginShape(QUAD_STRIP);
  fill( 0 );

  vertex(-5000, 1000, -500);
  vertex(5000, 1000, -500);
  vertex(-5000, 1000, 5000);
  vertex(5000, 1000, 5000);
  
  endShape();  
}

void drawCone() // TODO: shadow cone on counter
{
  beginShape();
  textureMode(NORMAL);
  texture(Cone);
  vertex(-72, 0, 0, 0, 0);
  vertex(72, 0, 0, 1, 0);
  vertex(72, 190, 0, 1, 1);
  vertex(-72, 190, 0, 0, 1);
  endShape();
}

void drawBackground()
{
  if ( Background != null )
  {
    beginShape(QUAD_STRIP);
    textureMode(NORMAL);
    texture(Background);
  
    vertex(-900, -700, -500, 0, 0);
    vertex(900, -700, -500, 1, 0);
    vertex(-900, 500, -500, 0, 1);
    vertex(900, 500, -500, 1, 1);
    endShape();
//    image( Background, 0, 0 );    
  }
}
 

///////////////////////////////////////////////////////////////////
// texturedSphere and texturedSphereDetail from debucode in http://processing.org/discourse/yabb2/YaBB.pl?board=OpenGL;action=display;num=1159148484
// thank you!!

float PI = 3.14159f;
float texturedSphereX[][];
float texturedSphereY[][];
float texturedSphereZ[][];
float texturedSphereU[][];
float texturedSphereV[][];
int texturedSphereDetail;

/**
 * Set the detail level for textured spheres
 */
void texturedSphereDetail(int detail) {
  if (detail == texturedSphereDetail) return;
  
  texturedSphereDetail = detail;
  
  // construct the underlying vertex and uv map data
  
  float step = PI / detail;
  float ustep = 0.5f / detail;
  float vstep = 1.0f / detail;

  texturedSphereX = new float[detail + 1][2 * detail + 1];
  texturedSphereY = new float[detail + 1][2 * detail + 1];
  texturedSphereZ = new float[detail + 1][2 * detail + 1];
  texturedSphereU = new float[detail + 1][2 * detail + 1];
  texturedSphereV = new float[detail + 1][2 * detail + 1];
  
  for (int i = 0; i <= detail; i++) {
    float theta = step * i;
    float y = cos(theta);
    float sin_theta = sin(theta);
    float v = 1.0f - vstep * i;
    
    for (int j = 0; j <= 2 * detail; j++) {
	float phi = step * j;
	float x = sin_theta * cos(phi);
	float z = sin_theta * sin(phi);
	
	float u = 1.0f - ustep * j;
	
	texturedSphereX[i][j] = x;
	texturedSphereY[i][j] = y;
	texturedSphereZ[i][j] = z;
	texturedSphereU[i][j] = u;
	texturedSphereV[i][j] = v;
	
    }  
    
  }
}

/**
 * Create a textured sphere with the supplied radius and material
 */
void texturedSphere(float r, PImage material) {
  // build the sphere by stacking up cross sections
  // KLUDGE: the poles could be built more efficiently
  int nexti;
  for (int i = 0; i < texturedSphereDetail; i = nexti) {
    nexti = i + 1;
    beginShape(QUAD_STRIP);
    texture(material);
    textureMode(IMAGE);
    for (int j = 0; j <= 2 * texturedSphereDetail; j++) {
	float u = material.width * texturedSphereU[i][j];

	float x1 = r * texturedSphereX[i][j];
	float y1 = r * texturedSphereY[i][j];
	float z1 = r * texturedSphereZ[i][j];
	float v1 = material.height * texturedSphereV[i][j];

	float x2 = r * texturedSphereX[nexti][j];
	float y2 = r * texturedSphereY[nexti][j];
	float z2 = r * texturedSphereZ[nexti][j];
	float v2 = material.height * texturedSphereV[nexti][j];
	
	vertex(x1, y1, z1, u, v1);
	vertex(x2, y2, z2, u, v2);
    }  
    endShape();
  }
  
}



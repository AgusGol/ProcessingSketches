int numCircles = 50;
Circle[] circles = new Circle[numCircles];

void setup() {
  size(1000, 1000);
  background(0);
  smooth();

  for (int i = 0; i < numCircles; i++) {
    circles[i] = new Circle();
  }
}

void draw() {
  background(0);

  for (int i = 0; i < numCircles; i++) {
    circles[i].update(i);
    circles[i].draw();
  }
}

class Circle {
  float x, y, dx, dy;
  float radius;
  ArrayList<PVector> positions; 

  
  Circle() {
    x = random(width);
    y = random(height);
    dx = random(-0.01, 0.01);
    dy = random(-0.01, 0.01);
    radius = random(1, 1);
     positions = new ArrayList<PVector>(); // Inicializa la lista de posiciones
  }

void update(int i) {
  positions.add(new PVector(x, y));
    float d = dist(x, y, mouseX, mouseY);
  // Calcula nuevas velocidades utilizando la función seno y el índice del círculo
  dx = sin(frameCount * 0.01 + i) ;//+ (mouseX - x) / d * 2;
  dy = cos(frameCount * 0.02 + i) ;//+ (mouseY - y) / d * 2;


  x += dx;
  y += dy;

  // Comprobamos si el círculo ha llegado al borde de la pantalla
  if (x < 0 || x > width) {
    dx *= -1;
  }
  if (y < 0 || y > height) {
    dy *= -1;
  }
}
void drawLineToFarthestCircle() {
  // Encuentra el círculo más lejano y almacena sus coordenadas
  float farthest = 0;
  float farthestX = 0;
  float farthestY = 0;
  for (int i = 0; i < numCircles; i++) {
    if (circles[i] != this) {
      float d = dist(x, y, circles[i].x, circles[i].y);
      if (d > farthest) {
        farthest = d;
        farthestX = circles[i].x;
        farthestY = circles[i].y;
      }
    }
  }

  // Dibuja la línea azul hacia el círculo más lejano
  stroke(0, 0, 255);
  line(x, y, farthestX, farthestY);
}
  void draw() {
    // Encuentra el círculo más cercano y almacena sus coordenadas
    float nearest = 1000000;
    float nearestX = 0;
    float nearestY = 0;
    for (int i = 0; i < numCircles; i++) {
      if (circles[i] != this) {
        float d = dist(x, y, circles[i].x, circles[i].y);
        if (d < nearest) {
          nearest = d;
          nearestX = circles[i].x;
          nearestY = circles[i].y;
        }
      }
    }
    //para dibujar el rastro
    for (int i = 0; i < positions.size() - 1; i++) {
    PVector pos1 = positions.get(i);
    PVector pos2 = positions.get(i + 1);
    line(pos1.x, pos1.y, pos2.x, pos2.y);
  }

    // Dibuja la línea blanca hacia el círculo más cercano
    stroke(255);
    line(x, y, nearestX, nearestY);

    // Dibuja el círculo blanco relleno
    noStroke();
    fill(255);
    ellipse(x, y, radius*2, radius*2);
    
    drawLineToFarthestCircle();
    
  }
  

  
  


}

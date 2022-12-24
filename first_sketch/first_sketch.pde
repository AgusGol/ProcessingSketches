int numCircles = 200;
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

  Circle() {
    x = random(width);
    y = random(height);
    dx = random(-0.01, 0.01);
    dy = random(-0.01, 0.01);
    radius = random(1, 1);
  }

void update(int i) {
  // Calcula nuevas velocidades utilizando la función seno y el índice del círculo
  dx = sin(frameCount * 0.01 + i) * 2;
  dy = cos(frameCount * 0.02 + i) * 2;

  // Añade la velocidad a la posición para mover el círculo
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

    // Dibuja la línea blanca hacia el círculo más cercano
    stroke(255);
    line(x, y, nearestX, nearestY);

    // Dibuja el círculo blanco relleno
    noStroke();
    fill(255);
    ellipse(x, y, radius*2, radius*2);
  }
}



// Declare variables for the animation
int numCircles = 100;
float circleSize = 2;
float[] xPos;
float[] yPos;
float[] xSpeed;
float[] ySpeed;
color[] fillColor;
int[] pairs; // Array to store the pairs for each circle

void setup() {
  // Set up the canvas size and background color
  size(1500, 800);
  // Set up the frame rate for the animation
  frameRate(30);

background(0,0,0);


  // Initialize the arrays for the animation
  xPos = new float[numCircles];
  yPos = new float[numCircles];
  xSpeed = new float[numCircles];
  ySpeed = new float[numCircles];
  fillColor = new color[numCircles];
  pairs = new int[numCircles];
  print(pairs);
  // Initialize the variables for each circle
  for (int i = 0; i < numCircles; i++) {
    xPos[i] = width/2;
    yPos[i] = height/2;
    xSpeed[i] = random(-5, 5);
    ySpeed[i] = random(-5, 5);
    fillColor[i] = color(random(255), random(255), random(255));
  }

  // Randomly assign the pairs for each circle
  for (int i = 0; i < numCircles; i++) {
    pairs[i] = int(random(numCircles));
  }
}

void draw() {
  // Clear the canvas each frame
  background(0,0,0);

  // Update the position of each circle
  for (int i = 0; i < numCircles; i++) {
    // Calculate the new position of the circle using polar coordinates
    float radius = 200 + i/(i+1);
    float angle = frameCount/30.0 + i*2*PI/numCircles + 100/(i+1);
    xPos[i] = width/2 + radius*cos(angle) + sin(frameCount/60.0 + i*2*PI/numCircles)*100;
    yPos[i] = height/2 + radius*sin(angle) + cos(frameCount/60.0 + i*2*PI/numCircles)*50;
    // Check if the circle has reached the edge of the canvas
    if (xPos[i] < 0 || xPos[i] > width) {
      xSpeed[i] *= -1;
    }
    if (yPos[i] < 0 || yPos[i] > height) {
      ySpeed[i] *= -1;
    }

    // Draw the circle
    fill(fillColor[i]);
    noStroke();
    ellipse(xPos[i], yPos[i], circleSize, circleSize);

    // Draw the line connecting the paired circle
    stroke(255);
    strokeWeight(circleSize);
    line(xPos[i], yPos[i], xPos[pairs[i]], yPos[pairs[i]]);
  
   // Find the closest two circles to the current circle
    float closest1 = dist(xPos[i], yPos[i], xPos[0], yPos[0]);
    int closestIndex1 = 0;
    float closest2 = dist(xPos[i], yPos[i], xPos[1], yPos[1]);
    int closestIndex2 = 1;
    for (int j = 0; j < numCircles; j++) {
      float distance = dist(xPos[i], yPos[i], xPos[j], yPos[j]);
      if (distance < closest1) {
        closest2 = closest1;
        closestIndex2 = closestIndex1;
        closest1 = distance;
        closestIndex1 = j;
      } else if (distance < closest2) {
        closest2 = distance;
        closestIndex2 = j;
      }
    }

    // Draw the lines connecting the current circle to its closest two circles
    stroke(255);
    strokeWeight(circleSize);
    line(xPos[i], yPos[i], xPos[closestIndex1], yPos[closestIndex1]);
    line(xPos[i], yPos[i], xPos[closestIndex2], yPos[closestIndex2]);
  }
}
  
 



void mousePressed() {
  // Randomly assign the pairs for each circle when the mouse is clicked
  for (int i = 0; i < numCircles; i++) {
    pairs[i] = int(random(numCircles));
  }
}

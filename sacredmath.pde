Grate grate;
//import com.hamoid.*;
//VideoExport videoExport;

void settings() {
  size(800, 800, P2D);
  //fullScreen(P2D);
}



void setup() {
  grate = new Grate(width/10, height/10);
    background(palette[0]);
  stroke(palette[1]);
  grate.draw();
  noLoop();

  surface.setLocation(0,0);
}
float randOffset = random(0, 1);
void draw() {

}

int pointer = 0;

void keyPressed() {
  if (key == 'q') {
    grate.fillRandom();
    } else if (key =='s') {
    saveFrame(pointer + ".png");
  } 
  background(palette[0]);
  stroke(palette[1]);
  grate.draw();
}



void mouseClicked() {
  int i = mouseX/grate.cellSize;
  int j = mouseY/grate.cellSize;
  println(i, j);
  grate.valueTable[i][j]++;
  if ( grate.valueTable[i][j] > 3) grate.valueTable[i][j] = 0 ;
  println(grate.valueTable[i][j]);
  background(10);
  grate.draw();
}



class Grate {
  int sizeX, sizeY, cellSize;
  int[][] valueTable;
  Grate(int _sizeX, int _sizeY) {
    sizeX = _sizeX;
    sizeY = _sizeY;
    cellSize = width/sizeX;
    valueTable = new int[sizeX][sizeY];
    fillRandom();
  }
  void fillRandom() {
    for (int i = 0; i< sizeX; i++) {
      for (int j = 0; j<sizeY; j++) {
        valueTable[i][j] = (int)random(0, 4);//randomBool();
        //print(valueTable[i][j]);
      }
     // println();
    }
  }
  void update() {
    for (int i= 0; i<(sizeX*sizeY)/100; i++) {
      if (random(0, 100)<10) valueTable[(int)random(0, sizeX)][(int)random(0, sizeY)] = (int)random(0, 4);// randomBool();
    }
  }
  void draw() {
    for (int i = 0; i< sizeX; i++) {
      for (int j = 0; j<sizeY; j++) {
        //stroke(220);
        if (valueTable[i][j] == 0 || valueTable[i][j] == 1) {
          //line(i*cellSize, j*cellSize, (i+1)*cellSize, (j+1)*cellSize);
          //noStroke();
          //if ( valueTable[i][j] == 0) fill(palette[1]);
          //else fill(palette[2]);
          //rect(i*cellSize, j*cellSize, cellSize, cellSize);
          //if ( valueTable[i][j] == 1) fill(palette[1]);
          //else fill(palette[2]);
          //triangle(i*cellSize, j*cellSize, (i+1)*cellSize, (j+1)*cellSize, i*cellSize, (j+1)*cellSize);
        } else {
          line((i+1)*cellSize, j*cellSize, i*cellSize, (j+1)*cellSize);
          //noStroke();
          //if ( valueTable[i][j] == 2) fill(palette[2]);
          //else fill(palette[1]);
          //rect(i*cellSize, j*cellSize, cellSize, cellSize);
          //if ( valueTable[i][j] == 3) fill(palette[2]);
          //else fill(palette[1]);
          //triangle((i+1)*cellSize, j*cellSize, i*cellSize, (j+1)*cellSize, (i+1)*cellSize, (j+1)*cellSize);
        }
      }
    }
  }

boolean randomBool() {
  return random(1) > .5;
}

color[] palette = {
    color(27/2, 45/2, 54/2), 
  color(255, 251, 204), 
  color(0, 128, 128), 
  color(164, 222, 191), 
  color  (239, 0, 65), 
  color(255, 227, 61), 
  color  (255, 91, 215)
};

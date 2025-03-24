Grate grate;
//import com.hamoid.*;
//VideoExport videoExport;

void settings() {
  size(800, 800, P2D);
  //fullScreen(P2D);
}
void setup() {
  //grate = new Grate(100, 50);
  grate = new Grate(width/10, height/10);
      background(palette[0]);
  stroke(palette[1]);
  grate.draw();
  noLoop();
    //videoExport = new VideoExport(this);
  //videoExport.setFrameRate(60);
  //videoExport.startMovie();
  surface.setLocation(0,0);
}
float randOffset = random(0, 1);
void draw() {

  //grate.update();
  //randOffset+=0.005;
  //for (int i = 0; i< grate.sizeX; i++) {
  //  for (int j = 0; j<grate.sizeY; j++) {
  //    //grate.valueTable[i][j] = int(4*noise(float(i)/10, float(j)/10, randOffset));
  //    float nois = map(noise(float(i)/50,float(j)/50,randOffset),0,1,0,2);
  //    //float nois = noise(dist(i,j,grate.sizeX/2,grate.sizeY/2),randOffset);
  //    //grate.valueTable[i][j] =  int(nois*(i/(abs(i-j)+1)+j/(abs(j-i)+1)))%4;
  //    grate.valueTable[i][j] = int(nois*dist(i,j,width/2/grate.cellSize,height/2/grate.cellSize))%4;
  //    //grate.valueTable[i][j] = int(nois*(i/10+j/10))%4;
  //    //grate.valueTable[i][j] = int(int(nois)%2*dist(i,j,width/2/grate.cellSize,height/2/grate.cellSize) + ((1-int(nois)%2)*int(sq(j+i))))%4;
      
  //  }
  //}
  //grate.draw();
  //videoExport.saveFrame();
}
int pointer = -1;
void keyPressed() {
  if (key == 'q') {
    grate.fillRandom();
    } else if (key =='s') {
    saveFrame(pointer + ".png");
  } else if (key =='w') {
    background(10);
    pointer++; if(pointer>17) pointer = 0;
    println(pointer);
    float randOffset = random(0, 1);
    for (int i = 0; i< grate.sizeX; i++) {
      for (int j = 0; j<grate.sizeY; j++) {
        switch (pointer){
        case 0: grate.valueTable[i][j] = int((float)i/10-(float)j/10+(sq((float)i))/100-sq((float)j)/100)%4;//(i+j)%4;
        break;
        case 1:grate.valueTable[i][j] = abs(i-j)%4;
        break;
        case 2:grate.valueTable[i][j] = int(sqrt(j+i))%4;
        break;
        case 3:grate.valueTable[i][j] = int(sq(j+i))%4;
        break;
        case 4:grate.valueTable[i][j] = int(sq(i)+sq(j))%4;
        break;
        case 5:grate.valueTable[i][j] = int(dist(i,j,j,i))%4;
        break;
        case 6: grate.valueTable[i][j] = int(dist(i*grate.cellSize,j*grate.cellSize,width/2,height/2))%4;
        break;case 7:grate.valueTable[i][j] = int(dist(i,j,width/2/grate.cellSize,height/2/grate.cellSize))%4;
        break;case 8:grate.valueTable[i][j] = int((i+j)/10)%4;
        break;case 9:grate.valueTable[i][j] = int((i/10+j)/10)%4;
        break;case 10:grate.valueTable[i][j] = int(i/10+j/10)%4;
        break;case 11:grate.valueTable[i][j] = int(i/10+j/20)%4;
        break;case 12:grate.valueTable[i][j] = int( abs(4*sin(i+j)) )%4;
        break;case 13:grate.valueTable[i][j] =  (abs(i-grate.sizeX/2)+abs(j-grate.sizeY/2))%4;
        break;case 14:grate.valueTable[i][j] =  int((i/(abs(i-j)+1)+j/(abs(j-i)+1)))%4;
        break;case 15:grate.valueTable[i][j] =  int((i/(abs(i-j)%10+1)+j/(abs(j-i)%10+1)))%4;
        break;case 16:grate.valueTable[i][j] = int(4*noise(float(i)/10, float(j)/10, randOffset));
        break;case 17:grate.valueTable[i][j] = int (noise(float(i)/100,float(j)/100)*(i+j))%4;
        break;
        }
       float nois = noise(float(i)/100,float(j)/100);
        //grate.valueTable[i][j] = int(nois*(i/10+j/10))%4;  
        //grate.valueTable[i][j] = int(nois*dist(i,j,width/2/grate.cellSize,height/2/grate.cellSize))%4;
      }
    }
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

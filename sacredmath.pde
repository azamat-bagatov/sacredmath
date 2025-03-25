Grate grate;

void settings() {
  //size(1600, 1600, P2D);
  fullScreen(P2D,2);
}



void setup() {
  grate = new Grate(width/25, height/25);
    background(palette[0]);
  stroke(palette[1]);
  grate.draw();
  //noLoop();

  //surface.setLocation(0,0);
}

//float randOffset = random(0, 1);
void draw() {
drawBrushOutline();

}
void mouseClicked(){
  if(mouseButton == RIGHT) {
    if(BRUSHVAL == 0 ) BRUSHVAL = 1;
    else BRUSHVAL = 0;
    println("right click");
  }
}
int pointer = 0;

void keyPressed() {
  if (key == 'q') {
    if(BRUSHVAL == 0 ) BRUSHVAL = 1;
    else BRUSHVAL = 0;
    } else if (key =='s') {
    saveFrame(pointer + ".png");
  } 
  background(palette[0]);
  stroke(palette[1]);
  grate.draw();
}

int brushSize = 60;
boolean pressFlag = false;
boolean[][] changedVals;
int prev_i, prev_j = 0;
int BRUSHVAL = 0;
void mouseReleased(){
  pressFlag = false;
}

void mouseDragged() 
{
    if(!pressFlag) {
      pressFlag = false; 
      changedVals = new boolean[grate.sizeX][grate.sizeY];
    }
    
    int i = mouseX/grate.cellSize;
    int j = mouseY/grate.cellSize;
    
    if( i != prev_i || j != prev_j){
      prev_i = i; prev_j = j;
          //modify all of the cells around and store in the matrix
      int sqStartX = i -  brushSize;
      int sqStartY = j - brushSize;
      int sqEndX = i + brushSize;
      int sqEndY = j + brushSize;
    
    for(int x = sqStartX; x <= sqEndX; x++){
      for(int y = sqStartY; y <= sqEndY; y++){
          if( dist(x*grate.cellSize,y*grate.cellSize,mouseX,mouseY) < brushSize) {
               grate.set(x,y,BRUSHVAL);
               grate.redraw(x,y);
          }
      }
    }
    }
         
}


int pri, prj = 0;


void drawBrushOutline(){
    int i = mouseX/grate.cellSize;
    int j = mouseY/grate.cellSize;
    int cellSize = grate.cellSize; 
    
    int sqStartX = pri -  brushSize;
    int sqStartY = prj - brushSize;
      int sqEndX = pri + brushSize;
      int sqEndY = prj + brushSize;
    
   grate.draw();
    //if(pri != i || prj != j){
    //  noStroke();
    //  fill(palette[0]);
      
    //  for(int x = sqStartX; x <= sqEndX; x++){
    //  for(int y = sqStartY; y <= sqEndY; y++){
    //      if( dist(x*cellSize,y*cellSize,pri*cellSize,prj*cellSize) < brushSize) {
    //           rect(x*cellSize, y*cellSize, cellSize, cellSize);
    //      }
    //  }
    //}
    //  pri = i; prj = j;
    //}
    
       sqStartX = i -  brushSize;
       sqStartY = j - brushSize;
       sqEndX = i + brushSize;
       sqEndY = j + brushSize;
       //modify all of the cells around and store in the matrix

      int cnt = 0;
      for(int x = sqStartX; x <= sqEndX; x++){
      for(int y = sqStartY; y <= sqEndY; y++){
          if( dist(x*cellSize,y*cellSize,i*cellSize,j*cellSize) < brushSize) {
               cnt++;
               noStroke();
               fill(250,96);
               if(BRUSHVAL == 0) triangle(x*cellSize, y*cellSize, (x+1)*cellSize, (y+1)*cellSize, x*cellSize, (y+1)*cellSize);
               else triangle((x+1)*cellSize, y*cellSize, x*cellSize, (y+1)*cellSize, (x+1)*cellSize, (y+1)*cellSize);
          }
      }
    
}

}
void mouseWheel(MouseEvent event) {
  float e = event.getCount();
  if(e > 0) brushSize+=10;
  else brushSize-=10; 
  if(brushSize<10) brushSize = 10;
}

class Grate {
  int sizeX, sizeY, cellSize;
  int[][] valueTable;
  Grate(int _sizeX, int _sizeY) {
    sizeX = _sizeX;
    sizeY = _sizeY+1;
    cellSize = width/sizeX;
    valueTable = new int[sizeX][sizeY];
    fillRandom();
  }
  void fillRandom() {
    for (int i = 0; i< sizeX; i++) {
      for (int j = 0; j<sizeY; j++) {
        valueTable[i][j] = (int)random(0, 2);//randomBool();
        //print(valueTable[i][j]);
      }
     // println();
    }
  }

  void set(int x, int y, int val){
      //TODO if
      if( inbound(x,y) )valueTable[x][y] = val;
  }
  
  boolean inbound(int x, int y){
    if(x < 0 || x > sizeX-1 || y < 0 || y > sizeY-1) return false;
    else return true;
  }
  void redraw(int i, int j){
    if( inbound(i,j) ){
          noStroke();
         fill(palette[0]);
         rect(i*cellSize, j*cellSize, cellSize, cellSize);
         stroke(palette[1]);
         strokeWeight(5);
          if (valueTable[i][j] == 0 ) {
          line(i*cellSize, j*cellSize, (i+1)*cellSize, (j+1)*cellSize);
          //noStroke();
          //if ( valueTable[i][j] == 0) fill(palette[1]);
          //else fill(palette[2]);
          //rect(i*cellSize, j*cellSize, cellSize, cellSize);
          //if ( valueTable[i][j] == 1) fill(palette[1]);
          //else fill(palette[2]);
          //triangle(i*cellSize, j*cellSize, (i+1)*cellSize, (j+1)*cellSize, i*cellSize, (j+1)*cellSize);
        } else if( valueTable[i][j] == 1) {
          //line((i+1)*cellSize, j*cellSize, i*cellSize, (j+1)*cellSize);
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
  void draw() {
    for (int i = 0; i< sizeX; i++) {
      for (int j = 0; j<sizeY; j++) {
        //stroke(220);
            redraw(i,j);
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

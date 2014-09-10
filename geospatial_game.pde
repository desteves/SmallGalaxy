import java.util.*;
import java.io.*;

////GPS RELATED//////////////////////////////////////////////
import ketai.sensors.*;
KetaiLocation location;
float longitude, latitude, altitude;
// ///ENDOF GPS CODE /////////////////////////////////////////

static int MAX_NUM_TOWERS = 5;
static int DEFAULT_START_X = 200;
static int DEFAULT_START_Y = 200;
static int PLAYER_MOVEMENT_AMT = 8;
static int MAX_BULLETS = 1;

ArrayList<Bullet> bulletsInPlay;
ArrayList<Tower> towers;
ArrayList<Tower> capturedTowers;

int playerX, playerY;
int score = 0;
int towerScore = 50;
int towerTimeOut = 3000;
int mapWidth, mapHeight;
int bulletWidth, bulletHeight;
int towerWidth, towerHeight;
int playerWidth, playerHeight;
float shootRadius = 1650;
int reloadTime = 500;
int shotTime = 0;
Random random = new Random();
boolean startScreen = false;
int startClicks = 0;
boolean playerInTower = false;


/////--------------------------????? HELP PAGE
boolean showHelpbox = false;
//boolean showStart = false;
int helpbox_WIDTH;
int helpbox_HEIGHT;
int helpbox_X;
int helpbox_Y;

int backbox_WIDTH;
int backbox_HEIGHT;
int backbox_X;
int backbox_Y;
/////--------------------------????? HELP PAGE

// /////////////////////////////////////////////
PImage img_CMU;
PImage img_CMU_MILKYWAY;
PImage img_CMU_ANDROMEDA;

PImage img_USR;
int s4_WIDTH = 1080;
int s4_HEIGHT = 1920;
float PRECISION = 10000.0;

// ///TODO ---------------UPDATE THESE VARIABLES-----------------------------------------------------------------------------------
///milkyway coordinates by default
float CMU_NORTH = 40.44696; // map latitude
float CMU_SOUTH = 40.44434; // map latitude
float CMU_EAST = -79.94963;// map longitude
float CMU_WEST = -79.94815; // map longitude

float CMU_NORTH_MILKYWAY = 40.44643; // map latitude
float CMU_SOUTH_MILKYWAY = 40.44377; // map latitude
float CMU_EAST_MILKYWAY = -79.94945;// map longitude
float CMU_WEST_MILKYWAY = -79.94797; // map longitude

float CMU_NORTH_ANDROMEDA = 40.448; // map latitude
float CMU_SOUTH_ANDROMEDA = 40.43; // map latitude
float CMU_EAST_ANDROMEDA = -79.94;// map longitude
float CMU_WEST_ANDROMEDA = -79.95; // map longitude
//----------------------------------------------------------------------------------------------------------------
int invade_WIDTH;
int invade_HEIGHT;
int invade_X;
int invade_Y;
boolean invadeClicked;
////////////two modes//////////////


//////////// easy mode
int milkyway_WIDTH;
int milkyway_HEIGHT;
int milkyway_X;
int milkyway_Y;
boolean milkywayClicked;

////////////////hard mode
int andromeda_WIDTH;
int andromeda_HEIGHT;
int andromeda_X;
int andromeda_Y;
boolean andromedaClicked;
// ///ENDOF //////////////////////////////////
PImage img_TOWER;
PImage img_TOWER_CAPTURED;
PImage img_SHOT;
PImage img_START;
PImage img_INVADE;
PImage img_INVADE_PRESSED;
PImage img_MILKYWAY;
PImage img_MILKYWAY_PRESSED;
PImage img_ANDROMEDA;
PImage img_ANDROMEDA_PRESSED;
PImage img_HEADER;
PImage img_HELP; /////--------------------------????? HELP PAGE
int header_WIDTH = 1080;
int header_HEIGHT = 150;
int header_X = header_WIDTH/2;
int header_Y = 20;

// ////////////TIMER/////////////////////////////////////////////////////
float startTime = 0; 
boolean isGameOver = true;
float finishTime = 0; 
// float bestTime = 0; 
// ////////////////////////////////////////////////////////////////
void setup() { 
  size(1080, 1920);
  startScreen = true;
/////--------------------------????? HELP PAGE
  helpbox_X = 700;
  helpbox_Y = 1480;
  helpbox_WIDTH = width - helpbox_X;
  helpbox_HEIGHT = height - helpbox_Y;
  
   backbox_X = 0;
   backbox_Y = 1760;
   backbox_WIDTH = 150;
   backbox_HEIGHT = height - 1760;
/////--------------------------????? HELP PAGE
  bulletWidth = 10;
  bulletHeight = 10;
  towerWidth = 20;
  towerHeight = 20;
  playerWidth = 20;
  playerHeight = 20;
  invade_WIDTH = width;
  invade_HEIGHT = 276;
  invade_X = 0;
  invade_Y = 1642;
  invadeClicked = false;
//----------------------------------------------------------------------------------------------------------------
  milkyway_WIDTH = 468;
  milkyway_HEIGHT = 58;
  milkyway_X = 100;
  milkyway_Y = 1450;
  milkywayClicked = false;
  andromeda_WIDTH = 468;
  andromeda_HEIGHT = 58;
  andromeda_X = 100;
  andromeda_Y = 1600;
  andromedaClicked = false;
  
  
  mapWidth = width;
  mapHeight = height - invade_HEIGHT;
//----------------------------------------------------------------------------------------------------------------
  textAlign(CENTER);
  imageMode(CENTER);
  img_SHOT = loadImage("shot2_small.png");
  img_TOWER = loadImage("Tower_medium_.png");
  img_TOWER_CAPTURED = loadImage("Tower_medium_captured.png");
  img_CMU = loadImage("milkyway_hue.png");/////////////////////temporary-------------------------------------------------------------------
  img_USR = loadImage("Player_small.png");
  img_START = loadImage("start_screen_2.png");
  img_INVADE = loadImage("Button_.png");
  img_INVADE_PRESSED = loadImage("Button_toggled.png");
  ///TODO ---------------UPDATE THESE VARIABLES-----------------------------------------------------------------------------------
  img_CMU_MILKYWAY = loadImage("milkyway_hue.png");
  img_CMU_ANDROMEDA = loadImage("cmu_135by240_hue.png");
  //----------------------------------------------------------------------------------------------------------------
  img_MILKYWAY = loadImage("milky_way_.png");
  img_MILKYWAY_PRESSED = loadImage("milky_way_toggled.png");
  img_ANDROMEDA = loadImage("andromeda_.png");
  img_ANDROMEDA_PRESSED = loadImage("andromeda_toggled.png");
  img_HEADER = loadImage("header_.png");
  img_HELP = loadImage("help_screen_.png");
  
  location = new KetaiLocation(this);
}

void resetGame() {
  // ////////////TIMER////////////////////////////////////
  startTime = 0;
  isGameOver = true;
  /////////////////////////// updated with gps coords
  playerX = s4_WIDTH
      - locationToPixel(longitude, CMU_EAST, CMU_WEST, s4_WIDTH);// DEFAULT_START_X;
  playerY = s4_HEIGHT
      - locationToPixel(latitude, CMU_NORTH, CMU_SOUTH, s4_HEIGHT);// DEFAULT_START_Y;
  if (playerX > s4_WIDTH)
    playerX = s4_WIDTH - 67;
  if (playerY > s4_HEIGHT)
    playerY = s4_HEIGHT - 128;
  //////////////////////reset towers
  bulletsInPlay = new ArrayList<Bullet>();
  towers = new ArrayList<Tower>();
  capturedTowers = new ArrayList<Tower>();
  playerInTower = false;
  shotTime = 0;
  ///////////randomly place towers with no overlap
  for (int i = 0; i < MAX_NUM_TOWERS; i++) {
    int towerX = random.nextInt(mapWidth - towerWidth) + towerWidth / 2;
    int towerY = random.nextInt(mapHeight - towerHeight - header_HEIGHT) + towerHeight / 2 + header_HEIGHT ;

    // If the new tower would be placed where the player is,
    // we try again
    if ((abs(towerX - playerX) < (towerWidth + playerWidth) / 2)
        && (abs(towerY - playerY) < (towerHeight + playerHeight) / 2)) {
      i--;
      continue;
    }
    // If the new tower would be placed on top of another tower,
    // we try again
    boolean overlapped = false;
    for (Tower tower : towers) {
      if ((abs(towerX - tower.getX()) < towerWidth)
          && (abs(towerY - tower.getY()) < towerHeight)) {
        overlapped = true;
        break;
      }
    }
    if (overlapped) {
      i--;
      continue;
    }
    towers.add(new Tower(towerX, towerY));
  }
}

public boolean clickTarget(float x, float y, float w, float h) //simple function to do hit testing
{
    return (mouseX > x && mouseX < x + w && mouseY > y && mouseY < y + h); //check to see if it is in button bounds
}

public void mouseReleased() {
    if (clickTarget(invade_X, invade_Y, invade_WIDTH, invade_HEIGHT)) {
      milkywayClicked = false;
    } else if (clickTarget(invade_X, invade_Y, invade_WIDTH, invade_HEIGHT)) {
      andromedaClicked = false;
    }
    if (clickTarget(invade_X, invade_Y, invade_WIDTH, invade_HEIGHT)) {
      invadeClicked = false;
  }  
}

void mousePressed() {  
  if (startScreen && clickTarget(helpbox_X, helpbox_Y, helpbox_WIDTH, helpbox_HEIGHT) ) {
    showHelpbox = true;
    startScreen = false;
    return;
  }
  if(showHelpbox) {
    showHelpbox = false;
    startScreen = true;
    return;
  }
  
  
  if (startScreen || isGameOver) {    
     if (clickTarget(milkyway_X, milkyway_Y, milkyway_WIDTH, milkyway_HEIGHT)) {  
      milkywayClicked = true;
      startClicks++;
      
      img_CMU = img_CMU_MILKYWAY;
      CMU_NORTH = CMU_NORTH_MILKYWAY; // map latitude
      CMU_SOUTH = CMU_SOUTH_MILKYWAY; // map latitude
      CMU_EAST = CMU_EAST_MILKYWAY;// map longitude      
      CMU_WEST = CMU_WEST_MILKYWAY; // map longitude
      
    } else if (clickTarget(andromeda_X, andromeda_Y, andromeda_WIDTH, andromeda_HEIGHT)) {  
      andromedaClicked = true;
      startClicks++;
      
      img_CMU = img_CMU_ANDROMEDA;
      CMU_NORTH = CMU_NORTH_ANDROMEDA; // map latitude
      CMU_SOUTH = CMU_SOUTH_ANDROMEDA; // map latitude
      CMU_EAST = CMU_EAST_ANDROMEDA;// map longitude      
      CMU_WEST = CMU_WEST_ANDROMEDA; // map longitude
      
    }    
  }
  if (startScreen && startClicks == 1) {       
    resetGame();
    startScreen = false;
    return;
  }
  if (isGameOver && startClicks == 2 ) { //first click
    isGameOver = false;
    startTime = millis();
    return;
  }
 
 //  click -- shoot
 if (clickTarget(invade_X, invade_Y, invade_WIDTH, invade_HEIGHT)) {  
    invadeClicked = true;
    //image(img_INVADE_PRESSED, invade_X + invade_WIDTH / 2,invade_Y + invade_HEIGHT / 2);
    Tower closestTower = null;
    int shortestDistance = 999999;
    for (Tower tower : towers) {
      int distance = abs(tower.getX() - playerX)  + abs(tower.getY() - playerY);
      if (distance < shortestDistance) {
        closestTower = tower;
        shortestDistance = distance;
      }
    }
    if (closestTower != null) {
      if (bulletsInPlay.size() < MAX_BULLETS) {
        bulletsInPlay
            .add(new Bullet(playerX, playerY, closestTower));
        shotTime = millis();
      }
    }
 }
}

public int locationToPixel(float my_coord, float cmu_A, float cmu_B,
    float s4_dim) {
  float OldMin = min(abs(cmu_A), abs(cmu_B)) * PRECISION;
  float OldMax = max(abs(cmu_A), abs(cmu_B)) * PRECISION;
  float OldRange = (OldMax - OldMin);
  float OldValue = abs(my_coord) * PRECISION;
  float NewMin = 0;
  float NewRange = s4_dim;
  float NewValue = (abs((OldValue - OldMin)) * NewRange) / OldRange;
  NewValue += NewMin;
  return (int) NewValue;
}

void draw() {
  imageMode(CENTER);
  
  if (showHelpbox)
  {
    image(img_HELP, s4_WIDTH / 2, s4_HEIGHT / 2);
    return;
  }
  // //GPS RELATED//////////////////////////////
  imageMode(CENTER);
  //------------------------------------------------ update dynamically
  image(img_CMU, s4_WIDTH / 2, s4_HEIGHT / 2);
  
  fill(255);
  textSize(60);
     
  if ( (startScreen || isGameOver) && startClicks < 3) { // /TODO: add the start screen
    textSize(60);
     text("?", width - helpbox_WIDTH/2 , height - helpbox_HEIGHT/2);
     textSize(60);
     
    image(img_START, width / 2, height / 2);
    if (finishTime != 0)     
      text("\nLast Time:\t" + (int) finishTime + "s" , width / 2 - 200 , height - 100);
      
    if(milkywayClicked) {
      image(img_MILKYWAY_PRESSED, milkyway_X + milkyway_WIDTH / 2,milkyway_Y + milkyway_HEIGHT / 2);
    } else   {
      image(img_MILKYWAY, milkyway_X + milkyway_WIDTH / 2,milkyway_Y + milkyway_HEIGHT / 2);
    }
    
    if(andromedaClicked) {
      image(img_ANDROMEDA_PRESSED, andromeda_X + andromeda_WIDTH / 2,andromeda_Y + andromeda_HEIGHT / 2);
    } else   {
      image(img_ANDROMEDA, andromeda_X + andromeda_WIDTH / 2,andromeda_Y + andromeda_HEIGHT / 2);
    }
      
    return;
  }
  
  if(invadeClicked){
    image(img_INVADE_PRESSED, invade_X + invade_WIDTH / 2,invade_Y + invade_HEIGHT / 2);
  }  else  {
    image(img_INVADE, invade_X + invade_WIDTH / 2,invade_Y + invade_HEIGHT / 2);
  }
  
  
  // //GPS RELATED//////////////////////////////
  
 // text(latitude + "\n" + longitude, 500, 100); ////temporary -------------------------for testing  
  image(img_HEADER, header_X, header_Y);
  finishTime = 0;


  //top left
  text("Time\t" + (int) (millis() - startTime) / 1000 + "s", 200, 60);
  
 
  //top right side
  text("Stars\t" + score,  width - 200,  60);
  
  
  if (towers.size() == 0) { // show time spent
    finishTime = (millis() - finishTime) / 1000 ;
    startClicks = 0;
    startScreen = true;
    return;
  } else {
    stroke(0);
    imageMode(CENTER);
    for (Tower tower : towers)
      image(img_TOWER, tower.getX(), tower.getY());
    // for (Bullet bullet : bulletsInPlay)
    // image(img_SHOT, bullet.getX(), bullet.getY());
    for (int i = 0; i < bulletsInPlay.size(); i++) {
      float theta = bulletsInPlay.get(i).getTheta();
      if (theta <= 0)
        theta += 2 * PI;
     // rotate(theta);
      image(img_SHOT, bulletsInPlay.get(i).getX(),
          bulletsInPlay.get(i).getY());
      //rotate(-1 * theta);
    }
    if (!playerInTower) {
      // draw player
      // ///////////////////////////////////////////////
      // /update the user's location dot
      // / my_coord, float cmu_A, float cmu_B, float s4_dim
      int new_x = s4_WIDTH
          - locationToPixel(longitude, CMU_EAST, CMU_WEST,
              s4_WIDTH);
      int new_y = s4_HEIGHT
          - locationToPixel(latitude, CMU_NORTH, CMU_SOUTH,
              s4_HEIGHT);
      if (new_x > s4_WIDTH)
        new_x = s4_WIDTH - 67;
      if (new_y > s4_HEIGHT)
        new_y = s4_HEIGHT - 128;
      image(img_USR, new_x, new_y);
      playerX = new_x; // ///////////////UNCOMMENT---------------testing
      playerY = new_y; // ///////////////UNCOMMENT---------------testing
    }
  }
  
  if (capturedTowers.size() > 0){
     for (Tower tower : capturedTowers){
       tower.setTimeSinceHit(tower.getTimeSinceHit() + 1);
       if (tower.getTimeSinceHit() >= towerTimeOut){
         towers.add(tower);
         capturedTowers.remove(tower);
         if (capturedTowers.size() == 0){
           isGameOver = true;
           
         }
       }
       else{
         image(img_TOWER_CAPTURED, tower.getX(), tower.getY());
         text(""+(towerTimeOut-tower.getTimeSinceHit())/100, tower.getX(),tower.getY()+12);
       }
     }
   }
   
   
     for (int i = bulletsInPlay.size() - 1; i >= 0; i--) {
    bulletsInPlay.get(i).move();
    if (bulletsInPlay.get(i).hitTarget()) {
      for (int j = towers.size() - 1; j >= 0; j--) {
        if ((towers.get(j).getX() == bulletsInPlay.get(i).getX())
            && (towers.get(j).getY() == bulletsInPlay.get(i)
                .getY())) {
          towers.get(j).takeDamage();
          if (towers.get(j).isDead()){   
            //Add tower to captured towers
            capturedTowers.add(towers.get(j));
 
            //Remove tower from towers, increment score
            towers.remove(j);
            score += towerScore;
          }
          break;
        }
      }
      bulletsInPlay.remove(i);
    }
  }
}

// ///////////////////////////////////////////////////////////
// //GPS RELATED///////////Added By DIANA/////////////////////
void onLocationEvent(double _latitude, double _longitude, double _altitude) {
  longitude = (float) _longitude;
  latitude = (float) _latitude;
}



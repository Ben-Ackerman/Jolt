// Valiables
int HEALTH_BAR_MARGIN = 5;  // The margin of the health bar from the side
float healthBarLength; // The max length of the health bar
int healthBarWidth; // The verticle height of the health bar
int viewWidth; // the width in pixals of the game
int viewLength; // The height in pixals of the game
boolean keys[];  // 0 = a, 1 = s, 2 = d, 3 = w, 4 = ' ', 5 = r 
ArrayList<Bullet> bullets; // Stores all the bullets currently on the screen
boolean isPressed; // Stores if the mouse is currently clicked
int fRate; // The frame rate of the program
ArrayList<Enemy> enemies; // Stores all the enemies
int countDown;
int ammo;
int fullClip;
boolean gameStarted;
boolean gameOver;
boolean gameWin;

Player player;
void setup() {
  fRate = 30;
  frameRate(fRate);
  fullScreen();
  setUpConstants();
  startup();
}

void setUpConstants() {
  fullClip = 20;
  healthBarLength = width/3;
  healthBarWidth = height/15;
  viewWidth = width;
  viewLength = height;
  setUpKeys();
}
void restart() {
  gameStarted = false;
  gameOver = false;
  gameWin = false;
  startup(); 
}

void gameOver() {
  gameOver = true;
  isPressed = true;
}
void startup() {
  ammo = fullClip;
  countDown = 0; 
  gameStarted = false;
  gameWin = false;
  gameOver = false;
  isPressed = false;
  enemies = new ArrayList<Enemy>();
  for(int i = 15; i < 30; i++) {
     enemies.add(new ZombieSmart((int)random(0, width), (int)random(0,height), (i)/3));
     enemies.add(new ZombieDumb((int)random(0, width), (int)random(0,height), (i)/4));
  }
  player = new Player(viewWidth/2, viewLength/2, 7, 5, 100);
  bullets = new ArrayList<Bullet>();
}
void runCountDown()  {
   countDown += 1;
   textSize(128);
   fill(255);
   text(3 - (countDown / 30), width/2, height/2);
   if(countDown == fRate * 3) {
     gameStarted = true;
   }
   player.sketch();
   for(Enemy enemy : enemies) {
      enemy.sketch(); 
   }
}
void draw() {
  if(gameStarted && !gameOver) {
    fill(100,100, 200);
    rect(0, 0, width, height);
    runKeys();
    player.update();
    updateShooting();
    updateBullets(); // Calls the draw bullets
    updateEnemies();
  } else if(!gameOver) { 
    fill(100,100, 200);
    rect(0, 0, width, height);
    runCountDown();
  }
  if(gameOver && !gameWin) {
    fill(0,0,0, 70); 
    rect(0,0,width,height);
    textSize(128);
    fill(255, 0, 0);
    text("   Game Over\n(Click to restart)", width/2 - 500, height/2);
    if(mousePressed && !isPressed) {
      restart();
    }
    if(!mousePressed) {
      isPressed = false; 
    }
  }
  if(gameWin) {
    fill(0,0,0, 70); 
    rect(0,0,width,height);
    textSize(128);
    fill(255, 0, 0);
    text("  Game Win\n(Click to restart)", width/2 - 500, height/2);
    if(mousePressed && !isPressed) {
      restart();
    }
    if(!mousePressed) {
      isPressed = false; 
    }
  }
  drawHealthBar();
  drawBoostBar();
  drawAmmo();
}

void win() {
  gameWin = true;
  gameOver();
}
void drawAmmo() {
   textSize(64);
   fill(0);
   text(ammo, 5*width/6, 70);
}

void reload() {
    ammo = fullClip; 
}
void updateEnemies() {
   ArrayList<Enemy> toRemove = new ArrayList<Enemy>();
   for(int i = 0; i < enemies.size(); i++) {
      if(enemies.get(i).health <= 0) {
        toRemove.add(enemies.get(i));
      }
   }
   enemies.removeAll(toRemove);
   for(Enemy enemy : enemies) {
     enemy.moveGoal(player.x, player.y);
     enemy.hitPlayer(player);
   } 
   bullets.removeAll(toRemove);
   if(enemies.size() == 0 ) {
     win(); 
   }
}
void updateBullets() {
   ArrayList<Bullet> toRemove = new ArrayList<Bullet>();
   for(int i = 0; i < bullets.size(); i++) {
      if(bullets.get(i).isDone()) {
        toRemove.add(bullets.get(i));
      }
   }
   for(int i = 0; i < bullets.size(); i++) {
        bullets.get(i).update();
        for(Enemy enemy : enemies) {
           if(bullets.get(i).hitEnemy(enemy)) {
              toRemove.add(bullets.get(i));   
           }
        }
   }
}
void updateShooting() {
  if(mousePressed && !isPressed && ammo > 0) {
    bullets.add(new Bullet(player.x, player.y, mouseX, mouseY, 25)); 
    ammo--;
  }
  isPressed = mousePressed;
}

int updateY(int y, int delta) {
   int newValue = y + delta;
   if(newValue < 0) {
      return 0;
   } else if(newValue > viewLength) {
       // Return the number of pixels you went past the end
      return viewLength;
   } else {
      return newValue;
   }
}

float distance(float x1, float y1, float x2, float y2) {
    return sqrt(sq(x2-x1) + sq(y2-y1));
}

int updateX(int x, int delta) {
   int newValue = x + delta;
   if(newValue < 0) {
      return 0;
   } else if(newValue > viewWidth) {
       // Return the number of pixels you went past the end
      return viewWidth;
   } else {
      return newValue;
   }
}

 
void setUpKeys() {
   keys = new boolean[10];
   for(int i = 0; i < keys.length; i++) {
      keys[i] = false; 
   }
}

void drawBoostBar() {
   float barLength = healthBarLength * (player.boostAmount / MAX_PLAYER_BOOST);
   stroke(0, 0, 255);
   strokeWeight(5);
   noFill();
   rect(4*HEALTH_BAR_MARGIN+healthBarLength, HEALTH_BAR_MARGIN, healthBarLength, healthBarWidth, 10);
   fill(100,100,255);
   rect(4*HEALTH_BAR_MARGIN + healthBarLength, HEALTH_BAR_MARGIN, barLength, healthBarWidth, 5);
   stroke(0);
}

void drawHealthBar() {
   float barLength = healthBarLength * (player.health / MAX_PLAYER_HEALTH);
   stroke(255, 0, 0);
   strokeWeight(5);
   noFill();
   rect(HEALTH_BAR_MARGIN, HEALTH_BAR_MARGIN, healthBarLength, healthBarWidth, 5);
   fill(255,0,0);
   rect(HEALTH_BAR_MARGIN, HEALTH_BAR_MARGIN, barLength, healthBarWidth, 5);
   stroke(0);
}

void runKeys() {
  boolean boost = false;
  if(player.boostAmount > 0) {
      boost = keys[4];
  }
  if(boost) {
    player.boostAmount--; 
  }
  if(keys[0]) {
     player.moveLeft(boost);
  }
  if(keys[1]) {
     player.moveDown(boost);
  }
  if(keys[2]) {
     player.moveRight(boost);
  }
  if(keys[3]) {
     player.moveUp(boost);
  }
  if(keys[5]) {
     reload();
  }
}
void keyPressed() {
  if (key == 'a') {
    keys[0] = true;
    keys[2] = false;
  }
  if (key == 's') {
    keys[1] = true;
    keys[3] = false;
  }
 if (key == 'd') {
    keys[2] = true;
    keys[0] = false;
  }
  if (key == 'w') {
    keys[3] = true;
    keys[1] = false;
  }
  if (key == ' ') {
    keys[4] = true;
  }
  if (key == 'e') {
    keys[5] = true;
  }
}

 
void keyReleased() {
  if (key == 'a') {
    keys[0] = false;
  }
  if (key == 's') {
    keys[1] = false;
  }
 if (key == 'd') {
    keys[2] = false;
  }
  if (key == 'w') {
    keys[3] = false;
  }
  if (key == ' ') {
    keys[4] = false;
  }
  if (key == 'e') {
    keys[5] = false;
  }
}
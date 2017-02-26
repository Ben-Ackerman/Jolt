int PLAYER_HIT_BOX_SIZE = 30;
float MAX_PLAYER_HEALTH = 100;
class Player {
  Player(int x, int y, int speed, int boost, int health) {
     this.x = x;
     this.y = y;
     this.speed = speed;
     this.health = health;
     this.boost = boost;
  }
  int x;
  int y;
  float health;
  int speed;
  int boost;
  void moveLeft(boolean isBoost) {
     int delta = isBoost ? speed + boost : speed;
     x = updateX(x, delta * -1);
  }
  void moveRight(boolean isBoost) {
    int delta = isBoost ? speed + boost : speed;
    x = updateX(x, delta);
  }
  void moveUp(boolean isBoost) {
    int delta = isBoost ? speed + boost : speed;
    y = updateY(y, (delta * -1));
  }
  void moveDown(boolean isBoost) {
    int delta = isBoost ? speed + boost : speed;
    y = updateY(y, delta);
  }
  
  void update() {
    sketch();
  }
  
  void sketch() {
     fill(255);
     ellipse(player.x, player.y, PLAYER_HIT_BOX_SIZE, PLAYER_HIT_BOX_SIZE);
     
  }
}
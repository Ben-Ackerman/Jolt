static int ZombieSmartSize = 20;
static int ZombieSmartSpeed = 5;
static int ZombieSmartDamage = 10;
static int ZombieSmartHealth = 100;
class ZombieSmart extends Enemy {
    ZombieSmart(int x, int y, int speed) {
      super(x, y, speed, ZombieSmartDamage,  ZombieSmartSize, ZombieSmartHealth);
    }
    int playerOldX = 0;
    int playerOldY = 0;
    void moveGoal(int gX, int gY) {
     int deltaX = (gX-playerOldX) * 50 * (int) random(1,10);
     int deltaY = (gY-playerOldY) * 50 * (int) random(1,10);
     float angle = atan2((gY + deltaY)-y, (gX + deltaX)-x);
      y += sin(angle) * speed;
      x += cos(angle) * speed;
      update();
     playerOldX = gX;
     playerOldY = gY;
   }
}
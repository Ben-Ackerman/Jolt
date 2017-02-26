static int ZombieDumbSize = 20;
static int ZombieDumbSpeed = 5;
static int ZombieDumbDamage = 10;
static int ZombieDumbHealth = 100;
class ZombieDumb extends Enemy {
    ZombieDumb(int x, int y, int speed) {
      super(x, y, speed, ZombieDumbDamage,  ZombieDumbSize, ZombieDumbHealth);
    }
    
    void moveGoal(int gX, int gY) {
     float angle = atan2(gY-y, gX-x);
      y += sin(angle) * speed;
      x += cos(angle) * speed;
     update();
   }
}
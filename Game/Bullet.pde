int BULLET_SPEED = 30;
class Bullet {
   Bullet(int startX, int startY, int endX, int endY, int damage) {
      this.startX = startX;
      this.startY = startY;
      this.currX = startX;
      this.currY = startY;
      this.angle = atan2(endY-startY, endX-startX);
      this.damage = damage;
   }
   float startX;
   float startY;
   float currX;
   float currY;
   float angle;
   int damage;
   // Returns if a bullet is off the screen
   boolean isDone() {
      return ((currY > viewLength)|| (currY < 0) 
              || (currX > viewWidth) || (currX < 0));
   }   
   
   void update() {
      startX = currX;
      startY = currY;
      currY += sin(angle) * BULLET_SPEED;
      currX += cos(angle) * BULLET_SPEED;
      sketch();
   }
   
   void sketch() {
      strokeWeight(3);
      stroke(255, 255, 102);
      line(startX, startY, currX, currY);
      stroke(0);
   }
   
   boolean hitEnemy (Enemy enemy) {
       boolean didHit = false;
       if(distance(currX, currY, enemy.x, enemy.y) < enemy.getHitBoxSize()) {
          enemy.health = (enemy.health <= damage) ? 0 : enemy.health - damage;
          didHit = true;
       }
       return didHit;
   }
}
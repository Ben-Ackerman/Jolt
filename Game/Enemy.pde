abstract class Enemy {
   Enemy(int x, int y, int speed, int damage, int hitBoxSize, int health) {
      this.x = x;
      this.y = y;
      this.health = health;
      this.speed = speed;
      this.damage = damage;
      this.hitBoxSize = hitBoxSize;
   }
   float x;
   float y;
   int health;
   int speed;
   int damage;
   float easing = 0.05;
   int hitBoxSize;
   
   int getHitBoxSize() {
     return hitBoxSize; 
   }
   void moveGoal(int gX, int gY) {
     x += (gX-x) * easing;
     y += (gY-y) * easing;
     update();
   }
   void update() {
      sketch();
   }
   
   void sketch() {
       fill(100,255,100);
       ellipse(x, y, hitBoxSize, hitBoxSize);
   }
   
   void hitPlayer (Player player) {
       if(distance(x, y, player.x, player.y) < PLAYER_HIT_BOX_SIZE) {
          player.health = (player.health <= damage) ? 0 : player.health - damage;
          gameOver = player.health <= 0;
       }
   }
}
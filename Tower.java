public class Tower {
  public static final int DEFAULT_MAX_HEALTH = 1;
  public static final int DEFAULT_TIME_SINCE_HIT = 0;
  private int maxHealth;
  private int health;
  private int positionX;
  private int positionY;
  private int timeSinceHit;
  
  public Tower(int positionX, int positionY) {
    this.positionX = positionX;
    this.positionY = positionY;
    this.maxHealth = DEFAULT_MAX_HEALTH;
    this.health = this.maxHealth;
    this.timeSinceHit = DEFAULT_TIME_SINCE_HIT;
  }
  
  public Tower(int positionX, int positionY, int maxHealth, int timeSinceHit) {
    this.positionX = positionX;
    this.positionY = positionY;
    this.maxHealth = maxHealth;
    this.health = maxHealth;
    this.timeSinceHit = timeSinceHit;
  }
  
  public int getTimeSinceHit(){
    return this.timeSinceHit;
  }

  public void setTimeSinceHit(int timeSinceHit){
    this.timeSinceHit = timeSinceHit;
  }
  
  public int getMaxHealth() {
    return this.maxHealth;
  }
  
  public int getCurrentHealth() {
    return this.health;
  }
  
  public boolean isDead() {
    return (this.health == 0);
  }
  
  public int getX() {
    return this.positionX;
  }
  
  public int getY() {
    return this.positionY;
  }
  
  public void takeDamage() {
    takeDamage(1);
  }
  
  public void takeDamage(int damage) {
    if (this.health <= damage)
      this.health = 0;
    else
      this.health -= damage;
  }
  
  public void heal(int amountToHeal) {
    this.health += amountToHeal;
    if (this.health > this.maxHealth)
      this.health = this.maxHealth;
  }
}

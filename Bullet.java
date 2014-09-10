public class Bullet {
  private double currentX;
  private double currentY;
  private double theta;
  private Tower target;
  
  public Bullet(int startX, int startY, Tower target) {
    this.target = target;
    this.currentX = (double)startX;
    this.currentY = (double)startY;
    double slope = ((double)target.getY() - currentY)/((double)target.getX() - currentX);
    this.theta = Math.atan(slope);
    if ((target.getX() <= startX) && (target.getY() <= startY)) {
      theta -= Math.PI;
    }
    else if ((target.getX() <= startX) && (target.getY() >= startY)) {
      theta += Math.PI;
    }
  }
  
  public int getX() {
    return (int)currentX;
  }
  
  public int getY() {
    return (int)currentY;
  }
  
  public float getTheta(){
    return (float)this.theta;
  }
  
  public void move() {
    if (((int)currentX == target.getX()) && ((int)currentY == target.getY()))
      return;
    
    double newX = currentX + 10*Math.cos(theta);
    double newY = currentY + 10*Math.sin(theta);
    
    if ((((int)currentX < target.getX()) && ((int)newX >= target.getX())) ||
        (((int)currentX > target.getX()) && ((int)newX <= target.getX())) ||
        (((int)currentY < target.getY()) && ((int)newY >= target.getY())) ||
        (((int)currentY > target.getY()) && ((int)newY <= target.getY()))) {
      currentX = target.getX();
      currentY = target.getY();
    }
    else {
      currentX = newX;
      currentY = newY;
    }
  }
  
  public boolean hitTarget() {
    return (((int)currentX == target.getX()) && ((int)currentY == target.getY()));
  }
}

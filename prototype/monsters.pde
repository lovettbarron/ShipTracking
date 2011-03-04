
/////////
//// Monster class, to be extended
////////
class Monster {
  protected PVector target;
  protected PVector origin;
  protected PVector loc, acc, vel;
  protected float health;
  private Iterator itr;

  void spawn() {
  }

  void update( float multi) {
    PVector diff = PVector.sub(ship.get(),this.loc);
    diff.normalize();
    float factor = 1.0;
    diff.mult(factor);
    this.acc.set(diff);  

    this.vel.add(this.acc);
    this.loc.add(this.vel);
    this.vel.normalize();
    this.vel.mult(multi);
    this.acc = new PVector();
  }

  void update() {
    update(2.2f);
  }

  void draw() {
    this.update();
  }

  boolean killed() {
    boolean killed = false;
    this.itr = blast.iterator();
    while( this.itr.hasNext() ) {
      Impact impact = (Impact)this.itr.next(); 
      if(impact.getIntersect(this.loc)) {
        killed = true;
      } else { killed = false; } 
    }
    return killed;
  }

}


class SeaSnake extends Monster {

  SeaSnake(Environment _origin, Ship _target) {
    this.origin = _origin.get();
    this.target = _target.get();
    this.loc = PVector.add( this.origin, new PVector(random(-_origin.getRad()/2,_origin.getRad()/2 ), random(-_origin.getRad()/2,_origin.getRad()/2), 0f ) );
    this.acc = new PVector();
    this.vel = new PVector();
    //    this.vel = PVector.sub( this.loc, this.target );
    this.health = 10;
  }  

  void draw() {
    this.update();
    fill( this.health );
    ellipse( this.loc.x, this.loc.y, 20, 20);
  }
}


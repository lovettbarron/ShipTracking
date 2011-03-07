
/////////
//// Ship movement, ostensibly controlled by GPS data
////////
class Ship {
  private PVector loc, acc, vel, diff, prev;

  Ship( float _x, float _y) {
    loc = new PVector( _x, _y);
    this.acc = new PVector();
    this.vel = new PVector();
    this.diff = new PVector();
    this.prev = new PVector();
  } 

  void draw() {
    update();
    updateLocation();

    fill( 255);
    pushMatrix();
    translate( loc.x, loc.y);
    beginShape();
    vertex(0, 0);
    vertex(500/zoom, height/zoom);
    vertex(-500/zoom, height/zoom);    
    endShape();
    popMatrix();
  }

  void update( float multi) {
    diff = PVector.sub( new PVector( control.get().x, control.get().y ), this.loc);
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
    update(1.);
  }

  void setDif() {
    this.prev = loc;
  }

  PVector diff() {;
    return PVector.sub( loc,diff );
  }

  void updateLocation() {
    //    loc.add( new PVector( random( -5, 5), random(-5,5), 0f) );
  }

  void updateDirection() {
  }

  void add( PVector add ) {
    loc.set( add );
  }

  PVector get() {
    return loc.get();
  }

  //  float[] getPosition() {
  //  return float[x];
  //}
}


/////////
//// Defense turret, controls shot objects as well
////////
class Defense {
  private List<Shot> shots;
  float angle;
  Ship ship;
  int shotCounter = 0;
  float cLength = 30; // cannonLength

  Defense(float _angle, Ship _ship) {
    angle = _angle;
    ship = _ship;
    shots = new ArrayList<Shot>();
  } 

  void adjust( float _angle ) {
    angle += _angle;
    if( angle < 0 ) {
      angle = 360 - angle;
    } 
    else
      if( angle > 360) { 
        angle = angle - 360;
      }
  } 

  void update() {
    if( shotCounter > 0 ) {
      shotCounter -= 1;
    } 
    else { 
      shotCounter = 0;
    }
  }

  void draw() {
    this.update();
    rect((ship.get().x + cos(radians(angle))*(cLength)),(ship.get().y + sin(radians(angle))*(cLength)), 4, 4 );
    this.drawShots();
  }

  void fire() {
    //println( shotCounter);
    //println( "x:" + ship.get().x + " y:" + ship.get().y + " ang:" + angle);
    if( shotCounter == 0 ) {
      shots.add( new Shot( ship.get(), angle, 100 ) );
      shotCounter = 30;
    }
  }

  float getAngle() {
    return angle;
  }

  void drawShots() {
    Iterator iterator = shots.iterator();
    while( iterator.hasNext() ) {
      Shot tempShot = (Shot)iterator.next(); 
      if(tempShot.decayed()) { 
        iterator.remove();
      }
      else if( trigger == true) {
        iterator.remove();
        blast.add( new Impact( tempShot.loc, 100, 1) );
        trigger = false;
      }
      tempShot.draw();
    }
  }
}


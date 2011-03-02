
/////////
//// Ship movement, ostensibly controlled by GPS data
////////
class Ship {
  private PVector loc;
  private float direction;

  Ship( float _x, float _y, float _dir) {
    loc = new PVector( _x, _y);
    //    loc.set(_x, _y, 0);
    direction = _dir;
  } 

  void draw() {
    fill( 255);
    pushMatrix();
    translate( loc.x, loc.y);
    rotate( tan( direction ) );
    beginShape();
    vertex(0, 0);
    vertex(500/zoom, height/zoom);
    vertex(-500/zoom, height/zoom);    
    endShape();
    popMatrix();
  }

  void updateLocation() {
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
    rect((ship.get().x + cos(radians(angle))*(cLength/2)),(ship.get().y + sin(radians(angle))*(cLength/2)), 10, 10 );

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
      else if( trigger == true){
            iterator.remove();
            blast.add( new Impact( tempShot.loc, 100, 1) );
            trigger = false;
      }
      tempShot.draw();
    }
  }
}



/////////
//// Bullet object
////////
class Shot {
  float decay, angle, life;
  PVector loc, acc, vel;
  float cLength = 30;
  Shot(PVector _origin, float _angle, float _decay) {
    angle = _angle;
    decay = _decay;
    life = 0;

    loc = _origin;  
    acc = new PVector(); 
    vel = PVector.sub( 
    new PVector( 
    ( cLength * cos( radians( angle ) ) + loc.x),
    ( cLength * sin( radians( angle ) ) + loc.y), 0f),
    loc);
  }

  void update() {
    //println( "x:" + loc.x + "y:" + loc.y);
    life += 1;
    vel.add(acc);
    loc.add(vel);
    //    acc = new PVector();
    vel.normalize();
    vel.mult(2.2f); 

    //    if (vel.mag() > maxvel) {
    //    vel.normalize();
    //  vel.mult(maxvel);
    //}

    if( life <= decay ) {
      //      vel.add( acc );
    } 
    else {
    }
  }

  void draw() {
    this.update();
    ellipse( loc.x, loc.y, 10,10);
  }

  boolean decayed() {
    if( life >= decay ) {
      return true;
    } 
    else { 
      return false;
    }
  }

  void impact() {
    decay = 0;
  }
}

class Impact {
  private PVector loc;
  private float rad, mag, blast;
  private boolean disipate, die = false;
  
  Impact( PVector _loc, float _rad, float _mag) {
   loc = _loc;
   rad = _rad;
   mag = _mag;
   blast = 0; 
  }
  
  void draw() {
   this.update();
   color( 255,0,0, mag);
   ellipse( loc.x, loc.y, rad, rad); 
  }
  
  void update() {
    if( blast < rad/2){
     blast += mag; 
    } else { disipate = true; }

    if( disipate = true) {
     blast -= mag; 
     if( blast <= 0 ) {
       die = true;
     }
    }
  }
  
  boolean die() {
   return die; 
  }
  
}


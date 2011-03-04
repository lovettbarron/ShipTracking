
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






/////////
//// Explosion object
////////

class Impact {
  private PVector loc;
  private float rad, mag, blast;
  private boolean disipate, die = false;
  private int count;

  Impact( PVector _loc, float _rad, float _mag) {
    loc = _loc;
    rad = _rad;
    mag = _mag;
    blast = 1;
    count = 0;
  }

  void draw() {
    this.update();
    color( 255,0,0, mag);
    ellipse( loc.x, loc.y, blast, blast);
  }

  void update() {
    count++;
    if( !disipate ) {
      if( blast < rad) {
        //println( "increasing " + blast + " by " + mag );
        blast = blast*cos(mag)*count;
      } 
      else { 
        disipate = true;
      }
    }

    if( disipate) {
      blast -= mag*4; 
      if( blast <= 0 ) {
        die = true;
      }
    }
  }

  boolean getIntersect( PVector object ) {
    boolean intersect;
    float distance =  abs(PVector.dist( this.loc, object ) )  ;
    if( distance <= blast/2 ) {
      intersect = true;
    } 
    else { 
      intersect = false;
    }
    return intersect;
  }

  boolean die() {
    return die;
  }

  float getRad() {
    return blast;
  }

  float getMag() {
    return mag;
  }

  PVector getLoc() {
    return loc;
  }
}


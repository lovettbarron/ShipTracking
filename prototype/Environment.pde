/////////
//// Environment polygon obj, defines boundary for Environment obj
//// 0 = storm
///  1 = winds
///  2 = reef
///  3 = gale
///  4 = secret spot
///  5 = island
///  6 = boss
////////
class EnviroPoly {
  private List<PVector> polygon;
  private List<Environment> enviro;
  private int type;
  private float mag;
  private float Xmin, Xmax, Ymin, Ymax;

  EnviroPoly(List<PVector> _poly, float _mag, int _type ) {
    polygon = _poly;
    enviro = new ArrayList<Environment>();
    mag = _mag;
    type = _type;
    Xmin = 0; 
    Xmax = 0; 
    Ymin = 0; 
    Ymax = 0;
    Iterator iter = this.polygon.iterator();
    while( iter.hasNext() ) {
      PVector pnt = (PVector)iter.next(); 
      if( pnt.x > Xmax ) Xmax = pnt.x;
      if( pnt.x < Xmin ) Xmin = pnt.x;
      if( pnt.y > Ymax ) Ymax = pnt.y;
      if( pnt.y < Ymin ) Ymin = pnt.y;
    }

    for( int i = 0; i < 30; i++) {
      spawn();
    }
  }

  PVector innerPoint() {


    PVector point = new PVector( random(Xmin,Xmax), random(Ymin,Ymax), 0f);      
    //    if (point.x < Xmin || point.x > Xmax || point.y < Ymin || point.y > Ymax) {      }



    //a = A + u*AB + b*AD 

    return point;
  }

  void spawn() {
    if( type == 0 ) { //Storm
      this.enviro.add(new Storm( innerPoint(), random(0,width/2), random(0,1000)*.1 ) );
    } 
    else
      if( type == 1 ) { //Winds
      } 
      else
        if( type == 2 ) { // Reef
          println("oh hey");
          this.enviro.add(new Reef( innerPoint(), random(0,width/2), random(0,1000)*.1 ) );
        }
  }

  void update() {
  }

  void draw() {
    fill( 0, 0, 0, 50);
    /*
    beginShape();
     Iterator iter = this.polygon.iterator();
     while( iter.hasNext() ) {
     PVector vec = (PVector)iter.next(); 
     vertex( vec.x, vec.y );
     }
     endShape();
     */

    Iterator iterator = enviro.iterator();
    while( iterator.hasNext() ) {
      Environment Enviro = (Environment)iterator.next(); 
      Enviro.draw();
    }
  }
}


/////////
//// Environment objects, to be extended
////////
class Environment {
  protected PVector loc, acc, vel;
  protected float rad, mag;
  protected List<Monster> monsters;
  private Iterator iter;
  /*
  Environment(PVector _location, float _radius, float _magnitude) {
   loc = _location;
   rad = _radius;
   mag = _magnitude;
   }
   */
  PVector get() {
    return this.loc;
  }

  float getRad() {
    return this.rad;
  }

  void draw() {
    //    println( loc );
    this.update(); 
    fill( this.mag, this.mag );
    ellipse(this.loc.x,this.loc.y, this.rad, this.rad);
  }

  void spawn() {
  }

  void update( float multi) {
    this.doSpawns();
    if( int( random( 0, 10*mag) ) == 0 ) spawn();

    PVector diff = PVector.sub( new PVector( loc.x, loc.y ),this.loc);
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
    update( 2.2 );
  }

  void doSpawns() {
    Iterator iter = this.monsters.iterator();
    while( iter.hasNext() ) {
      Monster tempMonster = (Monster)iter.next(); 
      if( tempMonster.killed() ) iter.remove();
      tempMonster.draw();
    }
  }
}


class Storm extends Environment {

  Storm(PVector _loc, float _rad, float _mag) {
    this.loc = _loc.get();
    this.rad = _rad;
    this.mag = _mag;
    this.acc = new PVector();
    this.vel = new PVector();
    this.monsters = new ArrayList<Monster>();
  }

  void spawn() {
    //    println("Blar!");
    this.monsters.add( new SeaSnake( this, ship ) );
  }

  void draw() {
    //    println( loc );
    this.update(); 
    fill( this.mag, this.mag );
    if( int(random( 0, 40)) == 0) fill( 255, 255, 0, 180);
    ellipse(this.loc.x,this.loc.y, this.rad, this.rad);
  }
}



class Reef extends Environment {

  Reef(PVector _loc, float _rad, float _mag) {
    this.loc = _loc.get();
    this.rad = _rad;
    this.mag = _mag;
    this.acc = new PVector();
    this.vel = new PVector();
    this.monsters = new ArrayList<Monster>();
  }

  void draw() {
    //    println( loc );
    this.update(); 
    fill( 180, 200, 255, 100 );
//    if( int(random( 0, 40)) == 0) fill( 255, 255, 0, 180);
    ellipse(this.loc.x,this.loc.y, this.rad, this.rad);
  }

  void spawn() {
    this.monsters.add( new Harpy( this, ship ) );
  }
}


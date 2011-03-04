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

  EnviroPoly(List<PVector> _poly, float _mag, int _type ) {
    polygon = _poly;
    enviro = new ArrayList<Environment>();
    mag = _mag;
    type = _type;
    for( int i = 0; i < mag; i++) {
     spawn(); 
    }
  }

  PVector polyInternal() {
    PVector point = new PVector();
    //float a, b,c,d;
      
      
      
      
      
   //a = A + u*AB + b*AD 
   
   return point;
  }

  void spawn() {
    if( type == 0 ) { //Storm
      this.enviro.add(new Storm( new PVector( random(0,width), random(0,height), 0f), random(0,width/2), random(0,1000)*.1 ) );
    } 
    else
      if( type == 1 ) { //Winds
      } 
      else
        if( type == 2 ) { // Reef
          this.enviro.add(new Reef( new PVector( random(0,width), random(0,height), 0f), random(0,width/2), random(0,1000)*.1 ) );
        }
  }

  void update() {
    
  }

  void draw() {
    fill( 0, 0, 0, 50);
    beginShape();
    Iterator iter = this.polygon.iterator();
    while( iter.hasNext() ) {
      PVector vec = (PVector)iter.next(); 
      vertex( vec.x, vec.y );
    }
    endShape();
  }
}


/////////
//// Environment objects, to be extended
////////
class Environment {
  protected PVector loc;
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

  void update() {
    this.doSpawns();
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
    this.monsters = new ArrayList<Monster>();
  }

  void spawn() {
    //    println("Blar!");
    this.monsters.add( new SeaSnake( this, ship ) );
  }
}



class Reef extends Environment {

  Reef(PVector _loc, float _rad, float _mag) {
    this.loc = _loc.get();
    this.rad = _rad;
    this.mag = _mag;
    // this.monsters = new ArrayList<Monster>();
  }

  void spawn() {
    this.monsters.add( new Harpy( this, ship ) );
  }
}



/////////
//// Environment objects, to be extended
////////
class Environment {
  protected PVector loc;
  protected float rad, mag;
  protected List<Monster> monsters;
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
    this.monsters.add( new SeaSnake( this, ship ) );
  }
}


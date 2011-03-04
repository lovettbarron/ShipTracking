Waves wave;
Ship ship;
Defense defense;
List<Environment> storm = new ArrayList<Environment>();
List<Impact> blast = new ArrayList<Impact>();

boolean trigger = false;

public int zoom;

void setup() {
  size( 1280, 800);
  frameRate(15);
  zoom = 30;
  wave = new Waves();
  ship = new Ship( width/2, height/2, 0);
  defense = new Defense( 0., ship );
  storm.add(new Storm( new PVector( random(0,width), random(0,height), 0f), random(0,width/2), random(0,1000)*.1 ) );
}

void draw() {
  reset();

  //Me
  ship.draw();
  defense.draw();
  checkBlasts();
    //enviro
    iterateEnviro();
  } 

  void reset() {
    background( 255 );
    wave.draw();
  }

  //ENVIR + MONSTER
  void iterateEnviro() {
    Iterator iterator = storm.iterator();
    while( iterator.hasNext() ) {
      Environment tempEnviro = (Environment)iterator.next(); 
      tempEnviro.draw();
    }
  }

  void spawnEnviro() {
    Iterator iterator = storm.iterator();
    while( iterator.hasNext() ) {
      Environment tempEnviro = (Environment)iterator.next(); 
      tempEnviro.spawn();
    }
  }

  //BLAST
  void checkBlasts() {
    Iterator iterator = blast.iterator();
    while( iterator.hasNext() ) {
      Impact impact = (Impact)iterator.next(); 
      impact.draw();
      if(impact.die()) {
        iterator.remove();
      }
    }
  }

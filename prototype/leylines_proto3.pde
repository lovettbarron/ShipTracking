import processing.opengl.*;

Waves wave;
Ship ship;
Camera camera;
Defense defense;
Control control;
List<Environment> storm = new ArrayList<Environment>();
List<Impact> blast = new ArrayList<Impact>();
List<EnviroPoly> enviroPoly = new ArrayList<EnviroPoly>();

boolean trigger = false;
PApplet p;
public int zoom;

void setup() {
  size( 1280, 800, OPENGL);
  frameRate(15);
  p = this;
  zoom = 30;
  control = new Control();
  ship = new Ship( width/2, height/2);
  defense = new Defense( 0., ship );
  camera = new Camera( ship.get(), zoom);
  wave = new Waves();
  //storm.add(new Storm( new PVector( random(0,width), random(0,height), 0f), random(0,width/2), random(0,1000)*.1 ) );
  drawReef();
}

void draw() {
  control.update();
  camera.update();
  reset();
  iterEnviroPoly();
  //Me
  ship.draw();
  defense.draw();
  checkBlasts();
  //enviro
  iterateEnviro();
  ship.setDif();
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


void iterEnviroPoly() {
  Iterator iterator = enviroPoly.iterator();
  while( iterator.hasNext() ) {
    EnviroPoly env = (EnviroPoly)iterator.next(); 
    env.update();
    env.draw();
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

void drawStorm() { //TEMP FUNC
  List<PVector> tempReef = new ArrayList<PVector>();
  tempReef.add( new PVector( random(camera.boundMin().x/2, camera.boundMax().x/2), random( camera.boundMin().y, camera.boundMax().y) ) );
  tempReef.add( new PVector( random(camera.boundMin().x/2, camera.boundMax().x/2), random( camera.boundMin().y, camera.boundMax().y) ) );
  tempReef.add( new PVector( random(camera.boundMin().x/2, camera.boundMax().x/2), random( camera.boundMin().y, camera.boundMax().y) ) );
  tempReef.add( new PVector( random(camera.boundMin().x/2, camera.boundMax().x/2), random( camera.boundMin().y, camera.boundMax().y) ) );
  enviroPoly.add( new EnviroPoly( tempReef, 2.0, 0) );
}

void drawReef() { //TEMP FUNC
  List<PVector> tempReef = new ArrayList<PVector>();
  tempReef.add( new PVector( random(camera.boundMin().x/2, camera.boundMax().x/2), random( camera.boundMin().y, camera.boundMax().y) ) );
  tempReef.add( new PVector( random(camera.boundMin().x/2, camera.boundMax().x/2), random( camera.boundMin().y, camera.boundMax().y) ) );
  tempReef.add( new PVector( random(camera.boundMin().x/2, camera.boundMax().x/2), random( camera.boundMin().y, camera.boundMax().y) ) );
  tempReef.add( new PVector( random(camera.boundMin().x/2, camera.boundMax().x/2), random( camera.boundMin().y, camera.boundMax().y) ) );
  enviroPoly.add( new EnviroPoly( tempReef, 2.0, 2) );
}

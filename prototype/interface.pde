/////////
//// Compass, possibly to be removed
////////
class Compass {
  private int top, left;
  private int cSize;

  Compass(int _top, int _left) {
    top = _top;
    left = _left;
    cSize = height/10;
  } 

  void draw() {
    popMatrix();



    pushMatrix();
  }
}


////////
//// mouse
////////
class Control {
  private PVector loc; 
  
  Control() {
    loc = new PVector( mouseX, mouseY);
  }
  
  void update() {
   loc.set( camera.get().x + mouseX,  camera.get().y + mouseY, 0f ); 
  }
  
  PVector get() {
    println( loc );
    return loc;
  }
  
}


/////////
//// Heads up display and information
////////
class Hud {
  private int top, left;

  Hud(int _top, int _left) {
    top = _top;
    left = _left;
  }
}


/////////
//// Graphical wave objects, to be expanded
////////
class Waves {
  public float Falloff=0.5,Gain,Length=0.002,Speed=0.001,Distance=0.3;
  public float Divide,Octave=1, Position,Number;
  public boolean Fill=true;
  private float t=0, j=0;

  Waves() {
    Divide= (camera.get().x + (camera.view().x/2)) / 4;
    Position=( camera.get().y + (camera.view().y/2) )/4;
    Gain=-( camera.get().y + (camera.view().y/2) );
    Length = 0.002;
    Number = 10;
  } 


  void draw() {
    fill( 127, 200, 200, 40);
    noStroke();
    for (int i = 1 ; i <=Number ; ++i) {
      beginShape();
      for (float x =-Divide; x <= ( camera.get().x + (camera.view().x) )+Divide; x += Divide) {
        vertex(x, Gain*noise( x*Length + t, t + i*Distance )+(i*100) - Position );
      }
      vertex(camera.get().x + (camera.view().x), camera.get().y + (camera.view().y));
      vertex(camera.get().x - (camera.view().x), camera.get().y + (camera.view().y));
      endShape();
      t = t + tan(noise(j)*PI/2)*Speed;
      j=j+0.1;
    }
  }
}




void keyPressed() {
  if( key == 'a') {
    //ship.add( new PVector( ship.get().x-10, ship.get().y ) );
  } 
  else
    if( key == 'd') {
      //ship.add( new PVector( ship.get().x+10, ship.get().y ) );
    } 
    else
      if( key == 'w') {
        defense.adjust( 10 );
      } 
      else
        if( key == 's') {
          defense.adjust( -10 );
        } 
        else
          if( key == 'z') {
            trigger = true;
          } 
            else
              if( key == ' ') {                  
                defense.fire();
              } else
              if( key == '3') {
               spawnEnviro(); 
              } else
              if( key == '1') {
             //    storm.add(new Storm( new PVector( random(0,width), random(0,height), 0f), random(0,width/2), random(0,1000)*.1 ) ); 

              drawStorm();
              } else
              if( key == '2') {
             //    storm.add(new Storm( new PVector( random(0,width), random(0,height), 0f), random(0,width/2), random(0,1000)*.1 ) ); 

              drawReef();
              }
}


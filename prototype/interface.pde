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
  public int Divide,Octave=1, Position,Number;
  public boolean Fill=true;
  private float t=0, j=0;

  Waves() {
    Divide=width/4;
    Position=height/4;
    Gain=-height;
    Length = 0.002;
    Number = 100;
  } 


  void draw() {
    fill( 127, 200, 200, 40);
    noStroke();
    for (int i = 1 ; i <=Number ; ++i) {
      beginShape();
      for (float x =-Divide; x <= width+Divide; x += Divide) {
        vertex(x, Gain*noise( x*Length + t, t + i*Distance )+(i*100) - Position );
      }
      vertex(width,height);
      vertex(0,height);
      endShape();
      t = t + tan(noise(j)*PI/2)*Speed;
      j=j+0.1;
    }
  }
}




void keyPressed() {
  if( key == 'a') {
    ship.add( new PVector( ship.get().x-10, ship.get().y ) );
  } 
  else
    if( key == 'd') {
      ship.add( new PVector( ship.get().x+10, ship.get().y ) );
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
              if( key == '2') {
               spawnEnviro(); 
              } else
              if( key == '1') {
                 storm.add(new Storm( new PVector( random(0,width), random(0,height), 0f), random(0,width/2), random(0,1000)*.1 ) ); 
              }
}


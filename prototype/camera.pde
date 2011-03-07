class Camera {
  private PVector loc; //Centerpoint
  private PVector view; //Viewport size
  private float zoom; //Zoom

    Camera( PVector _loc, float _zoom) {
    loc = _loc;
    zoom = _zoom;
    view = new PVector( screen.width, screen.height );
  }


  void update() {
    updateLoc();
    camera( loc.x, loc.y, (view.y/2.0) / tan(PI*60.0 / 360.0), loc.x, loc.y, 0f, 0, 1, 1 );
    //beginCamera();
    //    translate( loc.x-(view.x/2), loc.y-(view.y/2) );
    //translate( ship.diff().x, ship.diff().y);
    // endCamera();
  }  

  void updateLoc() {
    loc = new PVector( ship.get().x, ship.get().y );
  }

  PVector get() {
    return new PVector( loc.x-(view.x/2), loc.y-(view.y/2) );
  }

  PVector view() {
    return view;
  }
  
  PVector boundMin() {
   return new PVector( loc.x - view.x/2, loc.y - view.y/2 );
  }
  
  PVector boundMax() {
   return new PVector( loc.x + view.x/2, loc.y + view.y/2 );    
  }
  
}  


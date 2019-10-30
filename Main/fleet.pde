class spaceFleet {
  ArrayList<Roci> rocis;
  int success = 0;
  
  spaceFleet(){
    rocis = new ArrayList<Roci>();
  }
  
  //I am manually contrlling now. Make it such that they thrust on their own. Maybe thrust
  void fleetCommand(boolean thrust){
    for(Roci b : rocis ){
      b.isacc(thrust, 20); //thrust to all
    }
  }
  
  //the fleet now knows relative position to asteroids
  void checkFleetCollision(PVector apos, float ar){    
    for (int i = rocis.size()-1; i > -1; i--){//iterates through all rocis
      Roci b = rocis.get(i);
      if (b.hits(apos, ar)){//recursive checker
         rocis.remove(i); //kaboom!     
      }
    }        
  }
  
  void checkReachObj(int width, int height){
    for (int i = rocis.size()-1; i > -1; i--){//iterates through all rocis
      Roci b = rocis.get(i);
      if ( (b.pos.x > ((width/2) -100)) && (b.pos.x < ((width/2) + 100)) && (b.pos.y > 0) && (b.pos.y < 150) /*boids are in the rectangle*/ ){
        rocis.remove(i); //kaboom!         
        success += 1;
        print(success + " Drones made it to the nauvoo.\n");
      } 
      
      if(b.pos.y > height){
        rocis.remove(i); //kaboom! 
      }
    }    
  }
  
  void killBoid(){
    if(rocis.size() > 0){
    rocis.remove( rocis.size()- 1); //remove the last added roci
    }
  }
       
  void run(){
    for(Roci b : rocis ){
      b.runRoci(rocis); //the ships fleet but have no rules    
    }
  }  
  
  void addFleet(Roci b){ //call to make new shis
    rocis.add(b);
  }
}

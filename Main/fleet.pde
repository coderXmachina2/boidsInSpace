class spaceFleet {
  ArrayList<Roci> rocis;
  
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
    //println("Asteroid Positions:" + apos.x + " " + apos.y);
    //println("Asteroid ar:" + ar );
    
    for (int i = rocis.size()-1; i > -1; i--) {//iterates through all rocis
    Roci b = rocis.get(i);
    
    if (   b.hits(apos, ar)   ) {//recursive checker
         println("Collision!");
         //remove the collided ship from play
         rocis.remove(i); //kaboom!         
      }
  }
    
    /* //This works to detect collision
    for(Roci b : rocis ){//for all ships
      //b is an array of rocs
      print(rocis.get(0));    
      //b.runRoci(rocis); //the ships fleet but have no rules 
      if (   b.hits(apos, ar)   ) {//recursive checker
         println("Collision!");
         //remove the collided ship from play
         
         
      } else{
        //println("no collision");
      }
    }*/
        
    
  }
  
  void killBoid(){
    //a fleet is a list of rocis
    if(rocis.size() > 0){
    rocis.remove( rocis.size()- 1); //remove the last added roci
    }
    
  }
  
  //void rotFleet (float rotation){//not meant to be 
     //for(Roci b : rocis ){
      //b.setRotation(rotation);
    //}
  //}
    
  void run(){
    for(Roci b : rocis ){
      b.runRoci(rocis); //the ships fleet but have no rules    
    }
  }
  
  //remove
  
  void addFleet(Roci b){ //call to make new shis
    rocis.add(b);
    //rocis is an array
    //println("Fleet Size is:" + rocis.size());
  }  
}

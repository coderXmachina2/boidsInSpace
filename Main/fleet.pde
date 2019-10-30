class spaceFleet {
  ArrayList<Roci> rocis;
  int success = 0;
  float successRate = 0.0f;
  
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
         rocis.remove(i); //kaboom!  Die Drone   
      }
    }        
  }
    
  //this is a subroutine that makes the boids avoid asteroids
  void fleetEvadeSubroutine(PVector apos, float ar){    
    for (int i = rocis.size()-1; i > -1; i--){//iterates through all rocis
      Roci b = rocis.get(i);
      //if the asteroid size falls inside the detection circle. Push and evaive vector to the boid
      if (b.evadeAs(apos, ar)){//Asteroid has fallen inside Detection Circle
         float d = PVector.dist(b.pos, apos); //position of the other...
         
         //println("Asteroid inbound! Push evasive vector!");   
         //generate random vector
         //random evasive vector
         PVector randEvasiveVect = new PVector(random(0,1680), random(0,1050), 0); //shuffle on this heading please
         PVector diff = PVector.sub(b.pos, apos);
         //diff.normalize();
         diff.div(d);
         //PVector diff = PVector.sub(b.pos, apos);
         //PVector steer = PVector.sub(sum, vel);
         
         randEvasiveVect.add(diff);
         randEvasiveVect.normalize();
         randEvasiveVect.mult(b.maxspeed);
         randEvasiveVect.sub(b.vel);
         randEvasiveVect.limit(b.maxforce);
         
         //apply force
         
         
         randEvasiveVect.mult(1.0);
         
         b.applyForce(randEvasiveVect);
      }     
    }        
  }
  
  void checkReachObj(int width, int height, int count){
    for (int i = rocis.size()-1; i > -1; i--){//iterates through all rocis
      Roci b = rocis.get(i);
      if ( (b.pos.x > ((width/2) -100)) && (b.pos.x < ((width/2) + 100)) && (b.pos.y > 0) && (b.pos.y < 150) /*boids are in the rectangle*/ ){
        rocis.remove(i); //Mission Success        
        success += 1;
        print("\n" + success + "/" + count + " Drones made it to the Nauvoo.\n");
        print(count - success + " Drones have been lost.\n");
        print((success*100) / count + "% Success Rate.\n");
      } 
   
      if(b.pos.y > height){ //if reverse So according to this code, top bound is a killer too
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

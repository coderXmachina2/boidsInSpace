class spaceFleet {
  ArrayList<Roci> rocis;
  
  spaceFleet(){
    rocis = new ArrayList<Roci>();
  }
  
  void fleetCommand(boolean thrust){
    for(Roci b : rocis ){
      b.isacc(thrust, 20);
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
  
  void addFleet(Roci b){ //call to make new shis
    rocis.add(b);
  }  
}

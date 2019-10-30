spaceFleet fleet;
Roci ship;

//in order for shit to be deleted it has to be an array list

//thrust timer
int lastTimeCheck;
int burnTimeCheck;

int countDeployed = 0;

//pulse jet params
int timeIntervalFlag = 3000; // 3 seconds because we are working with millis
int cuttThrustTime = 750; //cut thrust after this number of miliseconds

ArrayList<Asteroid> asteroids = new ArrayList<Asteroid>();
float numast = 6;  //straight up number of asteroids
PVector temppos;

void setup() {
  size(1680, 1050);
  fleet = new  spaceFleet ();                        //declare new spacefleet
  
  lastTimeCheck = millis(); //start counting the seconds
  burnTimeCheck =  millis() + cuttThrustTime;
  
  for (int i = 0; i < numast; i++) {
    asteroids.add(new Asteroid(temppos, random(80, 100), 1));
  }
 
}

void draw () {
  background(0);
  line(0, height/2, width, height/2);
  line(width/2, 0, width/2, height);
  
  //obj area!  
  line(width/2 - 100, 0, width/2 - 100, 150); //left horizontal line
  line(width/2 - 100, 150, (width/2 - 100) + 200, 150); //bottom line
  line(width/2 - 100, 0, (width/2 - 100) + 200, 0); //top line  
  line( (width/2 - 100) + 200, 150, (width/2) + 100, 0); //right horizontal line
  
  fleet.checkReachObj(width, height);
  fleet.run();    
  
  //println("Time Counter: " + millis());
  //println("Arg: " + millis() + "\n");
  
  if(millis() > burnTimeCheck + timeIntervalFlag ){
    fleet.fleetCommand(false);
  }
  
  //how do i shut off engines after 
  if ( millis() > lastTimeCheck + timeIntervalFlag ) {
    lastTimeCheck = millis(); //update
    fleet.fleetCommand(true);
  }
    
  //draw asteroids
  for (int i = 0; i < asteroids.size(); i++) {
      stroke(255);
      noFill();
      Asteroid asteroid = asteroids.get(i);
      asteroid.render();
      asteroid.update();
      asteroid.wrap();
      
      fleet.checkFleetCollision(asteroid.pos, asteroid.r); //sending position and r of afleet.checkReachObj();steroids
    }
}

void mousePressed (){ //on click take a new action
  //adds fleet in combination
  fleet.addFleet(new Roci(mouseX, mouseY)); //where you click make new roci  
  fleet.addFleet(new Roci(mouseX+10, mouseY+10)); //where you click make new roci
  fleet.addFleet(new Roci(mouseX+10, mouseY)); //where you click make new roci
  fleet.addFleet(new Roci(mouseX, mouseY+10)); //where you click make new roci
  fleet.addFleet(new Roci(mouseX-10, mouseY-10)); //where you click make new roci
  
  //fleet.addFleet(new Roci(mouseX, mouseY)); //where you click make new roci  
  fleet.addFleet(new Roci(mouseX-10, mouseY+10)); //where you click make new roci
  fleet.addFleet(new Roci(mouseX-10, mouseY)); //where you click make new roci
  fleet.addFleet(new Roci(mouseX, mouseY-10)); //where you click make new roci
  fleet.addFleet(new Roci(mouseX+10, mouseY-10)); //where you click make new roci
  
  countDeployed += 10;
  
  println(countDeployed + " drones deployed");
  
}

void keyPressed () { //on click take a new action
  //if (keyCode == RIGHT || key == 'd') { //rotate right
    //fleet.rotFleet(0.1);
  //} else if (keyCode == LEFT || key == 'a') { //rotate left 
    //fleet.rotFleet(-0.1);
  //} else if ((keyCode == UP) || key == 'w') {
    //fleet.fleetCommand(true);
  //}
  if ((keyCode == UP) || key == 'w') { //rotate right
    fleet.fleetCommand(true);
  } else if (key == 'e') {
    fleet.killBoid();
    //spaceFleet.remove(0);
  } else if (key == 'e'){//on press start count
   
  }
  
}

void keyReleased() {
  //if (keyCode == RIGHT || key == 'd') {
    //fleet.rotFleet(0); //stop rotating
  //} else if (keyCode == LEFT || key == 'a') {
    //fleet.rotFleet(0);
  //} else if (keyCode == UP || key == 'w') {
    //fleet.fleetCommand(false);
  //}
  
  if (keyCode == UP || key == 'w') { //rotate right
    fleet.fleetCommand(false);
  }
}//end of key released

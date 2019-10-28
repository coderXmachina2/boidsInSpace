spaceFleet fleet;

void setup() {
  size(1280, 720);
  fleet = new  spaceFleet ();                        //declare new spacefleet
 
}

void draw () {
  background(200, 200, 200);
  line(0, height/2, width, height/2);
  line(width/2, 0, width/2, height);
  fleet.run();                                        //run fleet, doesnt do much right now
 
}

void mousePressed (){ //on click take a new action
  //adds fleet in combination
  fleet.addFleet(new Roci(mouseX, mouseY)); //where you click make new roci  
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

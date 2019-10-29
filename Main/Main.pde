spaceFleet fleet;
Roci ship;

//in order for shit to be deleted it has to be an array list

// gui crap
int messageTimer = 0;
String messageText = "";

//thrust timer
int lastTimeCheck;
int timeIntervalFlag = 3000; // 3 seconds because we are working with millis

ArrayList<Asteroid> asteroids = new ArrayList<Asteroid>();
float numast = 10;  //straight up number of asteroids
PVector temppos;

void setup() {
  size(1680, 1050);
  fleet = new  spaceFleet ();                        //declare new spacefleet
  
  lastTimeCheck = millis();
  
  for (int i = 0; i < numast; i++) {
    asteroids.add(new Asteroid(temppos, random(80, 100), 1));
  }
 
}

void draw () {
  background(0);
  line(0, height/2, width, height/2);
  line(width/2, 0, width/2, height);
  fleet.run();      //run fleet, doesnt do much right now
  /*
  if ( millis() > lastTimeCheck + timeIntervalFlag ) {
    fleet.fleetCommand(true);
    lastTimeCheck = millis();
    //println( "Fire Thrusters!" );
      
    //fleet.fleetCommand(false);  
    
  }*/
  
  //draw asteroids
  for (int i = 0; i < asteroids.size(); i++) {
      stroke(255);
      noFill();
      Asteroid asteroid = asteroids.get(i);
      asteroid.render();
      asteroid.update();
      asteroid.wrap();
      
      fleet.checkFleetCollision(asteroid.pos, asteroid.r); //sending position and r of asteroids
      //checkFleetCollision(asteroid.pos, asteroid.r);
      //send it to the fleet first
      //ship.checkCollision(asteroid.pos, asteroid.r); //sends asteroid position and size
      /*
      if (   ship.hits(asteroid.pos, asteroid.r)   ) {//if this is true
        println("Collision!");
        //remove ship from play
      }
      */
      
      /*
      for (int j = aships.size()-1; j >= 0; j--) {
        Alienship a = aships.get(j);
        if (ahitast) {
          if (a.hits(asteroid.pos, asteroid.r)) {
            aships.remove(j);
            for(int m = 0; m < 4; m++){
              Particle p = new Particle(a.pos);
              p.vel.setMag(random(3, 5));
              p.vel.mult(random(0.9, 1.1));
              p.r = random(5, 12);
              dust.add(p);
            }
          }
        }
      }*/
      //
 
    }
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
  } else if (key == 'e') {
    fleet.killBoid();
    //spaceFleet.remove(0);
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

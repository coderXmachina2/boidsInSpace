spaceFleet fleet;

ArrayList<Asteroid> asteroids = new ArrayList<Asteroid>();
float numast = 4;
PVector temppos;

void setup() {
  size(1680, 1050);
  fleet = new  spaceFleet ();                        //declare new spacefleet
  
  for (int i = 0; i < numast; i++) {
    asteroids.add(new Asteroid(temppos, random(80, 100), 1));
  }
 
}

void draw () {
  background(200, 200, 200);
  line(0, height/2, width, height/2);
  line(width/2, 0, width/2, height);
  fleet.run();                                        //run fleet, doesnt do much right now
  
  //draw asteroids
  for (int i = 0; i < asteroids.size(); i++) {
      stroke(255);
      noFill();
      Asteroid asteroid = asteroids.get(i);
      asteroid.render();
      asteroid.update();
      asteroid.wrap();
      
      /*
      if ((ship.hits(asteroid.pos, asteroid.r)) && (ship.flashing == false)) {
        state = 2; //collision
      }//That is a collision
      
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

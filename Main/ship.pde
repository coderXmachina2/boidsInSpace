class Roci {
  PVector pos; //position
  PVector vel; //veloc
  PVector acc; //acceleration
  PVector obj;
  
  //for flocking rules
  PVector modSep;
  PVector modAli;
  PVector modCoh;
  
  //evasion
  PVector modEvade;
  PVector evAs;
  
  float r;
  float rSensorBub;
  int senseDampen;
  boolean isAccel = false;

  float rotation;
  float heading;
  
  float maxforce;    // Maximum steering force
  float maxspeed;    // Maximum speed
  
  
  
  Roci(float x, float y) {
    rotation = 0;
    pos = new PVector(x, y);
    vel = new PVector(0, 0);
    acc = new PVector(0, 0);
    obj = new PVector(width/2, 0);
    
    
    r = 7.5;       //determines the size of the boid
    rSensorBub = r+100;
    senseDampen = 18;
    heading = 0;   //initial vector

    maxspeed = 10; //
    maxforce = 0.2; //
  }

  void runRoci(ArrayList<Roci> rocis) {
    fleet(rocis); 
    
    update();
    render(); 
    checkturn();
    borders();
    diagnostics();
  }

  void update() {
    if (isAccel) {
      accel();
    }
    
    //recursive law of motion this is Netwons first law...
    acc.mult(0.99995); //Like Asteroids, but not short of Newtons full first Law add more zeroes
    pos.add(acc);
    
    newtonsFirstLaw(acc);
    
    //old convention
    //vel.mult(0.5); //results in some crazy shaking, if you add velocity they will
    //pos.add(vel); //locks in from moving 
  }

  void newtonsFirstLaw(PVector staysInMotion){ 
    pos.add(staysInMotion); //this is i
    //acc.normalize();
    //acc.mult(1.0000000000001);
    
  }
  
  void accel(){    
    acc = PVector.fromAngle(heading-PI/2); 
    acc.mult(0.995);
    //vel.mult(0.5);
    pos.add(acc);
  }

  void isacc(boolean b, float usage) { 
    float fuel = 100;
    fuel -= usage;
    
    isAccel = b;    
  }
    
  //this is some code associated with ship collision
  //function that returns a boolean and takes in vectors
  boolean hits(PVector apos, float ar){
    float d = dist(pos.x, pos.y, apos.x, apos.y);
    if((d <= r + ar)){
      return true; //ship has collided!
    } else {
      return false;
    }
  }
  
  boolean evadeAs(PVector apos, float ar){  
    float d = dist(pos.x, pos.y, apos.x, apos.y);
    if((d <= (rSensorBub - senseDampen)+ ar)){
      return true; //ship detects need to evade
    } else {
      return false;
    }
  }
   
  void checkturn() { 
    /*
    PVector desired = PVector.sub(obj, pos);  // A vector pointing from the position to the target
    println("Measured obj and pos angle: " + degrees(desired.heading()));  
    
    if (degrees(desired.heading()) < 90) {//rotate to the left
      println("Ship must rotate:  " + (-1 * degrees(desired.heading()) )+ "to the left\n"); 
    } else if(degrees(desired.heading()) > 90) { //rotate to the right
      println("Ship must rotate: " + (degrees(desired.heading()) - 90) + " to the left\n"); 
    } else{
       println("Engage engine!");
    }*/
    
  } 
  
  void diagnostics(){
    //notice this outputs for all individual boids
    //not a fleet diagnostic
    //print("Boid diagnostics\n");
    //print(b.heading());
    //println("Heading: " + heading);
    //println("obj Vector Heading: " + obj.heading());
    //println("Tracking position: " + pos.x , pos.y + "\n");
    //println("position Vector Heading:" + pos.heading());
    //println("Tracking Vel: " + vel.x , vel.y + "\n");
    //print("\n");
  }
 
  void borders() { //wrap around
    if (pos.x < -r) pos.x = width+(r);
    if (pos.y < -r) pos.y = height+(r);
    if (pos.x > width+r) pos.x = (-r);
    if (pos.y > height+r) pos.y = (-r);
  }

  //boid CAS laws
  void applyForce(PVector force){
    vel.add(force); //this force really just does orientation its a vector that points to the target.
  }
  
  void fleet (ArrayList<Roci> rocis){ 
  //fleet rules are in effect when there are 2 or more together
  //fleet rules are always in effect
  //pvector separation, alignment, and cohesion
  //all of our video games are just recursive
  
    modSep = separate(rocis);   // Separation
    modAli = align(rocis);      // Alignment
    modCoh = cohesion(rocis);   // Cohesion
    
    //modEvade = evade();  /*position vector of the incoming asteroid*/);
    //modEvade = evade(); //takes in the position vector of the asteroid
    //modEvade = evade(evAs); //this does not know position of asteroid
    
    // Arbitrarily weigh forces
    modSep.mult(2.5);
    modAli.mult(1.0);
    modCoh.mult(1.0);
    
    //
    //modEvade.mult(1.0);
    
    //add force vectors to acceleration, this is a course correction
    applyForce(modSep);//they will only ever move constant
    applyForce(modAli);
    applyForce(modCoh);  
    
    //applyForce(modEvade);
  }
  
  //rules
  ////////////////////////////////////////////////////////////////////////////rules

  // A method that calculates and applies a steering force towards a target
  // STEER = DESIRED MINUS VELOCITY
  // "motivation vector" steering force
  
  PVector seek(PVector target) {
    
    //PVector mouseVect = new PVector(mouseX, mouseY); //a vector from mouse to boid
    PVector desired = PVector.sub(obj, pos);  // A vector pointing from the position to the target
    
    // Scale to maximum speed
    desired.normalize();
    desired.mult(maxspeed);
        
    // Steering = Desired minus Velocity //This is the key equation
    PVector steer = PVector.sub(desired, vel);
    steer.limit(maxforce);  // Limit to maximum steering force

    return steer;
  }
     
  // Cohesion
  // For the average position (i.e. center) of all nearby boids, calculate steering vector towards that position
  PVector cohesion (ArrayList<Roci> rocis) {
    
    float neighbordist = 220; //This is an imporant parameter
                              //how far a ship has to be to be considered a member of the flock
    
    PVector sum = new PVector(0, 0);   // Start with empty vector to accumulate all positions
    int count = 0;
    
    //for every roci in the flock
    for (Roci other : rocis) {
      float d = PVector.dist(pos, other.pos);
      if ((d > 0) && (d < neighbordist)) {
        sum.add(other.pos); // Add position
        count++;
      }
    }
    if (count > 0) {
      sum.div(count);
      return seek(sum);  // Steer towards the position
    } 
    else {
      return new PVector(0, 0);
    }
  }
  
  // Alignment
  // For every nearby boid in the system, calculate the average velocity
  PVector align (ArrayList<Roci> rocis) {
    
    float neighbordist = 80; //weight to head towards general direction of everybody else, contributes towards team work describe a sphere of beign a part of a common group velocity
    
    PVector sum = new PVector(0, 0);
    int count = 0;
    for (Roci other : rocis) {
      float d = PVector.dist(pos, other.pos);
      if ((d > 0) && (d < neighbordist)) {
        sum.add(other.vel);
        count++;
      }
    }
    if (count > 0) {
      sum.div((float)count);
      // First two lines of code below could be condensed with new PVector setMag() method
      // Not using this method until Processing.js catches up
      // sum.setMag(maxspeed);

      // Implement Reynolds: Steering = Desired - Velocity
      sum.normalize();
      sum.mult(maxspeed);
      PVector steer = PVector.sub(sum, vel); //sum and velocity
      steer.limit(maxforce);
      return steer;
    } 
    else {
      return new PVector(0, 0);
    }
  }
  
  // boid separation
  // Separation
  // Method checks for nearby boids and steers away
  PVector separate (ArrayList<Roci> rocis) {
    
    float desiredseparation = 30.0f;//reduce this and they become close in
    
    PVector steer = new PVector(0, 0, 0); //initialize a null steering force
    int count = 0;
    
    // For every boid in the system, check if it's too close
    for (Roci other : rocis) {
      float d = PVector.dist(pos, other.pos); //position of the other...
      
      // If the distance is greater than 0 and less than an arbitrary amount (0 when you are yourself)
      //instead of neighbour its the asteroid
      
      if ((d > 0) && (d < desiredseparation)) { //if it is within necessary bounds to disperse then callculate
        // Calculate vector pointing away from neighbor
        PVector diff = PVector.sub(pos, other.pos);
        diff.normalize();
        diff.div(d);        // Weight by distance
        
        steer.add(diff);
        count++;            // Keep track of how many
      }
      
    }
    
    // Average -- divide by how many
    if (count > 0) {
      steer.div((float)count);
    }

    // As long as the vector is greater than 0
    if (steer.mag() > 0) {
      // First two lines of code below could be condensed with new PVector setMag() method
      // Not using this method until Processing.js catches up
      // steer.setMag(maxspeed);

      // Implement Reynolds: Steering = Desired - Velocity
      steer.normalize();
      steer.mult(maxspeed);
      steer.sub(vel);
      steer.limit(maxforce);
    }
    return steer; //steering force
  }//end of separation rule
  
  //evaive vector 
  //imagine that the if from separate was already called
 

  ////////////////////////////////////////////////////////////////////////////render

  void render() {
    //line(mouseX, mouseY, pos.x,pos.y); //a line from mouse to boid
    line(pos.x , pos.y, width/2 , 0);      //a line from boid to obj
    
    circle(pos.x, pos.y, rSensorBub); //picture of a sensor circle
    
    float theta = vel.heading() + PI/2;
    heading = theta;
    
    stroke(255);
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(theta);
    
    noFill();
    beginShape(TRIANGLES);
    vertex(0, -r*2);
    vertex(-r, r*2);
    vertex(r, r*2);
    //line(pos.x, pos.y, 540 , 0);
    
    if (isAccel) {
      stroke(map(int(random(3)), 0, 1, 0, 255));
      noFill();
      triangle(-r*1/2, r, r*1/2, r, 0, 2*r);
    }
    
    stroke(255);
    popMatrix();
  }
}

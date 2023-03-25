class SceneGameOver{
  
  
World world;
float timeStep = 1.0/30.0f;


//UI Game Variables
int salt = 0;
PImage cup;

//Positions 
float startX = 485;
float startY = 640;

//drawing to be neater 
float prevFrame;
float currFrame;

float timer = 500;
void setup() {///////////////////////////////////////////////////////////////////////////////////////////
  size(800, 600, P2D);

  ////Coding Train
  //box2d = new PBox2D(this);
  //box2d.createWorld();
  ////Create ArrayLists
  //boxes = new Arraylist<Box>();

  cup = loadImage("cup.png");

  // create the world:
  world = new World(new Vec2(0, 50), true);

  // floor
  MakeABox(new Vec2(0, 600), 800, 10, true);

  //enble Collision Listening 
  //box2d.listenForCollisions();


  // create a dynamic box:
  //Body boxBody = MakeABox(new Vec2(400, 50), 10, 10, false);
  //boxBody.setAngularVelocity(1);
}
void update() {
  
  if (timer > 0){ //start timer
   timer --; 
   
  }
  if (timer == 0){ //reset timer
    timer = 500;
    
  }
  print(timer);
  
}
void draw() {///////////////////////////////////////////////////////////////////////////////////////////

  //Coding train 
  //box2d.step();

  world.step(timeStep, 6, 2);

  //Wipes Screen
  background(0);

  for (Body body = world.getBodyList(); body != null; body = body.getNext()) {
    DrawPolygonShapeFromBody(body);
  }


  //Salt Fallss
  MakeABox(new Vec2(random(startX, startX+ 5), 112), 1, 1, false);

  //UI
  textAlign(LEFT, TOP);
  fill(255, 90);
  textSize(80);
  //text("salt, salt", 340, 100); //starting point at 485
  text("SALT, SALT", 280, 25);

  //How to Play  
  fill(255, 30);
  textSize(30);
  text("draw with your mouse ", 100, 300);
  text("to get the salt AWAY from the cup...", 100, 330);

  //Cup
  fill(200, 0, 0);
  rect(startX- 15, 550, 35, 40);
  image(cup, startX- 15, 550);


  //# Salt in Cup 
  textSize(20);
  fill(0, 70);
  textAlign(CENTER, CENTER);
  text(salt, startX, startY - 70);


  //Drawing
  rect(mouseX, mouseY, 1, 1);
}


Body MakeABox(Vec2 pos, float w, float h, boolean fixed) {
  //Step 1: Define Body 
  BodyDef def = new BodyDef();
  def.type = fixed ? BodyType.STATIC : BodyType.DYNAMIC;
  def.position = pos;

  //Step 2: Create Body 
  Body body = world.createBody(def);

  PolygonShape shape = new PolygonShape();
  shape.setAsBox(w, h);

  //Step 3: Create Shape
  FixtureDef fixture = new FixtureDef();
  fixture.shape = shape;
  fixture.density = 1;
  fixture.friction = .5;
  fixture.restitution = 0;
  
  //Convert to world
  //float box2Dw = fixture.scalarPixelsToWorld(w/2);


  //Step 4: Create Fixture 
  body.createFixture(fixture);




  //if (pos.y > 400) {
  //  fixture.destroyBody(body);
  //}
  return body;
}

void DrawPolygonShapeFromBody(Body body) {

  pushMatrix();
  Vec2 pos = body.getPosition();
  translate(pos.x, pos.y);
  rotate(body.getAngle());


  fill(body.isAwake() ? 255 : 128);
  noStroke();

  Fixture f = body.getFixtureList();
  PolygonShape ps = (PolygonShape) f.getShape();

  beginShape();
  for (int i = 0; i < ps.getVertexCount(); i++) {
    Vec2 v = ps.getVertex(i);
    vertex(v.x, v.y);
  }
  endShape(CLOSE);
  popMatrix();
}

void drawing() {
}

void mouseDragged() {

  fill(200, 0, 0);
  MakeABox(new Vec2(mouseX, mouseY), 3, 3, true);
  MakeABox(new Vec2(mouseX +1, mouseY +1), 3, 3, true);
  MakeABox(new Vec2(mouseX-1, mouseY-1), 3, 3, true);

  //filling in the gaps
  MakeABox(new Vec2(mouseX+.5, mouseY+.5), 3, 3, true);
  MakeABox(new Vec2(mouseX-.5, mouseY-.5), 3, 3, true);



  rect(mouseX, mouseY, 3, 3);
}

void isDead() {
  // killBody();
}


void beginContact(Contact contact) { 
  //tells which Fixture collided

  //which Body is it attached to

  //which of our object is associated with that body? (our job, not box 2d like those^)
}
}

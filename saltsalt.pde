//Vaarun's 420 Class Template + Sugar Sugar Inspo 
//Box2D Physics Engine Experiment

import org.jbox2d.common.*;
import org.jbox2d.collision.*;
import org.jbox2d.callbacks.*;
import org.jbox2d.dynamics.*;

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
void setup() {
  size(800, 600, P2D);

  cup = loadImage("cup.png");

  // create the world:
  world = new World(new Vec2(0, 50), true);

  // floor
  MakeABox(new Vec2(0, 600), 800, 10, true);




  // create a dynamic box:
  //Body boxBody = MakeABox(new Vec2(400, 50), 10, 10, false);
  //boxBody.setAngularVelocity(1);
}
void update() {
}
void draw() {



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

  BodyDef def = new BodyDef();
  def.type = fixed ? BodyType.STATIC : BodyType.DYNAMIC;
  def.position = pos;

  Body body = world.createBody(def);

  PolygonShape shape = new PolygonShape();
  shape.setAsBox(w, h);

  FixtureDef fixture = new FixtureDef();
  fixture.shape = shape;
  fixture.density = 1;
  fixture.friction = .5;
  fixture.restitution = 0;

  body.createFixture(fixture);
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

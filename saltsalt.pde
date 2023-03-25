//Vaarun's 420 Class Template + Sugar Sugar Inspo 
//Box2D Physics Engine Experiment

import org.jbox2d.common.*;
import org.jbox2d.collision.*;
import org.jbox2d.callbacks.*;
import org.jbox2d.dynamics.*;

World world;
float timeStep = 1.0/30.0f;

void setup() {
  size(800, 600, P2D);

  // create the world:
  world = new World(new Vec2(0, 50), true);

  // create a static box:
  MakeABox(new Vec2(0, 600), 800, 10, true);

  text("salt, salt", 100, 100, 100, 100);

  // create a dynamic box:
  //Body boxBody = MakeABox(new Vec2(400, 50), 10, 10, false);
  //boxBody.setAngularVelocity(1);
}
void draw() {

  world.step(timeStep, 6, 2);

  background(0);

  for (Body body = world.getBodyList(); body != null; body = body.getNext()) {
    DrawPolygonShapeFromBody(body);
  }
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



void mousePressed() {
    MakeABox(new Vec2(mouseX, mouseY), 1, 1, false);

}

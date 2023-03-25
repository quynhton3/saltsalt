//Vaarun's 420 Class Template + Sugar Sugar Inspo 
//Box2D Physics Engine Experiment

import org.jbox2d.common.*;
import org.jbox2d.collision.*;
import org.jbox2d.callbacks.*;
import org.jbox2d.dynamics.*;

//import pbox2d.*; //from CodingTrain
//line 4, 7
import shiffman.box2d.*;
import org.jbox2d.collision.shapes.*;
//List of rectables from CodingTrain
//ArrayList<Box> boxes;
//PBox2d box2d;



//Scenes
SceneGameOver sceneGameOver;
ScenePlay1 scenePlay1;
ScenePlay2 scenePlay2;
SceneTitle sceneTitle;

void setup() {
  size(800, 600);
  switchSceneGameOver();
  
}


void draw() {
    if (sceneGameOver != null) {
    sceneGameOver.update();
    if (sceneGameOver != null) sceneGameOver.draw(); // this extra if statement exists because the sceneTitle.update() might result in the scene switching...
  } else if (scenePlay1 != null) {
    scenePlay1.update();
    if (scenePlay1 != null) scenePlay1.draw();
  } else if (scenePlay2 != null) {
    if (scenePlay2 != null) scenePlay2.draw();
  } else if (sceneTitle != null) {
    sceneTitle.update();
    if (sceneTitle != null) sceneTitle.draw();
  }
  
  
  
  
  
}
  //switching
  void switchSceneGameOver() {
  sceneGameOver = new SceneGameOver();
  }

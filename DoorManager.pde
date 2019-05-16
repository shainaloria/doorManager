import processing.serial.*;
import processing.video.*;

Capture cam;
Serial myPort;      // Create object from Serial class
int val = 0, val1;  // Data received from the serial port
int s = second();   // Values from 0 - 59
int m = minute();  // Values from 0 - 59
int h = hour();    // Values from 0 - 23
int x = 269;
int y = mouseY;
int value = 255;

PFont raleway;
String status = "Locked";

void setup()
{
  size(400, 600);
  background(255);
  smooth();
                                  
  raleway = createFont("Raleway-Light.ttf", 34);                //Text Font
  textFont(raleway);
  
  String portName = Serial.list()[0];                           //Processing to Arduino
  myPort = new Serial(this, portName, 9600);
  
  String[] cameras = Capture.list();                            //Camera
  if (cameras.length == 0) 
  {
    println("There are no cameras available for capture.");
    exit();
  } 
  else 
  {
    println("Available cameras:");
    for (int i = 0; i < cameras.length; i++) 
    {
      println(cameras[i]);
    }
    // The camera can be initialized directly using an element from the array returned by list():
    cam = new Capture(this, cameras[0]);
  }
}

void draw()
{
  while ( myPort.available() > 0) // If data is available,
  {  
       val1 = myPort.read(); 
  }
  stroke(255);                   //to remove black outline
                                 //Constant texts you'll see all throughout
  textSize(30); 
  fill(135, 206, 235);
  text("Door Manager", 10, 30);
  text(status, 60, 510);         //"Locked" or "Unlocked"
  textSize(10);
  text("by Shaina Loria & Nica Medrano", 230, 20);
  text("CIE 150 Project", 230, 30);

  //On and Off switch
  rect(250, 480, 80, 40, 60);
  fill(51, 177, 229);
  ellipse(x, 500, 40, 40);

  if (cam.available() == true) 
  {
    cam.read();
  }
  image(cam, 20, 150, 360, 270);
  if(val1==1)        //if button (hardware) is pressed, notification bar will appear
  {
    rect(20, 40, 360, 50, 10);

    textSize(10);
    fill(0);
    text("NOTIFICATION", 30, 55);

    textSize(14);            //notification message and time
    text("Someone's at the door. Tap to view.", 30, 80);
    text(h, 325, 80);
    text(":", 345, 80);
    text(m, 350, 80);
  }
}


void mouseClicked() 
{
  if ((mouseX > 20) && (mouseX < 360) && (mouseY > 40) && (mouseY < 90))   //if click is done within the coordinates of notification box, camera will turn on
  {
    fill(255);
    stroke(255);
    rect(20, 40, 360, 50);
    cam.start();     
  }
}

void mouseDragged()
{
  x = mouseX;

  if (mouseX <=269)       //Lock
  {
    x=269;
    val = 0;
    fill(255);
    stroke(255);
    rect(40, 470, 150, 100);
    status = "Locked";
  } else if (mouseX >= 310) //Unlock
  {
    x=310;
    val = 90;
    //unlock    
    fill(255);
    stroke(255);
    rect(40, 470, 150, 100);
    status = "Unlocked";
  }
  myPort.write(val);
}

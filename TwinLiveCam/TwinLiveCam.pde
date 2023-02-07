import gab.opencv.*;
import processing.video.*;
import java.awt.*;

Capture leftVideo;
Capture rightVideo;
OpenCV opencv;
int camLeft = 0;
int camRight = 1;

void setup() {
  size(1280, 480);
  leftVideo = new Capture(this, "pipeline:ksvideosrc device-index="+camLeft);
  rightVideo = new Capture(this, "pipeline:ksvideosrc device-index="+camRight);
  opencv = new OpenCV(this, 640, 480);
  opencv.loadCascade(OpenCV.CASCADE_FRONTALFACE);

  leftVideo.start();
  rightVideo.start();
}

void draw() {
  opencv.loadImage(leftVideo);
  opencv.loadImage(rightVideo);

  image(leftVideo, 0, 0, width / 2, height);
  image(rightVideo, width / 2, 0, width / 2, height);

  noFill();
  stroke(0, 255, 0);
  strokeWeight(3);
  Rectangle[] faces = opencv.detect();
  //println(faces.length);

  for (int i = 0; i < faces.length; i++) {
    //println(faces[i].x + "," + faces[i].y);
    rect(faces[i].x, faces[i].y, faces[i].width, faces[i].height);
  }
}

void captureEvent(Capture c) {
  c.read();
}

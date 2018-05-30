
FuenteSonora f1;
FuenteSonora f2;
FuenteSonora f3;

import ddf.minim.*;
import ddf.minim.effects.*;

Minim minim;

Slider Sspeed;
boolean mouseFlag;

boolean showgui = true;

AudioRecorder recorder;
AudioOutput   out;

int cntrenders =0; 
void setup() {
  size(600, 600);

  minim = new Minim(this);

  Sspeed = new Slider(75, 25, 100, 25, 0.0, 0.5, 0.2);

  f1 = new FuenteSonora("fijo1.wav", new PVector(width  * 2/8, height *2/8));
  f1.initsound();
  f2 = new FuenteSonora("fijo2.wav", new PVector(width  * 6/8, height *6/8));  
  f2.initsound();

  //El f3 es el posta :
  f3 = new FuenteSonora("move3.wav", new PVector(width  /2, height /2));
  f3.initsound();
  f3.ismoving = true;
  mouseFlag = true;
  
  ///AudioInput in = minim.getLineIn(Minim.STEREO, 2048);
  //out = minim.getLineOut(Minim.STEREO, 2048);
  out = minim.getLineOut();
  //cntrenders + "0.wav"
  recorder = minim.createRecorder(out, "0.wav", true);
  
  
 // println("file/" + countname + ".wav");
}


void draw() {
  background(255);
  f1.display();
  f2.display();
  f3.display();
  
  //out = minim.getLineOut(Minim.STEREO, 2048);

  f3.moversobrelospuntos();
  f3.renderPuntos();

  if (showgui) {

    Sspeed.display();
    Sspeed.checkinput();
  } else if(!overCircle(f1.pos.x,f1.pos.y,f1.size) && 
            !overCircle(f2.pos.x,f2.pos.y,f2.size)){
    if (mousePressed && mouseFlag) {
      mouseFlag = false;  
      println("X : " + mouseX);
      println("Y : " + mouseY);
      f3.puntos.add(new PVector(mouseX, mouseY));
    }

    if (!mousePressed) {
      mouseFlag = true;
    }
  }
  
  text("framerate : " + frameRate,20,height - 20);
}

void keyPressed() {


  if (key == 'c') {
    println("/n/n/n/n/n/n/n/n/n/n/n/n/n/n");
    f3.puntos.clear();
    f3.ppos =0;
  }

  if (key == 'g') {
    showgui = !showgui;
  }
  
   if ( key == 'r' ) 
  {
   // println("RECORD");
    if ( recorder.isRecording() ) {
      println("END RECORDING");
      recorder.endRecord();
    }
    else 
    {
      println("START RECORDING");
      recorder.beginRecord();
    }
  }
  
  if ( key == 's' ){
    recorder.save();
    println("Done saving.");
  }
}
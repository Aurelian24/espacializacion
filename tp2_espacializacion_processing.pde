
import java.io.File;
import ddf.minim.*;
import ddf.minim.effects.*;


FuenteSonora f1;
FuenteSonora f2;
FuenteSonora f3;

Minim minim;

AudioRecorder recorder;
AudioOutput   out;

boolean mouseFlag;



/************Interfaz************/
Slider Sspeed;
int cntrenders =0; 
Bang bf1; 
Bang bf2;
Bang bf3;
boolean showgui = true;
float gpx = 40;
float gpy = 25;
float alto = 25;
float sepy = alto+10;

void setup() {
  size(800, 800);

  minim = new Minim(this);


  Sspeed = new Slider(gpx +60, gpy+10, 170, alto, 0.0, 0.2, 0.02, "Speed");
  gpy+=40;
  bf1 = new Bang(gpx, gpy+=sepy, 50, alto, "Fijo 1");
  bf2 = new Bang(gpx+60, gpy, 50, alto, "Fijo 2");
  bf3 = new Bang(gpx+120, gpy, 50, alto, "Movil");

  f1 = new FuenteSonora("fijo1.wav", new PVector(width  * 2/8, height *2/8), "F1");
  f1.initsound();
  f2 = new FuenteSonora("fijo2.wav", new PVector(width  * 6/8, height *6/8), "F2");  
  f2.initsound();

  //El f3 es el posta :
  f3 = new FuenteSonora("move.wav", new PVector(width  /2, height /2), "M1");
  f3.initsound();
  f3.ismoving = true;
  mouseFlag = true;

  ///AudioInput in = minim.getLineIn(Minim.STEREO, 2048);
  //out = minim.getLineOut(Minim.STEREO, 2048);
  out = minim.getLineOut();
  //cntrenders + "0.wav"
  recorder = minim.createRecorder(out, "0.wav", true);
}


void draw() {
  background(255);


  f3.moversobrelospuntos();
  f3.renderPuntos();

  f1.display();
  f2.display();
  f3.display();

  if (bf1.isActive) {
    selectInput("Elegir fijo1", "cargarfijo1");
  }
  if (bf2.isActive) {
    selectInput("Elegir fijo2", "cargarfijo2");
  }
  if (bf3.isActive) {
    selectInput("Elegir fijo3", "cargarmueve1");
  }

  float rectguiX =0;
  float rectguiY =0;
  float rectguiW =200+10;
  float rectguiH = gpy*1.7+10;
  if (showgui) {
    rectMode(CORNER);
    rect(rectguiX, rectguiY, rectguiW, rectguiH);
    rectMode(CENTER);
    fill(255);
    text("CARGAR : ", gpx+20, gpy-sepy);
    bf1.run();
    bf2.run();
    bf3.run();
    Sspeed.display();
    Sspeed.checkinput();
    fill(255);
    textAlign(LEFT);
    float sept = -20;
    text("C : Borrar recorrido.", gpx+sept, gpy+sepy);
    text("G : Ocultar/mostrar interfaz", gpx+sept, gpy+sepy*1.5);
    textAlign(CENTER,CENTER);
  }
  

  
  if (!overCircle(f1.pos.x, f1.pos.y, f1.size) && 
    !overCircle(f2.pos.x, f2.pos.y, f2.size) && 
    f3.puntoquetoca() == -1 &&
    (!(overRect_corner(rectguiX, rectguiY, rectguiW, rectguiH)) || !showgui)
    ) {
    if (mousePressed && mouseFlag) {
      mouseFlag = false;  
      print("X : " + mouseX + " " );
      println("Y : " + mouseY);
      f3.puntos.add(new PVector(mouseX, mouseY));
    }
    if (!mousePressed) {
      mouseFlag = true;
    }
  }


  //ESCALAS : 
  int cant = 10;
  /*for(int i =0; i<cant; i++){
   
   String pan = "" +  nf(map(i, 0, cant-1, -1, 1),0,2 );
   text(pan,map(i,0,cant,0,width),height-30); 
   }*/
  //text("framerate : " + frameRate,20,height - 20);
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
    } else 
    {
      println("START RECORDING");
      recorder.beginRecord();
    }
  }

  if ( key == 's' ) {
    recorder.save();
    println("Done saving.");
  }
}




//CUANTO A QUE HAY UNA MANERA MAS FACIL QUE HACER UN CALLBACK DISTINTO POR CADA COSO. PERO BUENO YA RE FUE RE GIL
//Callback cargar imagen: 
void cargarfijo1(File selection) {
  if (selection == null) {
    println("Window was closed or the user hit cancel.");
  } else {
    f1.sonido = minim.loadFile(selection.getAbsolutePath());
    f1.sonido.loop();
  }
}

//Callback cargar imagen: 
void cargarfijo2(File selection) {
  if (selection == null) {
    println("Window was closed or the user hit cancel.");
  } else {
    f1.sonido = minim.loadFile(selection.getAbsolutePath());
    f1.sonido.loop();
  }
}
//Callback cargar imagen: 
void cargarmueve1(File selection) {
  if (selection == null) {
    println("Window was closed or the user hit cancel.");
  } else {
    f1.sonido = minim.loadFile(selection.getAbsolutePath());
    f1.sonido.loop();
  }
}
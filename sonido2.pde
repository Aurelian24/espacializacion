class FuenteSonora {

  PVector pos ;

  float size = 50;

  boolean agarrado;
  AudioPlayer sonido;

  String ruta;

  boolean ismoving ; 


  int ppos = 0;
  float move = 0;



  String name;

  float minpan = -1, maxpan = 1;
  float mindb = -20, maxdb = 6;

  //PUNTOS: 
  float psize = 20; //Size de los puntos;
  boolean pagarrado = false;
  ArrayList<PVector> puntos;
  float speed = 0.05;
  int Npagarrado = -1;
  
  FuenteSonora(String _ruta, PVector _pos, String _name) {

    name = _name;
    puntos = new ArrayList<PVector>();
    ruta = _ruta;
    pos = _pos;

    PVector [] initpoints = {new PVector(284, 592), 
      new PVector(285, 484), 
      new PVector(284, 272), 
      new PVector(287, 121), 
      new PVector(118, 55), 
      new PVector(48, 172), 
      new PVector(151, 295), 
      new PVector(380, 332), 
      new PVector(539, 374), 
      new PVector(551, 484), 
      new PVector(442, 544), 
      new PVector(361, 439), 
      new PVector(321, 371), 
      new PVector(309, 229), 
    };

    for (int i =0; i<initpoints.length; i++) {
      puntos.add(initpoints[i]);
      //println("Pan P"+i+": "+ map(initpoints[i].x, 0, width, -1, 1));
      print("Pan P"+i+": "+ map(initpoints[i].x, 0, width, -100, 100) + "%");
      println(" Vol P"+i+": "+ map(initpoints[i].y, 0, height, -20, 6) + "Db");
    }
    println(" ");
  }

  void initsound() {
    sonido = minim.loadFile(ruta);
    sonido.loop();
    sonido.setPan(map(pos.x, 0, width, -1, 1));
    sonido.setGain(map(pos.y, 0, height, -30, 6));
  }



  void display() {

    strokeWeight(5);
    stroke(0);
    fill(255);

    if (overCircle(pos.x, pos.y, size)) {
      fill(0);
      if (mousePressed) {
        agarrado = true;
        fill(255, 0, 0);
      }
    }

    if (!mousePressed) {
      agarrado = false;
    }

    if (agarrado) {
      pos.x = mouseX;
      pos.y = mouseY;
    }

    sonido.setPan(map(pos.x, 0, width, -1, 1));
    sonido.setGain(map(pos.y, 0, height, -20, 6));    

    ellipse(pos.x, pos.y, size, size);
    textAlign(CENTER, CENTER);

    fill(0);
    textSize(23);
    text(name, pos.x, pos.y);

    String panval =  nf(map(pos.x, 0, width, -1, 1), 0, 2);
    textSize(18);
    text("Pan : " + panval, pos.x-40, pos.y+40);
    text("Vol : " + nf(map(pos.y, 0, height, -20, 6), 0, 2) + "Db", pos.x-40, pos.y+60);
  }

  void renderPuntos() {
    strokeWeight(3);
    stroke(0);
    for (int i=puntos.size()-1; i>=0; i--) {
      if (i > 0) {
        line(puntos.get(i-1).x, puntos.get(i-1).y, puntos.get(i).x, puntos.get(i).y);
      }
    }
    

    for (int i=puntos.size()-1; i>=0; i--) {
      if (overCircle(puntos.get(i).x, puntos.get(i).y, psize)) {
        if(mousePressed){
           pagarrado = true;
           Npagarrado = i;
           fill(255, 255, 0);
        }else{
           fill(220, 220, 0);
        }
      } else {
        fill(180, 180, 0);
      }
    
      
      ellipse(puntos.get(i).x, puntos.get(i).y, psize, psize);
      fill(0);
      textSize(18);
      text("N: " + i, puntos.get(i).x, puntos.get(i).y+25);
    }
    
    if(pagarrado && Npagarrado != -1){
        puntos.get(Npagarrado).x = mouseX;  
        puntos.get(Npagarrado).y = mouseY;
    }
    
    if(!mousePressed){
      pagarrado = false;
      Npagarrado = -1;
    }
    
  }

  void moversobrelospuntos() {
    if (puntos.size() > 1) {
      move+=Sspeed.value;  
      //println("PPOS : " + ppos);
      //println("move : " + move);

      if (move <= 1) {


        if (ppos == puntos.size()-1) {
          pos.x = puntos.get(ppos).x * (1- move) + puntos.get(0).x * move;
          pos.y = puntos.get(ppos).y * (1- move) + puntos.get(0).y * move;
        } else {
          pos.x = puntos.get(ppos).x * (1- move) + puntos.get(ppos+1).x * move;
          pos.y = puntos.get(ppos).y * (1- move) + puntos.get(ppos+1).y * move;
        }
      }

      if (move > 1) {
        move =0;
        ppos++;
        if (ppos == puntos.size()) {
          ppos = 0;
        }
      }
    }
  }

  //Si no toca ningun punto devuelve -1, si no, el punto que toca
  int puntoquetoca() {
    for (int i =0; i<f3.puntos.size(); i++) {
      if (overCircle(f3.puntos.get(i).x, f3.puntos.get(i).y, f3.psize)) {
        return i;
      }
    }
    return -1;
  }
}

boolean overRect_corner(float x, float y, float w, float h) {
  if (mouseX > x && mouseX < x+w && mouseY > y && mouseY < y+h) {
    return true ;
  } else {
    return false;
  }
}

boolean overCircle(float x, float y, float diameter) {
  float disX = x - mouseX;
  float disY = y - mouseY;
  if (sqrt(sq(disX) + sq(disY)) < diameter/2 ) {
    return true;
  } else {
    return false;
  }
}
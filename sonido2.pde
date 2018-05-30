class FuenteSonora {

  PVector pos ;

  float size = 50;

  boolean agarrado;
  AudioPlayer sonido;

  String ruta;

  boolean ismoving ; 

  ArrayList<PVector> puntos;
  int ppos = 0;
  float move = 0;
  float speed = 0.05;

  
  FuenteSonora(String _ruta, PVector _pos) {

    puntos = new ArrayList<PVector>();
    ruta = _ruta;
    pos = _pos;
    
  }

  void initsound() {
    sonido = minim.loadFile(ruta);
    sonido.loop();
    sonido.setPan(map(pos.x, 0, width, -1, 1));
    sonido.setGain(map(pos.y, 0, height, -20, 20));
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
    sonido.setGain(map(pos.y, 0, height, -20, 20));    
    
    ellipse(pos.x, pos.y, size, size);
  }

  void renderPuntos() {

    for (int i=puntos.size()-1; i>=0; i--) {
      fill(200, 200, 0);
      ellipse(puntos.get(i).x, puntos.get(i).y, 20, 20);
      fill(0);
      textSize(18);
      text("N: " + i , puntos.get(i).x ,puntos.get(i).y+25);
      if(i > 0){
        line(puntos.get(i-1).x,puntos.get(i-1).y,puntos.get(i).x,puntos.get(i).y);
      }
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
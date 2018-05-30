//Clase slider, esta es la clase slider que se usa dentro del solllll, se puede usar en cualquier lugar igual
public class Slider {

  public float x, y, w, h; //posición en x, posición en y, ancho y alto
  public float value; //El valor actual en el que esta ese slider

  public float min, max; //El minimo y el maximo

  public color backcolor; //Color de atras
  public color topcolor; //color de adelante

  public boolean isActivable; //si se puede o no ser activado (esta quedo de otro, pero la dejo por si alguien que no soy yo la quiere usar en otro lugar


  //Bueno los respectivos parametros
  Slider(float _x, float _y, float _w, float _h, float _min, float _max, float _value) {

    x =_x;
    y =_y;
    w = _w;
    h = _h;

    backcolor = color(120, 150, 120); //Estos se podrían pasar como parametros, pero como los uso una sola vez, los hardcodeo para que tengan los colores dol sol
    topcolor = color(120, 150, 160);

    min = _min;
    max = _max;
    value = _value;

    isActivable = true;
  }

  public void run() {
    display();
    checkinput();
  }

  public void display() {
    noStroke();
    rectMode(CENTER);
    fill(backcolor);
    displayShape();
    fill(255, 0, 0);
    rectMode(CENTER);
  }

  protected void displayShape() {

    strokeCap(ROUND);
    strokeWeight(2);
    
    
    //Bueno , esto para que cambien de color mientras los vas moviendo.
    //Y también los muestra claro
    stroke(255, map(value, min, max, 255, 0), 0);
    fill(255, map(value, min, max, 255, 0), 0);

    rect(x, y, w, h);

    stroke(200, map(value, min, max, 200, 0), 0);
    fill(200, map(value, min, max, 200, 0), 0);
    rectMode(CORNERS);
    rect(x-w/2, y-h/2, map(value, min, max, x-w/2, x+w/2), y+h/2);
    fill(255, 0, 0);
  }
  //Checkea el inputttttt que basicamente es el mouse, y setea el valor a ese input
  public void checkinput() {
    if (isActivable) {
      if (mousePressed 
        && mouseX > x - w/2
        && mouseX < x + w/2
        && mouseY > y - h/2
        && mouseY < y + h/2) {
        value = map(mouseX, x-w/2, x+w/2, min, max);
      }
    }
  }

  public void setpos(float _x, float _y) {
    x = _x;
    y = _y;
  }
}
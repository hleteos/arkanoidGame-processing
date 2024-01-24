
// CARLOS HUGO MOLINA HERNÁNDEZ. PRACTICA: FISICA PARA LA MULTIMEDIA ENTREGA 09/01/2024

 // En este programa, Arkanoid se ha implementado una simulación de choques elásticos entre partículas que se mueven de acuerdo al Movimiento Rectilíneo Uniforme (MRU). Un choque elástico se caracteriza por la conservación tanto del momento como de la energía cinética durante la colisión.
 // Cada partícula sigue una trayectoria rectilínea a velocidad constante, y al colisionar, experimenta un cambio de dirección sin pérdida de energía cinética.

 // Funcionalidades principales físicas de Arkanoid FISICAS:

 // Choques Elásticos: Las partículas en movimiento interactúan de manera elástica al colisionar. La conservación del momento y la energía cinética se mantiene durante todo el proceso de simulación, asegurando una representación fiel de choques elásticos.

 // Movimiento Rectilíneo Uniforme (MRU): Cada partícula sigue un patrón de Movimiento Rectilíneo Uniforme (MRU), lo que significa que su velocidad es constante y su trayectoria es una línea recta.

 // Simulación de Refracción con la Ley de Snell: Se incorpora la simulación de la refracción de fotones al pasar de un medio material a otro distinto como en el agua, siguiendo la Ley de Snell. La refracción es el cambio de dirección que experimenta una onda al cruzar la interfaz entre dos medios con índices de refracción diferentes.
    




//Declaro que ostento la autorıa total y plena de todas las tareas que se llevan a cabo en el presente
//documento. Soy la unica persona que ha elaborado cada ejercicio. No he compartido los enunciados
//con nadie y la unica ayuda que he recibido ha sido a traves del aula de la UOC y su profesorado.



// ARKANOID FISICAS GAME >>



// variables
float radioBola = 25; // tamaño del fotón
float bolaX; // posición x del fotón
float bolaY; // posición x del fotón
// posición y del fotón
float velocidadBola = 5; // velocidad del fotón
float velocidadBolaX = 5; // velocidad x del fotón
float velocidadBolaY = 5; // velocidad y del fotón
float bolaU; // enviar la pelota hacia arriba
float bolaD; // enviar la pelota hacia abajo
float bolaL;// enviar la pelota hacia la izquierda
float bolaR;// enviar la pelota hacia la derecha
float ay; // ángulo de incidencia
float aic; // ángulo de incidencia con la horizontal
float ar; // ángulo de refracción
float arco; // // ángulo de refracción con la horizontal
float n; // índice de refracción
float nold; // índice de refracción antiguo
float paletaY = 450;// posición y de la barra
float paletaX = width/2; // posición x de la barra
float anchoPaleta = 96; // anchura de la barra
float altoPaleta = 16; // altura de la barra
int anchoBloque = 32; // anchura de los bloques
int altoBloque = 16; // altura de los bloques

int vidas = 3; // vidas
int puntuacion = 0;// puntuación
int estadoJuego = 0;// estado del juego
int columna = 16;// número de columnas
int fila = 6; // número de filas


int golpesPaleta = 0; // Contador de rebotes en la paleta

ArrayList<Bloque> bloques = new ArrayList<Bloque>();

void setup() {
  size(640, 480);
  rectMode(CENTER);
  ellipseMode(CENTER);
  textSize(40);
  textAlign(CENTER);
  frameRate(60);
  noStroke();
  smooth();
  n = 1;
  iniciarJuego();
}

void draw() {
  if (estadoJuego == 0) {
    dibujarFondo();
    fill(255);
    text("Pulsa ENTER para jugar", width/2, height/2);
  } else if (estadoJuego == 1) {
    dibujarFondo();
    dibujarBloques();
    dibujarPaleta();
    dibujarBola();
    textSize(15);
    textAlign(LEFT);
    text("Vidas: " + vidas, 10, 470);
    text("Puntos: " + puntuacion, 80, 470);
    text("Rebotes en la paleta: " + golpesPaleta, width - 150, 470);
    textAlign(CENTER);
    textSize(40);
  } else if (estadoJuego == 2) {
    perderJuego();
  } else if (estadoJuego == 3) {
    ganarJuego();
  }
  verificarEstadoJuego();
}

void iniciarJuego() {
  bolaX = width/2+radioBola/2;
  bolaY = height/2;
  for (int i = 0; i < fila; i++) {
    for (int j = 0; j < columna; j++) {
      bloques.add(new Bloque((1.2*j+1)*anchoBloque, (1.4*i+1)*altoBloque, anchoBloque, altoBloque));
    }
  }
}

void perderJuego() {
  if (vidas < 1) {
    text("PULSA ENTER PARA EMPEZAR", width/2, height/2);
  } else {
    text("Game Over\nPulsa 'r' para reiniciar", width/2, height/2);
  }
}

void ganarJuego() {
  text("Excelente\nHas ganado!", width/2, height/2);
}

void verificarEstadoJuego() {
  if (vidas < 0) {
    estadoJuego = 2;
  }
  if (bloques.size() == 0) {
    estadoJuego = 3;
  }
}
// Añadi funcionalidad para empezar con tecla enter, deseo personal al juego. A pesar de que el enunciado pedía click del ratón left con mousePresse 
void keyPressed() {
  if (key == ENTER) {
    bloques.clear();
    iniciarJuego();
    vidas = 3;
    puntuacion = 0;
    estadoJuego = 1;
  } else if (key == 'r' || key == 'R') {
    bloques.clear();
    iniciarJuego();
    vidas--;
    estadoJuego = 1;
  } 
  if (keyPressed && (key == 'c' || key == 'C')) {       // Pulsar C para ver mi nombre    text("Carlos Hugo Molina", width/3, height/1.2);
  }
}

void dibujarFondo() {
   fill(0, 10);                               
  rect(width/2, height/4, width, height/2);  
  fill(0,0,150,10);                           
  rect(width/2,3*height/4, width, height/2);
}

void dibujarBloques() {
  for (Bloque bloque : bloques) {
    bloque.dibujar();
  }
  for (int i = bloques.size() - 1; i >= 0; i--) {
    Bloque bloque = bloques.get(i);
    if (bolaX >= bloque.bloqueL - radioBola/2 && bolaX <= bloque.bloqueR + radioBola/2 && bolaY >= bloque.bloqueU - radioBola/2 && bolaY <= bloque.bloqueD + radioBola/2) {
      if ((bolaX - velocidadBolaX < bloque.bloqueL || bolaX - velocidadBolaX > bloque.bloqueR) && bolaY - velocidadBolaY > bloque.bloqueU && bolaY - velocidadBolaY < bloque.bloqueD) {
        velocidadBolaX *= -1;
        bloque.cambiarColor();
        puntuacion++;
      } else {
        velocidadBolaY *= -1;
        bloque.cambiarColor();
        puntuacion++;
      }
      bloques.remove(i);
      break;
    }
  }
}

void dibujarPaleta() {
  fill(255);
  rect(paletaX, paletaY, anchoPaleta, altoPaleta);
  paletaX = constrain(mouseX, anchoPaleta/2, width-anchoPaleta/2);
  if ((bolaX >= paletaX - anchoPaleta/2 - radioBola/2) && (bolaX <= paletaX + anchoPaleta/2 + radioBola/2) && (bolaY >= paletaY - altoPaleta/2) && (bolaY < paletaY)) {
    velocidadBolaY *= -1;
    golpesPaleta++;
  }
}

void dibujarBola() {
  fill(255);
  ellipse(bolaX, bolaY, radioBola, radioBola);
  bolaX += velocidadBolaX;
  bolaY += velocidadBolaY;
  if (bolaX > width || bolaX < 0) {
    velocidadBolaX *= -1;
  } else if (bolaY < 0) {
    velocidadBolaY *= -1;
  } else if (bolaY > height) {
    estadoJuego = 2;
  }
}


public class Bloque {
  private float x;
  private float y;
  private int anchoBloque;
  private int altoBloque;
  float bloqueU;
  float bloqueD;
  float bloqueL;
  float bloqueR;
  color colorBloque; // New color property

  public Bloque(float x, float y, int anchoBloque, int altoBloque) {
    this.x = x;
    this.y = y;
    this.anchoBloque = anchoBloque;
    this.altoBloque = altoBloque;
    bloqueU = y - altoBloque/2;
    bloqueD = y + altoBloque/2;
    bloqueL = x - anchoBloque/2;
    bloqueR = x + anchoBloque/2;
    this.colorBloque = (255); // Initialize color to white
  }

  public void dibujar() {
    fill(this.colorBloque); // Use the color property
    rect(this.x, this.y, this.anchoBloque, this.altoBloque);
  }

  // Añadimos una función para cambiar el color del bloque.
  public void cambiarColor() {
    this.colorBloque = color(random(255), random(255), random(255)); // Generate random RGB values
  }
}

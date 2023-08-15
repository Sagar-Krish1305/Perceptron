float makeLine(float x){
  return ((3*x+200));
}
Perceptron p;

class Point{
  float x,y;
  int label;
  int r,g,b;
  Point(float x_, float y_){
    
    x = map(x_, 0,width,-width/2,width/2);
    y = map(y_, 0,height,-height/2,height/2);
    
    if(makeLine((x)) <= (y)){
      label = 1;
      r=255;
      g=0;
      b=0;
    }else{
      label = -1;
      r=255;
      g=255;
      b=0;
    }
    
  }
  Point(){
    x = (random(-width/2,width/2));
    y = (random(-height/2,height/2));
    if(makeLine(x) < (y)){
      label = 1;
    }else{
      label = -1;
    }
  }
  
  void show(){
    fill(r,g,b);
    stroke(0);
    circle(getX(x),getY(y),20);
  }
  
  void setColor(int r_, int g_, int b_){
    r = r_;
    g = g_;
    b = b_;
  }
  
}

float getX(float x){
  return map(x,-width/2,width/2,0,width);
}
  float getY(float y){
    return map(y,-height/2,height/2,height,0);
  }
  
Point makeNewPoint[] = new Point[1000];
void setup(){
  size(800,800);
  
  for(int i = 0 ; i < points.length ; i++){
    
    points[i] = new Point();
    p = new Perceptron(3);
    //if(makeLine(points[i].x) < points[i].y ){
    //  points[i].setColor(255,0,0);
    //}else{
    //  points[i].setColor(255,255,0);
    //}
      
    points[i].show();
  }
}

Point points[] = new Point[1000];

int i = 0;
int top = -1;
void mousePressed(){
  top++;
  makeNewPoint[top] = new Point(mouseX,mouseY);
  float inputs[] = {mouseX,mouseY,100};
  int labelGuessed = p.guess(inputs);
  
  if(labelGuessed == 1){
    makeNewPoint[top].setColor(255,0,0);
  }else{
    makeNewPoint[top].setColor(255,255,0);
  }
  
  
}
void draw(){
  //Point p = new Point(-width/2,0);
  //p.setColor(255,0,0);
  //p.show();
  println(top);
  for(int j = 0 ; j <= top ; j++){
     makeNewPoint[j].x += width/2;
     makeNewPoint[j].y += height/2;
     makeNewPoint[j].show();
  }
  
  
  background(255);
  line(getX(-width/2),getY(0), getX(width/2),getY(0));
  line(getX(0),getY(-height/2), getX(0),getY(height/2));
  line(getX(-width/2), getY(makeLine((-width/2))), getX(width/2), getY(makeLine((width/2))));
  line(getX(-width/2), getY(p.guessY((-width/2),100)), getX(width/2), getY(p.guessY((width/2),100)));
  
    
    i = (i+1)%points.length;
     float[] inputs = {points[i].x,points[i].y,100};
     //points[i].setColor(0,255,0);
     //points[i].show();
     //delay(100);
     if(p.guess(inputs)==1){
        points[i].setColor(255,0,0);
     }else{
        points[i].setColor(255,255,0);
     }

     p.train(inputs,points[i].label);
    
      
    
  
  
  for(int j = 0 ; j < points.length ; j++){
    points[j].show();
  }
  
  
}


class Perceptron{
  int n;
  float weights[];
  
  
  Perceptron(int n_){
    n=n_;
    weights = new float[n];

     for(int i = 0 ; i < 3 ; i++){
       weights[i] = random(-1,1);
     }
     
  }
  
  int activationFunction(float f){
    if(f <= 0) return -1;
    return 1;
  }
  int guess(float[] inputs){
    return activationFunction(Dot(inputs));
  }
  
  float Dot(float inputs[]){
    float sum = 0;
    
    for(int i = 0 ; i < 3 ; i++){
      sum += weights[i]*inputs[i];
    }
    return sum;
  }
  int error(float inputs[],int target){
    return target-guess(inputs);
  }
  
  float guessY(float x, float bias){
    return -(weights[0]/weights[1])*x - 100*(weights[2]/weights[1]);
  }
  void train(float[] inputs, int target){
     
     for(int i = 0 ; i < n ; i++){
       //println(error*inputs[i]);
        weights[i] += error(inputs,target)*inputs[i]*0.00001;
        
     }
     

    
    
  }
  
}

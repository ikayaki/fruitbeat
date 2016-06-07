int[][] nomalNote = new int[5][600];
int[][] longNoteStart =new int[2][600];
int[][] longNoteStop =new int[2][600];
PImage NoteImage, StageImage, BackImage, MusicImage, TitleImage, resultStage;
PImage longLine1, longLine2, longnote1, longnote2, longLine3;
PImage[] judgeImage = new PImage[5];
PImage[] judgeeffect = new PImage[3];
int lineTime=0, stopTime, score=0;
int[] keyability = new int[8];
int[] judge = new int[5];
int[] longJudgeStart =new int[2];
int[] longJudgeStop =new int[2];
int[] noteNomber =new int[5];
int[] hold =new int[2];
int[] longStartNomber =new int[2];
int[] longStopNomber =new int[2];
int[] lineMode = new int[2];
int[] effectSize =new int[7];
int[] effectNomber =new int[7];
int MODE=0, Perfect=0, Miss=0, Great=0,Middle=0;
int Color, combo=0, scoreMax,judgeText=4;
String lines[];



import ddf.minim.*;
Minim minim;
AudioPlayer[]  notesound=new AudioPlayer[10];
AudioPlayer  music;

void setup() {
  frameRate(60);
  size(1000, 800);
  colorMode(HSB, 100);
  textSize(100);
  startVariable();
}

void draw() {
  switch(MODE) {
  case 0:
    Title();
    break;
  case 1:
    stage();
    noteImage();
    timeControl();
    judge();
    image(judgeImage[judgeText], 850, 650);
    break;
  case 2:
    Result();
    break;
  }
}

void keyPressed() {
  if (key == 'z' && keyability[0] == 2)keyability[0] = 1;
  if (key == 'x' && keyability[1] == 2)keyability[1] = 1;
  if (key == 'c' && keyability[2] == 2)keyability[2] = 1;
  if (key == 'v' && keyability[3] == 2)keyability[3] = 1;
  if (key == 'b' && keyability[4] == 2)keyability[4] = 1;
  if (key == 'n' && keyability[5] == 2)keyability[5] = 1;
  if (key == 'm' && keyability[6] == 2)keyability[6] = 1;
  if (key == ' ' && keyability[7] == 2)keyability[7] = 1;
}

void keyReleased() {
  if (key == 'z')keyability[0]=2;
  if (key == 'x')keyability[1]=2;
  if (key == 'c')keyability[2]=2;
  if (key == 'v')keyability[3]=2;
  if (key == 'b')keyability[4]=2;
  if (key == 'n')keyability[5]=2;
  if (key == 'm')keyability[6]=2;
  if (key == ' ')keyability[7]=2;
}

void startVariable() {
  variableReint();
  TitleImage=loadImage("system/backStage.jpg");
  NoteImage=loadImage("system/note.png"); 
  StageImage=loadImage("system/stage.png");
  BackImage=loadImage("system/backStage.png");
  MusicImage=loadImage("music/musicimage.png");
  resultStage=loadImage("system/resultstage.png");
  longLine1=loadImage("system/longLine.png");
  longLine2=loadImage("system/longLine2.png");
  longLine3=loadImage("system/longLine3.png");
  longnote1=loadImage("system/longnote1.png");
  longnote2=loadImage("system/longnote2.png");
  judgeImage[0]=loadImage("system/PERFECT.png");
  judgeImage[1]=loadImage("system/GREAT.png");
  judgeImage[2]=loadImage("system/MIDDLE.png");
  judgeImage[3]=loadImage("system/MISS.png");
  judgeImage[4]=loadImage("system/noImage.png");
  judgeeffect[0]=loadImage("system/judgeeffect.png");
  judgeeffect[1]=loadImage("system/greateffect.png");
  judgeeffect[2]=loadImage("system/middleeffect.png");
  imageMode(CENTER);
  rectMode(CENTER);
  noStroke();
  minim=new Minim(this);
  notesound[1] = minim.loadFile("system/tap.wav");
  music = minim.loadFile("music/music.mp3");
  String datalines[] =loadStrings("music/musicdata.txt");
  String data[]=split(datalines[0], ",");
  stopTime=int(data[0])-1;
  Color=int(data[1]);
  scoreMax=int(data[2]);
  lines =loadStrings("music/Fumen.txt");
}

void stage() {
  background(Color, score*100/scoreMax, score*100/scoreMax);
  image(BackImage, 500, 400);
  image(StageImage, 500, 400);
  image(MusicImage, 850, 250);
  if (lineMode[0]==1)image(longLine1, 250, 400);
  else if (lineMode[0]==2) image(longLine2, 250, 400);
  else if (lineMode[0]==3) image(longLine3, 250, 400);
  if (lineMode[1]==1)image(longLine1, 650, 400);
  else if (lineMode[1]==2) image(longLine2, 650, 400);
  else if (lineMode[1]==3) image(longLine3, 650, 400);
  for(int i=0;i<2;i++){
  if(effectSize[i*6]>0){
    image(judgeeffect[effectNomber[i*6]],250+400*i,640,effectSize[i*6],effectSize[i*6]);
    effectSize[i*6]=effectSize[i*6]-5;
   }
  }
  for(int i=1;i<6;i++){
  if(effectSize[i]>0){
    image(judgeeffect[effectNomber[i]],270+60*i,640,effectSize[i],effectSize[i]);
    effectSize[i]=effectSize[i]-5;
   }
  }
}

void Title() {
  image(TitleImage, 500, 400);
  fill(0);
  rect(500, 400, 200, 200);
  image(MusicImage, 500, 400);
  fill(0, 0, 100);
  text("START", 350, 600);
  if (keyability[7] == 1)MODE=1;
}

void noteImage() {
  for (int j=0; j<5; j++) {
    for (int i=judge[j]; i<noteNomber[j]; i++) {
      image(NoteImage, 330+j*60, nomalNote[j][i]);
      if (nomalNote[j][i]>=725) {
        nomalNote[j][i]=-100;
        judge[j]++;
        combo=0;
        Miss=Miss+1;
        judgeText=3;
      } else nomalNote[j][i]=nomalNote[j][i]+12;
    }
  }
  for (int j=0; j<2; j++) {
    for (int i=longJudgeStart[j]; i<longStartNomber[j]; i++) {
      image(longnote1, 250+j*400, longNoteStart[j][i]);
      if (longNoteStart[j][i]>=725) {
        longNoteStart[j][i]=-100;
        longJudgeStart[j]++;
        longJudgeStop[j]++;
        combo=0;
        Miss=Miss+1;
        judgeText=3;
        longNoteStop[j][i]=-100;
      } else longNoteStart[j][i]=longNoteStart[j][i]+12;
    }
    for (int k=longJudgeStop[j]; k<longStopNomber[j]; k++) {
      image(longnote2, 250+j*400, longNoteStop[j][k]);
      if (longNoteStop[j][k]>=640) {
        hold[j]=0;
        longNoteStop[j][k]=-100;
        longJudgeStop[j]++;
        if (lineMode[j]==2) {
          score=score+50;
          Great=Great+1;
          judgeText=1;
          effectNomber[j*6]=1;
          effectSize[j*6]=60;
        }
        if (lineMode[j]==3) {
          score=score+100;
          Perfect=Perfect+1;
          judgeText=0;
          effectNomber[j*6]=0;
          effectSize[j*6]=60;
        }
        lineMode[j]=1;
      } else longNoteStop[j][k]=longNoteStop[j][k]+12;
    }
  }
}


void variableReint() {

  for (int j=0; j<5; j++) {
    for (int i=0; i<600; i++) {
      nomalNote[j][i]=-100;
    }
  }
  for (int j=0; j<2; j++) {
    hold[j]=0;
    for (int i=0; i<600; i++) {
      longNoteStart[j][i]=-100;
      longNoteStop[j][i]=-100;
    }
  }
  for (int i=0; i<5; i++) {
    noteNomber[i]=0;
  }
  for (int i=0; i<8; i++) {
    keyability[i]=2;
  }
  for (int i=0; i<2; i++) {
    lineMode[i]=1;
  }
}

void timeControl() {
  if (lineTime<stopTime && lineTime%5==0) {
    String data[]=split(lines[lineTime/5], ",");
    int a, b, c, d, e, longA, longB;
    longA=int(data[0]);
    a=int(data[1]);
    b=int(data[2]);
    c=int(data[3]);
    d=int(data[4]);
    e=int(data[5]);
    longB=int(data[6]);

    if (longA==1) {
      longNoteStart[0][longStartNomber[0]]=-80;
      longStartNomber[0]++;
    }
    if (longA==2) {
      longNoteStop[0][longStopNomber[0]]=-80;
      longStopNomber[0]++;
    }
    if (a==1) {
      nomalNote[0][noteNomber[0]]=-80;
      noteNomber[0]++;
    }
    if (b==1) {
      nomalNote[1][noteNomber[1]]=-80;
      noteNomber[1]++;
    }
    if (c==1) {
      nomalNote[2][noteNomber[2]]=-80;
      noteNomber[2]++;
    }
    if (d==1) {
      nomalNote[3][noteNomber[3]]=-80;
      noteNomber[3]++;
    }
    if (e==1) {
      nomalNote[4][noteNomber[4]]=-80;
      noteNomber[4]++;
    }
    if (longB==1) {
      longNoteStart[1][longStartNomber[1]]=-80;
      longStartNomber[1]++;
    }
    if (longB==2) {
      longNoteStop[1][longStopNomber[1]]=-80;
      longStopNomber[1]++;
    }
  }
  lineTime++;
  if (lineTime>stopTime+53) {
    music.close();
    minim.stop();
    MODE=2;
  }
  if (lineTime==60) music.play();
}

void judge() {
  judgeSystem(1, 0);
  judgeSystem(2, 1);
  judgeSystem(3, 2);
  judgeSystem(4, 3);
  judgeSystem(5, 4);
  judgeLongNote(0, 0);
  judgeLongNote(1, 6);
}

void judgeSystem(int a, int b) {
  if (keyability[a]==1) {
    if (nomalNote[b][judge[b]]>=558) {
      if (nomalNote[b][judge[b]]<=604||(nomalNote[b][judge[b]]>676 && nomalNote[b][judge[b]]<=724)) {
        score=score+100;
        nomalNote[b][judge[b]]=-100;
        judge[b]++;
        notesound[1].play();
        notesound[1].rewind();
        combo++;
        Great++;
        judgeText=1;
        effectSize[a]=60;
        effectNomber[a]=1;
      } else if (nomalNote[b][judge[b]]>=604 && nomalNote[b][judge[b]]<=676) {
        score=score+150;
        nomalNote[b][judge[b]]=-100;
        judge[b]++;
        notesound[1].play();
        notesound[1].rewind();
        combo++;
        Perfect++;
        judgeText=0;
        effectSize[a]=60;
        effectNomber[a]=0;
      }
      keyability[a]=0;
    }
  }
}

void judgeLongNote(int c, int d) {
  if (keyability[d]==1) {
    if (longNoteStart[c][longJudgeStart[c]]>=558) {
      if (longNoteStart[c][longJudgeStart[c]]<604||(longNoteStart[c][longJudgeStart[c]]>676 && longNoteStart[c][longJudgeStart[c]]<=724)) {
        score=score+50;
        longNoteStart[c][longJudgeStart[c]]=-100;
        combo++;
        lineMode[c]=2;
        hold[c]=1;
        longJudgeStart[c]++;
      } else if (longNoteStart[c][longJudgeStart[c]]>=604 && longNoteStart[c][longJudgeStart[c]]<=676) {
        score=score+50;
        longNoteStart[c][longJudgeStart[c]]=-100;
        combo++;
        lineMode[c]=3;
        hold[c]=1;
        longJudgeStart[c]++;
      }
      keyability[d]=0;
    }
  }
  if (hold[c]==1) {
    if (keyability[d]==2) {
      longJudgeStop[c]++;
      lineMode[c]=1;
      hold[c]=0;
      longNoteStop[c][longJudgeStop[c]]=-100;
      Middle++;
      judgeText=2;
      effectNomber[c*6]=2;
      effectSize[c*6]=60;
    }
  }
}


void Result() {
  background(Color, score*100/scoreMax, score*100/scoreMax);
  image(resultStage, 500, 400);
  fill(0);
  text(Perfect, 450, 110);
  text(Great, 450, 230);
  text(Middle, 450, 350);
  text(Miss,450,470);
  text(score*100/scoreMax, 400, 750);
}
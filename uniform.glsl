#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

void main() {
  vec2 st = gl_FragCoord.xy / u_resolution.xy;
  st.x *= u_resolution.x / u_resolution.y;

  vec3 color = vec3(0.);
  color = vec3(st.x, st.y, abs(sin(u_time)));

  gl_FragColor = vec4(color, 1.0);
}

/*
  uniform 변수란 무엇인가?


  CPU에서 GPU로 정보를 넘겨줄 때 사용하는 변수
  다음은 두 번째 커밋의 예제에서 사용된 각 uniform 변수에 대한 설명이다.


  1. u_resolution

  얘는 뭐냐면, 이제 editor.thebookofshaders.com 에서 셰이더의 결과를 출력하는 화면은
  마우스로 가로, 세로 해상도 비율을 조정할 수 있도록 되어있음.
  즉, 바뀌어진 화면의 해상도값을 CPU에서 계산한 뒤 GLSL(GPU)로 넘겨줄 때 사용하는 변수임. 
  
  이렇게 넘겨주는 변수이기 때문에 앞에 uniform이 붙는 것이고,
  화면의 해상도는 가로길이, 세로길이 2개의 변수가 필요하기 때문에 데이터 타입을 vec2로 지정한 것.
  
  그리고 이름이 좀 특이한데, 
  해상도를 넣는 변수면 그냥 resolution이라고 하면 될 것을 앞에 u_ 가 붙어있음.
  그러면, 해상도를 넣는 uniform 변수는 이름을 다 저렇게 지정해야 하는가?
  그건 절대 아님. thebookofshaders의 저자가 임의로 지은 변수명이고,
  셰이더토이 에디터에서는 동일한 변수를 iResolution 이라는 이름을 사용하고 있음

  원래대로라면, 다른 이름으로 마음대로 바꿀 수 있음.
  그런데, 이 editor.thebookofshaders.com 웹사이트에서
  저 화면의 해상도 값을 가져오는 변수를 만들려면,
  그냥 이름을 u_resolution으로 지어놔야 알아서 저 uniform 변수에 
  해상도 값이 전송되는 것 같음. -> 이 익스텐션 상에서는 정해진 이름의 변수라는 것이지.

  지금 glsl-canvas 익스텐션이 thebookofshaders 저자가 만든
  glslEditor 에서 사용중인 glslCanvas javascript 라이브러리를
  vscode 에서도 사용할 수 있도록 만든 것이기 때문에,
  여기서 작업을 할 때에도 결과를 출력하는 캔버스 화면의 해상도를 가져오려면
  저 변수를 넣어줘야 하는 게 맞음.

  
  참고) 그러나, WebGL 책에서 공부했듯이,
  원래는 uniform 변수에 어떤 값을 전달해주려면
  자바스크립트 코드에서 WebGL API를 사용해줘야 함.


  2. u_mouse

  이름으로 어느 정도 유추하겠지만,
  화면상에서 나의 마우스가 위치하고 있는 좌표값을 CPU가 계산을 해준 뒤,
  GLSL로 넘겨주는 값이라고 보면 됨.

  -> 나의 마우스 위치의 x, y 좌표가 각각 필요하기 때문에
  데이터 타입을 vec2로 지정함.


  3. u_time
  이 어플리케이션(즉, 이 예제 파일)이 경과되어가는 시간을 나타내주는 변수.
  시간을 나타내므로 float 타입으로 지정해야 함.

  마찬가지로, CPU가 GPU로 넘겨주기 때문에 uniform 변수로 만들어 놓은 것.


  그런데, 왜 GLSL에는 이런 값들을 넘겨줘야 하는걸까?
  GLSL 혼자서 이 값들을 계산할 수는 없나?

  GLSL(GPU)은 이런 CPU(WebGL 에서는 js)의 복잡한 계산을 직접 할 수 있는 능력이 좀 부족하기 때문에
  그래픽 연산을 제외한 나머지 연산을 CPU가 처리를 해주고,
  그 결과값을 GLSL에 전송해줌으로써, GLSL이 소기의 목적을 달성하도록 도와줘야 함.
*/
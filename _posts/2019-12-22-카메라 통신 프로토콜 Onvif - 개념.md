## GIS 와 Openlayers3 (4/4) - 응용

작성 2019년 7월 19일 김경호

#### 1. 지역을 이동하며 글자 찍기

앞의 차시에서 알아본 Feature 삽입와 맵 이동을 활용하여
서울 대전 대구 부산으로 중심점을 이동하며 글자를 찍어 봅니다.

이 예제에서 사용된 맵 API는 부드러운 화면 이동 및 bounce 이동 효과, Feature를 글자 형태로 표현 입니다.

우선 서울 대전 대구 부산을 순서대로 이동할 수 있도록 지도 위에 버튼을 2개 둬 봅니다.

HTML 구역
````
<!DOCTYPE html>
<html>
<head>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/ol3/3.17.1/ol.css" type="text/css">
  <script src="https://cdnjs.cloudflare.com/ajax/libs/ol3/3.17.1/ol.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/proj4js/2.2.2/proj4.js"></script>
</head>
<body>
  <div id="map" style="width:100%;height:100%;"></div>
  <div style="position:absolute;top:5%;right:24px;">
    <input type="button" value="prev" style="display:inline;position:relative;z-index:1;" onclick="click_button('prev')"/>
    <input type="button" value="next" style="display:inline;position:relative;z-index:1;" onclick="click_button('next')"/>
  </div>
</body>
</html>
````

위의 코드는 지도 영역을 표현할 map div와 이전 다음으로 지역을 이동할 수 있게 해주는 버튼 prev, next를 생성 합니다.
prev, next 버튼을 눌렀을 경우 click_button 함수를 호출하여 지도 이동효과를 내줍니다.

코드를 표현하면

<br><img src="https://github.com/macontents/macontents.github.io/blob/master/images/2019-07-19-GIS-1-1.JPG?raw=true" width="500" height="300"><br>

이와 같이 지도 영역 오른쪽 상단 위에 버튼이 있는 형태가 됩니다.

그 다음 입맛에 맞게 수치지도 또는 항공사진 지도를 map으로 생성 합니다.
지도 종류는 vWorld의 TMS 주소를 변경하여 이용하도록 합니다.

JSP 구역
````
proj4.defs( "EPSG:5186", "+proj=tmerc +lat_0=38 +lon_0=127 +k=1 +x_0=200000 +y_0=600000 +ellps=GRS80 +units=m +no_defs" ); // 5186 좌표선언

var baseLayer= new ol.layer.Tile({ // TMS 레이어
  source: new ol.source.OSM({
    url: "http://xdworld.vworld.kr:8080/2d/Base/service/{z}/{x}/{y}.png"
  }) 
});

var map = new ol.Map({
  layers: [ baseLayer ], // 지도 레이어
  target: "map", // 맵 표현 DIV 명
  loadTilesWhileInteracting: true,
  loadTilesWhileAnimating: true,
  view: new ol.View({ // 맵 뷰
    projection : new ol.proj.Projection({
      code : "EPSG:5186", // 지도 좌표계
      units : "m",
      axisOrientation : "enu"
    }),
    center: ol.proj.fromLonLat( [ 126.992273, 37.552411 ], "EPSG:5186" ), // 맵 센터 위경도
    minZoom : 7, // 맵 최소 줌 레벨
    maxZoom : 20, // 맵 최대 줌 레벨
    zoom: 10 // 맵 초기 줌 레벨
  })
});
````

위의 코드는 좌표계를 설정하며 TMS로 지도를 띄우고 서울 한가운데를 중심점으로 10의 줌 레벨을 갖도록 하는
지도를 생성한 코드 입니다.

맵을 생성 하였으면 이제 지도에서 이용할 위경도 포인트 값과 포인트에 대한 제목 값을 만듭니다.

JSP 구역
````
var point = new Array( );
point.push( ol.proj.fromLonLat( [ 126.992273, 37.552411 ], "EPSG:5186" ) ); // 서울
point.push( ol.proj.fromLonLat( [ 127.394230, 36.338648 ], "EPSG:5186" ) ); // 대전
point.push( ol.proj.fromLonLat( [ 128.565244, 35.831737 ], "EPSG:5186" ) ); // 대구
point.push( ol.proj.fromLonLat( [ 129.047757, 35.160945 ], "EPSG:5186" ) ); // 부산

var point_name = new Array( );
point_name.push( "서울" );
point_name.push( "대전" );
point_name.push( "대구" );
point_name.push( "부산" );
````

point 라는 변수에 서울 대전 대구 부산의 가운데 지점 위경도를 넣습니다.
point 위경도 변수는 지도를 이동할때의 중심점으로 쓰이게 됩니다.
point_name 변수는 각각의 지역 포인트에 대한 한글 지명 입니다.
point_name 은 화면이 이동 되었을 때 지도에 표시할 Feature 의 text 값으로 사용 합니다.

그 다음으로 공통적으로 사용할 레이어 변수와 사용할 point 배열의 번호 값을 제어할 수 있는 변수를 만들고
click_button 함수를 생성합니다. 함수 안에선 레이어 변수와 point 배열 번호 값을 유효한 값으로 제어해 줍니다.

JSP 구역
````
var name_layer;
var focus = 0;
function click_button( opt ) {
  // 버튼 확인
  if( opt == "prev" ) {
    focus = ( focus - 1 );
    if( focus < 0 ) {
      focus = point.length - 1;
    }
  }
  else {
    focus = ( focus + 1 );
    if( focus > point.length - 1 ) {
      focus = 0;
    }
  }
  
  // 기존 Feature 삭제
  if( name_layer != undefined ) {
    map.removeLayer( name_layer );
  }
````

레이어를 저장할 변수 name_layer와 배열의 번호를 담아둘 focus를 초기 값 0으로 놓습니다. 위의 위경도 배열 변수인 point 를 토대로 하면
초기값은 서울이 됩니다.
click_button 함수 안에선 함수의 옵션 파라미터의 값에 따라 focus가 늘어날지 줄어들지를 제어문을 통해 제어해 준 후 유효한 값이
아닐 경우를 체크하여 제어해 줍니다.
그리고 Feature Text 가 담기게될 name_layer는 이전 값이 없는 undefined 가 아니면 맵에서 삭제하도록 해줍니다.

그 뒤 focus 값에 따라 point 를 찍을 수 있도록 Feature를 생성해 봅니다.

JSP 구역
````
// 새 Feature 추가
var iconFeature = new ol.Feature({
  geometry : new ol.geom.Point( point[ focus ] )
});

var iconStyle = new ol.style.Style({
  text : new ol.style.Text({
    text : point_name[ focus ],
    scale : 2,
    stroke : new ol.style.Stroke({
      color : "#000000",
      width : 2
    }),
    fill : new ol.style.Fill({
      color: "rgba(255, 255, 255, 1)"
    })
  })
});
iconFeature.setStyle( iconStyle );

var vectorSource = new ol.source.Vector({
  features : [iconFeature]
});

var vectorLayer = new ol.layer.Vector({
  source : vectorSource
});

map.addLayer( vectorLayer );
map.renderSync( );
````

point 배열에 focus 값을 넣어 원하는 point 위경도 값을 iconFeature로 만듭니다.
그런뒤 Style을 적용할때 ol.style.Text를 이용하여 텍스트 글자 형태의 Feature를 생성 합니다. 여기서 글자 내용은
point_name 배열 변수를 이용 합니다.

iconFeature에 스타일을 적용한 뒤 Source 생성 및 Layer를 생성 합니다.
최종적으로 Layer를 맵에 추가한뒤 map의 renderSync 함수를 사용하여 map을 새로고침 해줍니다.
해주지 않으면 화면을 움직여줘야 서울 대전 대구 부산 글자가 찍히게 됩니다.

다음은 맵 이동 효과를 줘봅니다.

JSP 구역
````
// 맵 이동 pan=부드럽게 이동 bounce=튕기는 효과
var pan = new ol.animation.pan({
  duration : 2000,
  source : map.getView( ).getCenter( )
});

var bounce = new ol.animation.bounce({
  duration : 3000,
  resolution : map.getView( ).getResolution( )
});

map.beforeRender( pan, bounce );
map.getView( ).setCenter( point[ focus ] );
map.getView( ).setZoom( 10 );
````

ol.animation.pan 생성자를 이용하여 맵에 이동효과를 줍니다. duration은 몇 ms 동안 맵을 부드럽게 움직일것이냐를 설정 합니다.
그리고 bounce는 줌 레벨이 한번 튕기는 효과가 들어가게 되는데 이것도 마찬가지로 몇 ms 동안 애니메이션 동작을 줄 것이냐를 설정할 수 있습니다.
맵 이동과 움직임 효과를 만든 후 map.beforeRender 함수를 이용하면 맵에 이동 효과를 입력할 수 있고
setCenter 와 setZoom을 이용하여 맵을 이동시켜 봅니다.

최종적으로 모든 소스를 종합하면

JSP 구역
````
proj4.defs( "EPSG:5186", "+proj=tmerc +lat_0=38 +lon_0=127 +k=1 +x_0=200000 +y_0=600000 +ellps=GRS80 +units=m +no_defs" ); // 5186 좌표선언

var baseLayer= new ol.layer.Tile({ // TMS 레이어
  source: new ol.source.OSM({
    url: "http://xdworld.vworld.kr:8080/2d/Base/service/{z}/{x}/{y}.png"
  }) 
});

var map = new ol.Map({
  layers: [ baseLayer ], // 지도 레이어
  target: "map", // 맵 표현 DIV 명
  loadTilesWhileInteracting: true,
  loadTilesWhileAnimating: true,
  view: new ol.View({ // 맵 뷰
    projection : new ol.proj.Projection({
      code : "EPSG:5186", // 지도 좌표계
      units : "m",
      axisOrientation : "enu"
    }),
    center: ol.proj.fromLonLat( [ 126.992273, 37.552411 ], "EPSG:5186" ), // 맵 센터 위경도
    minZoom : 7, // 맵 최소 줌 레벨
    maxZoom : 20, // 맵 최대 줌 레벨
    zoom: 10 // 맵 초기 줌 레벨
  })
});

var point = new Array( );
point.push( ol.proj.fromLonLat( [ 126.992273, 37.552411 ], "EPSG:5186" ) ); // 서울
point.push( ol.proj.fromLonLat( [ 127.394230, 36.338648 ], "EPSG:5186" ) ); // 대전
point.push( ol.proj.fromLonLat( [ 128.565244, 35.831737 ], "EPSG:5186" ) ); // 대구
point.push( ol.proj.fromLonLat( [ 129.047757, 35.160945 ], "EPSG:5186" ) ); // 부산

var point_name = new Array( );
point_name.push( "서울" );
point_name.push( "대전" );
point_name.push( "대구" );
point_name.push( "부산" );

var name_layer;
var focus = 0;
function click_button( opt ) {
  // 버튼 확인
  if( opt == "prev" ) {
    focus = ( focus - 1 );
    if( focus < 0 ) {
      focus = point.length - 1;
    }
  }
  else {
    focus = ( focus + 1 );
    if( focus > point.length - 1 ) {
      focus = 0;
    }
  }
  
  // 기존 Feature 삭제
  if( name_layer != undefined ) {
    map.removeLayer( name_layer );
  }
  
  // 새 Feature 추가
  var iconFeature = new ol.Feature({
    geometry : new ol.geom.Point( point[ focus ] )
  });

  var iconStyle = new ol.style.Style({
    text : new ol.style.Text({
      text : point_name[ focus ],
      scale : 2,
      stroke : new ol.style.Stroke({
        color : "#000000",
        width : 2
      }),
      fill : new ol.style.Fill({
        color: "rgba(255, 255, 255, 1)"
      })
    })
  });
  iconFeature.setStyle( iconStyle );

  var vectorSource = new ol.source.Vector({
    features : [iconFeature]
    });

  var vectorLayer = new ol.layer.Vector({
    source : vectorSource
  });

  map.addLayer( vectorLayer );
  map.renderSync( );

  // 맵 이동 pan=부드럽게 이동 bounce=튕기는 효과
  var pan = new ol.animation.pan({
    duration : 2000,
    source : map.getView( ).getCenter( )
  });

  var bounce = new ol.animation.bounce({
    duration : 3000,
    resolution : map.getView( ).getResolution( )
  });

  map.beforeRender( pan, bounce );
  map.getView( ).setCenter( point[ focus ] );
  map.getView( ).setZoom( 10 );
}
````
이런 형태가 되며 실행을 한 뒤 next를 눌러 봅니다.

<br><img src="https://github.com/macontents/macontents.github.io/blob/master/images/2019-07-19-GIS-1-2.JPG?raw=true" width="500" height="300"><br>

이렇게 대전 대구 부산 다시 서울 차례로 맵이 이동되며 글자가 새겨진다면 성공 입니다.
응용으로 소개시켜드린 기술 자체도 사실상 간단한 컨트롤에 불과 합니다. Openlayers3의 API를 잘 찾아보시면
클릭했을 때의 이벤트나 위치추적 등 여러가지 기능을 이용하실 수 있으니
관심 있으신 분들은 알려드린 기본 틀 안에서 만들고 싶으신 것을 만들어 보는것도 좋을 것 같습니다.

<br><br>
![로고](https://macontents.github.io/images/markany.png)

<div class="fb-comments" data-href="https://macontents.github.io/2019-05-28-Docker 용 - 설치.md" data-width="700" data-numposts="10"></div>

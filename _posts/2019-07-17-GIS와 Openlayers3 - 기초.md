GIS 와 Openlayers3 (2/4) - 기초
=======================

#### 1. Openlayers3 API

Openlayers3 라이브러리를 활용할 수 있는 API를 https://geoadmin.github.io/ol3/apidoc/ 주소에서
확인해 봅니다. 해당 API에서 객체들의 옵션 값과 메소드를 확인하여 본인이 원하는 기능을 구현할 수 있습니다.

<img src="https://github.com/macontents/macontents.github.io/blob/master/images/2019-07-17-GIS-1-1.JPG?raw=true" width="500" height="300"><br>

처음엔 예제위주로 보시겠지만 시간이 지날수록 기능 구현을 위해 API를 보시게 됩니다.
GIS를 본격적으로 해보실 분은 이 사이트를 즐겨찾기를 등록 하시면 됩니다. ˘◡˘ 

#### 2. Openlayers3 라이브러리 호출

앞서 말씀드린 예제 실습 사이트 https://liveweave.com/ 에서 Openlayers3 라이브러리를 호출 합니다.
호출시 Openlayers3의 라이브러리 주소는 https://cdnjs.cloudflare.com/ajax/libs/ol3/3.17.1/ol.js 입니다.
사용시 필요한 css와 proj4 좌표체계 변환 라이브러리도 함께 호출 합니다.

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

</body>
</html>
````

#### 3. 맵 표현 준비
Openlayers3 에서 맵을 표현하려면 맵을 표현할 HTML의 DIV가 필요 합니다.
맵이 될 DIV의 속성을 미리 지정(크기 및 위치)하여 DIV를 생성해 봅니다.

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
</body>
</html>
````

사용할 DIV의 id를 map으로 지정 하였으며 넓이 및 길이를 화면의 100%를 사용하게끔 생성 하였습니다.
그리고 Openlayers3 라이브러리를 사용하기 위해 head 구역에서 ol.css, ol.js를 호출 합니다. 그리고 EPSG(좌표변환)을 위해 proj4.js도 같이 호출 합니다.


#### 4. 직접 맵 표현하기
지도를 표현하는데에 있어 지도 데이터를 가져올 레이어 주소 및 위치 정보 값은 필수 입니다.
이번 실습에서 지도 데이터는 vWorld의 TMS 주소를 따다 사용하며 지도 초기 센터 값은
구글 지도에서 위경도를 확인하여 사용 하겠습니다.

우선 vWorld에서 지도 데이터 주소를 확인 합니다.
<img src="https://github.com/macontents/macontents.github.io/blob/master/images/2019-07-17-GIS-4-1.JPG?raw=true" width="500" height="300"><br>
[F12] 키를 눌러 개발자도구의 Network 탭을 보면 지도 이미지의 주소를 확인할 수 있습니다.
해당 스크린샷에서의 2D지도 주소는 http://wdworld.vworld.kr:8080/2d/Base/service/9/439/199.png 형식으로 되어 있는 것을 확인할 수 있습니다.
그러면 우리가 사용해야할 주소는 http://wdworld.vworld.co.kr:8080/2d/Base/service 가 되며 뒤의 Z X Y 위치 값은 맵 생성시 유동적으로 사용하게끔 합니다.

다음은 지도의 센터값을 설정할 위경도 값을 구글 지도에서 확인 합니다.
<img src="https://github.com/macontents/macontents.github.io/blob/master/images/2019-07-17-GIS-4-2.JPG?raw=true" width="500" height="300"><br>
센터로 잡을 위치에 마우스 커서를 갖다댄 후 오른쪽 버튼-이곳이 궁금한가요? 를 클릭하면 화면 아래에 주소와 위경도 값이 표시 됩니다.
해당 위경도 값을 복사하여 맵의 센터 값으로 사용 합니다.

위처럼 지도 및 위치 값 확인이 끝나면 맵을 표현해 봅니다.

JSP 구역
````
proj4.defs( "EPSG:5186", "+proj=tmerc +lat_0=38 +lon_0=127 +k=1 +x_0=200000 +y_0=600000 +ellps=GRS80 +units=m +no_defs" ); // 5186 좌표선언

var baseLayer= new ol.layer.Tile({ // TMS 레이어
  source: new ol.source.OSM({
    url: "http://xdworld.vworld.kr:8080/2d/Base/service/{z}/{x}/{y}.png"
  }) 
});

var map = new ol.Map({
  layers: [baseLayer], // 지도 레이어
  target: "map", // 맵 표현 DIV 명
  view: new ol.View({ // 맵 뷰
    projection : new ol.proj.Projection({
      code : "EPSG:5186", // 지도 좌표계
      units : "m",
      axisOrientation : "enu"
    }),
    center: ol.proj.fromLonLat([127.000042, 37.558324], "EPSG:5186"), // 맵 센터 위경도
    minZoom : 7, // 맵 최소 줌 레벨
    maxZoom : 20, // 맵 최대 줌 레벨
    zoom: 10 // 맵 초기 줌 레벨
  })
});
````

vWorld의 좌표 체계는 EPSG:5186 입니다. 그렇기 때문에 proj4를 통해 내가 표현할 위경도 값을 EPSG:5186 값에 맞춰 변환할 수 있도록 준비합니다.
그 다음 baseLayer 변수에 TMS 생성자를 통해 vWorld의 TMS 주소 값을 url로 입력 시킵니다. {z} {x} {y} 값은 사용자가 지도를 이동할때마다
좌표가 변환이 되므로 {z} {x} {y} 전의 주소만 vWorld의 주소로 맞춰 주시면 됩니다.
var map에 해당되는 맵 생성하는 함수인 ol.Map의 옵션 값을 설명드리면.
- layers : map 변수에 ol.Map 함수를 이용하여 맵을 생성하며 생성자 옵션 중 layers는 맵에 표현되는 지도에 해당되며 해당 옵션에
vWorld TMS를 생성한 baseLayer 변수를 대입 시킵니다.
- target : target 옵션은 앞서 지도가 될 DIV의 id를 입력합니다.
- view : view 에선 맵에서 표현될 EPSG 좌표체계와 지도의 센터 값, 최소 줌 레벨, 최대 줌 레벨, 초기 줌 레벨을 설정 합니다.

위의 코드가 올바르게 실행 되었을 경우
<img src="https://github.com/macontents/macontents.github.io/blob/master/images/2019-07-17-GIS-4-3.JPG?raw=true" width="500" height="300"><br>
이렇게 결과창에 서울이 중심인 지도 객체가 생성이 됩니다.
현재는 TMS를 예제로 하였지만 WMS 주소를 안다면 WMS 객체를 맵의 layers 옵션으로 하여 사용할 수도 있습니다.
WMS 생성자 및 옵션에 대해선 Openlayers3 API 문서를 참조해주시기 바랍니다.

다음에는 해당 지도에 이미지 객체를 올려보도록 하겠습니다.

<br><br>
![로고](https://macontents.github.io/images/markany.png)

<div class="fb-comments" data-href="https://macontents.github.io/2019-05-28-Docker 용 - 설치.md" data-width="700" data-numposts="10"></div>

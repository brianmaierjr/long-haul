## GIS 와 Openlayers3 (3/4) - 심화

작성 2019년 7월 18일 김경호

#### 1. 마커 이미지 올리기

앞에서 웹 페이지로 띄운 지도 위에 마커 이미지를 올려 보도록 합니다.
우선 마커 이미지를 어느 위치에 올릴 것인지 구글 지도에서 위치를 확인 후
위경도값을 준비 합니다.

JSP 구역
````
var point = new Array( );
point.push( ol.proj.fromLonLat( [ 126.998486, 37.558622 ], "EPSG:5186" ) );
point.push( ol.proj.fromLonLat( [ 127.002368, 37.560100 ], "EPSG:5186" ) );
point.push( ol.proj.fromLonLat( [ 127.001588, 37.555734 ], "EPSG:5186" ) );
````

위의 경우 3개의 위경도 포인트 값을 준비 하고
ol.proj.fromLonLat 함수를 통해 위경도 포인트 값을 vWorld 좌표체계인 EPSG:5186에 맞춰 변환하여
point 변수에 위경도 객체로 담아 놓습니다.

JSP 구역
````
var iconFeature = new ol.Feature({
  geometry : new ol.geom.Point( point[i] )
});
````
ol.Feature 함수를 이용하여 위치 값을 가지는 하나의 객체인 Feature를 생성 합니다. 여기서 아까전에 위경도 객체를 담아둔
point 변수를 이용해 줍니다. 해당 Feature의 이름 또는 설명을 추가하고 싶을땐 ol.Feature 객체의 옵션을 참고해 주세요.

JSP 구역
````
var iconStyle = new ol.style.Style({
  image : new ol.style.Icon(({
    scale : 0.1,
    anchorXUnits : "pixels",
    anchorYUnits : "pixels",
    src : "https://www.boannews.com/media/upFiles2/2018/05/653070034_2508.jpg"
  }))
});
iconFeature.setStyle( iconStyle );
````

위에서 생성한 Feature에 대한 스타일을 ol.style.Style을 이용하여 정의 합니다.
지금은 image 옵션만 정의하였지만 Text도 정의할 수 있습니다. 일단 마커로 사용할 이미지의 경로와 크기만을
설정 하였습니다.
스타일 객체를 선언 후 앞서 생성한 Feature 객체의 setStyle 함수를 이용해 적용 합니다.

JSP 구역
````
var vectorSource = new ol.source.Vector({
  features : [iconFeature]
});
````
Feature 객체에 대한 모든 설정이 끝났다면 맵 위에 올리기 위해 ol.source.Vector 객체를 생성 후
해당 Feature를 적용해 줍니다.

JSP 구역
````
var vectorLayer = new ol.layer.Vector({
  source : vectorSource
});
map.addLayer( vectorLayer );
````
마지막으로 Feature를 하나의 레이어 객체로 만들어 올리기 위해 앞서 만든 ol.source.Vector 객체를 ol.layer.Vector 객체로
생성 후 map 객체의 addLayer 함수를 이용하여 지도에 Feature 레이어를 추가 합니다.

전체적인 소스 코드로는
JSP 구역
```
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
    zoom: 15 // 맵 초기 줌 레벨
  })
});

var point = new Array( );
point.push( ol.proj.fromLonLat( [ 126.998486, 37.558622 ], "EPSG:5186" ) );
point.push( ol.proj.fromLonLat( [ 127.002368, 37.560100 ], "EPSG:5186" ) );
point.push( ol.proj.fromLonLat( [ 127.001588, 37.555734 ], "EPSG:5186" ) );

for( var i=0; i<3; i++ ) {
  var iconFeature = new ol.Feature({
    geometry : new ol.geom.Point( point[i] )
  });

  var iconStyle = new ol.style.Style({
    image : new ol.style.Icon(({
      scale : 0.1,
      anchorXUnits : "pixels",
      anchorYUnits : "pixels",
      src : "https://www.boannews.com/media/upFiles2/2018/05/653070034_2508.jpg"
    }))
  });
  iconFeature.setStyle( iconStyle );

  var vectorSource = new ol.source.Vector({
    features : [iconFeature]
    });

  var vectorLayer = new ol.layer.Vector({
    source : vectorSource
  });

  map.addLayer( vectorLayer );
}
```

이며 결과 화면으로는

<img src="https://github.com/macontents/macontents.github.io/blob/master/images/2019-07-18-GIS-1-1.JPG?raw=true" width="500" height="300"><br>

이렇게 지도위에 마크애니 이미지 3개를 올릴 수 있습니다.

정리하자면
1. 위경도 값을 가진 Feature 객체를 생성.
2. Feature 객체에 이미지를 가진 Style 객체를 적용.
3. Source Vector 객체로 Feature를 감싸서 생성.
4. Vector Layer 객체로 Source Vector를 감싸서 생성 후 맵에 레이어를 추가.

입니다.

지금은 단순히 이미지만 추가하였지만 API 문서를 보시고 응용하시면 클릭 이벤트 및 설명 추가, 텍스트 표시 등이 가능하게 됩니다.

#### 2. 간단한 지도 이동

처음에 생성한 ol.Map의 View 객체를 통하여 현재 보고있는 지도의 줌 레벨과 위치를 이동시킬 수 있습니다.

우선 지도 이동에 관련된 객체인 View  객체를 map 변수에서 뽑아냅니다.

JSP 구역
```
var mapView = map.getView( );
```
그 후 지도의 센터를 지정한 위경도로 맞추고 싶다 할땐 setCenter 함수를
지정한 줌 레벨로 변경하고 싶다 할땐 setZoom 함수를 이용합니다.

JSP 구역
```
var olLonLat = ol.proj.fromLonLat( [ 126.998486, 37.558622 ], "EPSG:5186" );
var mapView = map.getView( );
mapView.setCenter( olLonLat );
mapView.setZoom( 18 );
```
위의 소스를 설명 드리면 자신이 원하는 위경도 값으로 위경도 객체인 olLonLat을 생성한 뒤
map 객체에서 View 객체를 뽑아 냅니다.
그리고 mapView의 setCenter( olLonLat ) 으로 지도의 중심점을 변경한 뒤
setZoom( 18 ) 로 지도의 줌 레벨을 18단계로 당긴다는 내용 입니다.

결과로는
소스 적용 전
<br><img src="https://github.com/macontents/macontents.github.io/blob/master/images/2019-07-18-GIS-2-1.JPG?raw=true" width="500" height="300"><br>

소스 적용 후
<br><img src="https://github.com/macontents/macontents.github.io/blob/master/images/2019-07-18-GIS-2-2.JPG?raw=true" width="500" height="300"><br>

위와같이 지도를 보는 시점이 변경되게 됩니다.

다음엔 이러한 지도 컨트롤 기능을 응용해 보도록 하겠습니다.


<br><br>
![로고](https://macontents.github.io/images/markany.png)

<div class="fb-comments" data-href="https://macontents.github.io/2019-05-28-Docker 용 - 설치.md" data-width="700" data-numposts="10"></div>

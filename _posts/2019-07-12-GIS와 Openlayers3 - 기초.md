GIS 와 Openlayers3 (1/4) - 개념
=======================

#### 1. GIS 란

GIS( Geographic Information System )는 한글로 풀면 지리 정보 시스템 입니다.
더 쉽게 얘기하자면 지도를 통해 지리적 정보를 획득 또는 지도 이미지 위에 표현한다. 라고 보시면 됩니다.
이런 GIS를 표현함에 있어 오픈 소스로 개발된 Openlayers.js 를 이용하여 우리가 원하는 위치에
원하는 표현을 하는 방법을 배워 봅니다.

#### 2. Openlayers 란
Openlayers 란 웹 브라우저에서 지도를 표현하고 데이터를 표현할 수 있는
자바스크립트 라이브러리 입니다.
간단히 설명 드리자면 맵 엔진과 jsp 파일을 통해 맵 데이터를 웹 브라우저에 표현해 주는
역할을 합니다.

#### 3. 지도 표현 방법의 종류
지도 표현 방법은 여러가지가 있지만 대표적으로
WMS 방식과 TMS 방식을 설명 드리겠습니다.
 - WMS( Web Map Service )
 우선 WMS는 맵 데이터를 제공해주는 서비스라고 보시면 됩니다. 그러려면 맵 엔진이 필수 입니다.
 각 회사마다 개발한 맵 엔진이 있을수도 있고 GeoServer 같은 프로그램을 설치하여 맵 엔진 역할을 할 수 있습니다.
 맵 엔진으로 WMS를 구축하면 맵 서비스 요청에 대해 필요한 만큼 맵 데이터를 가공하여 응답해 주는 역할을 합니다.
 보안적으로 요청에 대해 검사 후 응답해 주는 방식이라 안전하지만 TMS에 비해 상대적으로 맵 서비스 속도가 떨어집니다.
 - TMS( Tile Map Service )
 TMS는 타일 맵 서비스 입니다. 이미 구역별로 XYZ 축으로 나눠진 지도 이미지를 가지고 그대로 서비스 해줍니다.
 속도는 굉장히 빠르지만 이 서비스를 사용할 수 있는 사람은 XYZ 를 계산하여 직접 다운로드가 가능 합니다.

조금 정리하면 다음과 같습니다.
서비스| 맵 엔진 | OGC 표준 | 속도
---|---|---|---
WMS| 필요|표준|맵 엔진 성능에 따라 다르지만 TMS보다 느림
TMS| 불필요|비표준(애매)|이미지 다운로드 속도에 따라 빠름

여기서 설명안드린 OGC는 Open Geospatial Consortium 이며 여기서 표준으로 인정해주는 서비스여야
정식적인 맵 서비스 제품의 인증이 가능 합니다. WMS는 OGC에서 인정하는 표준 서비스라고 명확하게 나와있지만 TMS는 나와 있지 않은데
그렇다고 TMS를 아예 비표준이라고 보기 어렵다고 합니다.
왜냐하면 Openlayers 라이브러리는 OGC 표준을 준수하며 WMS, TMS로 맵 서비스가 가능한데
TMS만이 표준이 아니다라고 하기엔 애매하다는 GIS 전문가의 조언을 받은 적이 있습니다.
실제로 TMS 맵 서비스로 제품 인증을 받았었습니다. 아마 이 사항은 나중에 문제가될 소지가 있기 때문에
좀 더 조심해야할 것 같습니다.

#### 4. 맵을 사용하기전에 알아둘 것
앞서 얘기 드렸다시피 WMS 또는 TMS를 이용하여 지도를 표현하려면 맵 엔진을 이용해야 하는데
WMS 같은 경우 GeoServer 프로그램을 이용하여 맵 엔진을 띄우고 서비스가 될 맵을 편집해야 합니다.
맵을 편집하려면 국토지리정보원에서 해당 지역 정보 데이터(SHP)를 받은 뒤 QGIS와 같은 SHP 편집 프로그램으로
데이터를 가공 후 여러개의 SHP 파일을 포토샵의 레이어 겹치듯 겹쳐 만들어 놔야 합니다.
제작시 상당한 피로도와 스트레스를 유발하므로 WMS는 남이 만들어놓은 엔진을 통해 이용하도록 합시다.

반대로 사용은 매우 쉽지만 지도 이미지를 미리 가지고 있어야하는 TMS를 이용해 보는 방법이 좋을 것 같습니다.
TMS도 마찬가지로 미리 맵을 다운받기에는 상당한 시간과 메모리가 소모 됩니다.
지도 이미지가 용량을 많이 차지하나요? 맞습니다. 거기다 파일 갯수도 세부적으로 너무많아 리눅스같은 FAT32에선
파일 생성갯수가 제한이 있으므로 미처 지도 이미지를 다 받지 못합니다.
그래서 우리는 지도 이미지를 로컬이 아닌 국토지리정보원의 vWorld 지도 이미지를 사용해 봅니다.

<img src="https://github.com/macontents/macontents.github.io/blob/master/images/2019-07-12-GIS-4-1.JPG?raw=true" width="500" height="300"><br>
크롬으로 vWorld 사이트의 지도 이미지를 염탐해 봅니다.
개발자 도구의 Network 탭을 보시면 여러장의 png 지도 이미지를 받은 것을 보실 수 있습니다.
그 중하나의 주소를 자세히 보면 "http://xdworld.vworld.kr:8080/2d/Base/service/8/217/100.png" 를 확인하실 수 있습니다.
이 형식을 보아하니 http://xdworld.vworld.kr:8080/2d/Base/service 주소는 고정이며 {Z}/{X}/{Y}.png 형식으로 가져오는걸 알 수 있을 것 같습니다.
이 중 {Z}는 줌 레벨이며 {X}와 {Y}는 타일의 위치를 의미한다 라는 것도 여러장의 이미지를 보시면 알 수 있습니다.

이러한 형식으로 구성되어 있기 때문에 프로그램을 돌려 해당 이미지를 모두 내 로컬로 다운받게할 수 있으며
맵 이미지를 모아 직접 서비스도 할 수 있습니다.

#### 5. 테스트를 위한 도구
Openlayers를 이용하여 맵을 표현하려면 기본적으로 이클립스로 개발하여 톰캣 서버를 이용해야 jsp 페이지 한장을 확인하실 수 있습니다.
물론 귀찮으므로 https://liveweave.com/ 사이트에서 예제 또는 기능 테스트를 할 수 있도록 합니다.
사이트에 접속하여 화면 구성을 보면
<img src="https://github.com/macontents/macontents.github.io/blob/master/images/2019-07-12-GIS-5-1.JPG?raw=true" width="500" height="300"><br>
HTML 구역
````
<!DOCTYPE html>
<html>
<head>
<title>HTML, CSS and JavaScript demo</title>
</head>
<body>
<!-- Start your code here -->

<p class="lw">Hello We!</p>

<!-- End your code here -->
</body>
</html>
````

CSS 구역
````
.lw { font-size: 60px; }
````

JSP 구역
````
// Write JavaScript here 
````

결과확인 구역
````
Hello We!
````

위와 같이 4구역으로 나뉘어 진것을 보실 수 있습니다.
앞으로 설명드릴때 이 사이트에서 확인하실 수 있을 정도로 설명드리며 진행 하도록 하겠습니다.



<br><br>
![로고](https://macontents.github.io/images/markany.png)

<div class="fb-comments" data-href="https://macontents.github.io/2019-05-28-Docker 용 - 설치.md" data-width="700" data-numposts="10"></div>

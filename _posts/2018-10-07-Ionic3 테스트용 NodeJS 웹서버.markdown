---
layout: post
title:  "Ionic3 (4) 테스트용 NodeJS 웹서버"
date:   2018-10-07
description: Ionic3 Http 클라이언트 테스트를 위한 웹서버 구축
---
#### 1.NodeJS
간단하게 테스트 가능한 웹서버 구현을 위해 NodeJS를 이용한다.
NodeJS에 대한 설명은 [여기] [NodeJS]에서 확인해보자.
Ionic Http 통신만 구현하고 싶다면 마지막 4번의 예제 코드를 복사 후 사용하면 된다.

#### 2. NodeJS 설치 및 실행 방법
Node설치는 비교적 간단하다. [공식 홈페이지] [NodeJS] 를 참고하여 설치한다.
여기서 사용한 코드는 공식 문서의 [예제] [NodeJSEx]를 기반하여 작성하였다.

{% highlight bash %}
node -v
v8.11.1 //설치한 버전이 나오면 설치 성공

touch app.js
//공식 홈페이지의 예제 코드를 app.js에 작성

node app.js // 실행

Server running at http://127.0.0.1:3000/ //해당 로그 출력시 웹서버 구동 성공

{% endhighlight %}

#### 3. 데이터 조회
http://localhost:3000/getItem 으로 요청시 데이터를 반환해주는 코드를 작성해보자.

{% highlight javascript %}
const http = require('http');
var url = require('url');

const hostname = '127.0.0.1';
const port = 3000;

var fakeItems = [{item:'1'}]; //앱으로 보내줄 데이터

const server = http.createServer((req, res) => {
    //응답 설정
    res.statusCode = 200;
    res.setHeader('Content-Type', 'application/json');

    //요청값 파싱
    var q = url.parse(req.url, true).query;
    var path = url.parse(req.url, true).pathname;

    //요청 URL의 path가 getItem이면 서버의 데이터를 응답값으로 보냄
    if('/getItem' == path) {
        res.write(JSON.stringify(fakeItems));
    }

    res.end();
});

server.listen(port, hostname, () => {
    console.log(`Server running at http://${hostname}:${port}/`);
});
{% endhighlight %}

* 브라우저를 열고 http://localhost:3000/getItem 에 접속해보자. fakeItems에 초기값으로 넣은 데이터가 출력되었다면 성공이다.


<figure>
	<img src="{{ '/assets/img/post/20181007_img1.png' | prepend: site.baseurl }}" alt="리스트 "> 
	<figcaption>fakeItems 배열에 있던 값이 반환되었다.</figcaption>
</figure>

#### 4. 데이터 입력
이번엔 데이터를 입력하는 코드를 작성해보자.\\
위에서 작성한 `if(/getItem)` 하단에 `addItem`  if문을 추가한다.

{% highlight javascript %}

const server = http.createServer((req, res) => {
    res.statusCode = 200;
    res.setHeader('Content-Type', 'application/json');

    var q = url.parse(req.url, true).query;
    var path = url.parse(req.url, true).pathname;

    if('/getItem' == path) {
        res.write(JSON.stringify(fakeItems));
    }
    
    //addItem으로 요청시 값을 서버에 저장한다.
    if('/addItem' == path) {
        fakeItems.push(q);
        res.write(JSON.stringify(fakeItems));
    }

    res.end();
});
{% endhighlight %}

* 브라우저를 열고 http://localhost:3000/addItem?item=2 에 접속해보자. 쿼리 스트링으로 전달한 값이 응답값으로 보인다면 성공이다.

<figure>
	<img src="{{ '/assets/img/post/20181007_img2.png' | prepend: site.baseurl }}" alt="리스트 "> 
	<figcaption>요청값이 서버에 저장후 반환되었다.</figcaption>
</figure>

> ###### 이 글에서 작성한 서버는 테스트용으로 참고만 하길 바란다. 다음으로는 Ionic에서 http요청 기능을 추가해보도록하자.

[NodeJS]: https://nodejs.org/ko/
[NodeJSEx]: https://nodejs.org/dist/latest-v8.x/docs/api/synopsis.html 







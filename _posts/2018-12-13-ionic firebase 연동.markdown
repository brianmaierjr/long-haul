---
layout: post
title:  "Ionic3 FCM 연동"
date:   2018-12-13
description: ionic3 환경에서 FCM 연동 및 테스트 방법
---
#### 1. ionic 앱 생성
{% highlight bash %}
ionic firebaseEx start blank
cd firebaseEx
ionic cordova platform add android
{% endhighlight %}

생성 완료 후 프로젝트 최상위 경로의 `config.xml` 파일을 열어 수정 한다.\\
맨 윗줄 `widget` 태그의 `id` 항목은 앱의 패키지 이름이다.\\
마켓의 다른 앱과 중복이 되지 않도록 변경하도록 한다.

#### 2. firebase 프로젝트 생성
[파이어베이스 콘솔] [콘솔주소]에 접속해서 firebase 프로젝트를 생성하여 google-services.json파일을 다운 받는다.
 
다운 받은 파일을 프로젝트 최상위 경로(config.xml 파일과 같은 위치)에 복사한다.

#### 3. firebase 플러그인 설치
[파이어베이스 플러그인] [파베플러그인주소] 참고하여 플러그인을 설치한다.

{% highlight bash %}
ionic cordova plugin add cordova-plugin-firebase
npm install --save @ionic-native/firebase
{% endhighlight %}

#### 4. 빌드 및 동작 확인
{% highlight bash %}
ionic cordova build android
{% endhighlight %}

빌드가 성공하면 일단 문제는 없는것이다.\\
이제 코드를 작성 후 토큰값을 받아보자!

{% highlight javascript %}
this.firebase.getToken()
  .then(token => console.log(`The token is ${token}`)) //이 값을 이용해서 푸시를 받을 수 있다.
  .catch(error => console.error('Error getting token', error));
{% endhighlight %}

이제 파이어베이스 콘솔에서 푸시를 보내면 앱에서 푸시 알림을 확인 할 수 있다.

[콘솔주소]: https://console.firebase.google.com/
[파베플러그인주소]: https://ionicframework.com/docs/native/firebase/
안드로이드의 기초(4)

*****2019.12.23*****
팀 : 콘텐츠보안팀
작성자 : 이상원

주제 : imageView에 image url로 실시간 이미지 가져오기.

#  1. imageView란?
가. 안드로이드 어플리케이션에서 image를 보여줄 수 있는 컴포넌트.

 
#  2. 권한 설정하기
< uses-permission android:name="android.permission.INTERNET" /> 을 추가한다.
실시간으로 외부의 이미지를 가져오기 필요한 인터넷 권한이다.


#  3. 레이아웃 설정
해당 엑티비티 레이아웃에 ImageView 컴포넌트를 추가하여 준다.

< ImageView
            android:id="@+id/backBtn"
            android:layout_width="17dp"
            android:layout_height="30dp"
            android:layout_marginLeft="10dp"
            android:src="@drawable/backbtn"
            android:layout_gravity="center"/>

소스코드 

 	final ImageView imageView = new ImageView(this);

   	new Thread(new Runnable() {
    	public void run() {
        	Bitmap bm = null;
            Bitmap resize = null;
            try {
            	m = getBitmap(thumbnailUrl);
                resize = Bitmap.createScaledBitmap(bm, 300, 400, true);
            } catch (Exception e) {
       } finally {
        	 if (bm != null) {
             	 final Bitmap finalResize = resize;
                 runOnUiThread(new Runnable() {
                 	@SuppressLint("NewApi")
                    public void run() {
                    	imageView.setImageBitmap(finalResize);
                    }
                  });
              }
           }
         }
      }).start();
      
여기서 중요한 점은 기존 구버전에서는 디자인 UI와 인터넷 UI가 동기에 상관없이 사용되었지만 
원할한 앱의 성능을 위해 실시간으로 이미지를 그려주는 경우 별도의 쓰레드를 생성해야 하는 정책을 따라 주어야한다.


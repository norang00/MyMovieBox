## MyMovieBox
내가 좋아하는 영화를 관리할 수 있는 [마이무비박스] 입니다.
##### 기간: 2025.01.24~02.01(9일) | 인원: 1인

### App 기능
#### 메인 화면  
<table>
  <tr>
    <td width="200">
      <img src="https://github.com/user-attachments/assets/a4b1fa8e-2769-4360-8977-ee1a07d3e76d" width="100%">
    </td>
    <td width="600">
      <br>- 프로필 카드에서 나의 닉네임과 가입날짜, 내가 좋아요를 누른 영화의 개수를 확인할 수 있습니다.  
      <br>- 최근 검색어를 확인할 수 있고, 버튼을 이용하여 같은 결과 리스트를 확인할 수 있습니다.  
      <br>- 오늘의 영화 랭킹을 확인할 수 있고, 좋아요를 바로 설정할 수 있습니다.  
    </td>
  </tr>
</table>  

#### 검색 화면  
<table>
  <tr>
    <td width="200">
      <img src="https://github.com/user-attachments/assets/0c033024-06e5-4572-974e-a25c03efbc2e" width="100%">
    </td>
    <td width="600">
      <br>- 키워드를 통해 영화를 검색할 수 있습니다. 기본 20개 단위로 데이터를 호출하지만, 스크롤을 통해 전체 검색결과를 확인할 수 있습니다.
      <br>- 포스터, 제목, 개봉일, 장르 등 간단한 정보를 확인할 수 있고, 역시 좋아요를 바로 설정할 수 있습니다.  
    </td>
  </tr>
</table>  

#### 상세 화면  
<table>
  <tr>
    <td width="200">
      <img src="https://github.com/user-attachments/assets/d945af78-daa3-4402-babe-abe16820e8d7" width="100%">
    </td>
    <td width="600">
      <br>- 메인 화면의 오늘의 영화, 검색 화면의 검색 결과를 통해 상세 화면으로 이동할 수 있습니다.  
      <br>- 해당 영화의 제목, 캐스트, 시나리오, 포스터 등 관련 상세 정보를 확인할 수 있습니다.  
      <br>- 물론 좋아요도 설정할 수 있습니다.  
    </td>
  </tr>
</table>  

#### 유저 화면  
<table>
  <tr>
    <td width="200">
      <img src="https://github.com/user-attachments/assets/4583c9c6-d2b6-4e33-8eca-3bb0f80f4ef6" width="100%">
    </td>
    <td width="200">
      <img src="https://github.com/user-attachments/assets/73f99c06-2b8f-4f9a-8165-1fc74149e090" width="100%">
    </td>
    <td width="400">
      <br>- 유저 닉네임과 프로필 이미지를 변경할 수 있습니다.  
    </td>
  </tr>
</table>  

### 사용 기술
#### View
전반적인 View 의 Layout 은 SnapKit 을 이용하여 구성하였습니다.
<br>각 화면은 특성에 따라 스크롤이 가능하게 되어 있으며, 테이블뷰, 콜렉션뷰, 스크롤뷰+스택뷰 조합을 다양하게 이용하고 있습니다.
<br>예를 들어, 셀의 재사용이 필요한 검색 결과 화면의 경우 커스텀 셀을 이용한 TableView를 이용, prefetchingData 를 통해 페이지네이션을 구현했습니다.
<br>반면, 수평 스크롤이 필요한 경우에는 CollectionView 를 이용하여 뷰를 구성하였습니다.
<br>메인뷰의 [최근 검색어] 항목 역시 수평 스크롤이 필요한 영역이지만, 검색어 길이에 따라 버튼 길이를 유동적으로 조절할 필요가 있었기 때문에, 보다 간단한 방법으로 구현하고자 버튼 자체의 intrinsicSize 특성을 이용하여 StackView 에 적재, StackView 를 Horizontal ScrollView 에 추가하는 형태로 구현하였습니다.
<br>
#### Network
영화에 관련된 데이터는 [TMDB](https://www.themoviedb.org/) 에서 제공하고 있는 API 를 이용하여 취득합니다.
<br>API Request 는 Alamofire 를 이용한 단일 메서드로 구현하였고, 해당 메서드는 NetworkManager 의 Singleton 인스턴스를 통하여만 호출됩니다.
<br>Request 종류(오늘의 영화, 검색 결과 등) 를 enum case 로 관리하여 각 api 에 필요한 header, parameter 등을 분류하여 사용합니다.
<br>취득한 이미지의 URL 은 Kingfisher 를 이용하여 imageView 의 image 로 세팅합니다.
<br>
#### Data
API 통신을 이용한 영화 데이터 외에 유저의 닉네임, 프로필 이미지, 좋아요 표시를 한 영화, 최근 검색한 키워드 등은 모두 UserDefaults 를 이용하여 관리합니다.
<br>Property Wrapper 와 Property Observer 를 이용하여 각 변수에 변화가 감지될 때마다 저장되도록 관리되고 있고, 자연히 단일 저장소 역할을 하게 됩니다.
<br>각 화면은 로드 될 때마다 UserDefaults 를 통해 필요한 정보를 취득하여 반영할 수 있습니다.
<br>

### App Flow
앱의 전반적인 흐름은 다음과 같습니다.
<img src="https://github.com/user-attachments/assets/5e0e50ad-d087-4716-8fed-df4a6dcde082" width="500">
<br>런치 스크린 - 온보딩 화면 - 유저 설정을 완료하면 메인 화면으로 진입할 수 있습니다. (앱 시작 시 이미 유저 정보가 있는 상황이라면 메인 화면으로 즉시 진입합니다.)
<br>메인화면에서는 두 가지 방법으로 검색화면에 진입할 수 있습니다. 네비게이션 오른쪽 영역의 돋보기 아이콘을 클릭하면 새롭게 검색이 가능한 검색창으로, 최근 검색어의 버튼을 누르면 해당 검색어가 검색된 결과창으로 이동합니다.
<br>메인화면 오늘의 영화에서는 특정 영화를 선택하면 해당 영화의 상세 정보를 확인할 수 있는 상세화면으로 진입합니다. 검색결과 중 하나를 선택해도 마찬가지로 이동합니다.
<br>프로필 카드 영역을 이용해서 닉네임이나 프로필 이미지를 변경할 수 있습니다. 또, 프로필 탭에서는 유저 탈퇴도 가능합니다. (앱 재시작시 유저 정보가 없기 때문에 온보딩부터 시작합니다.)

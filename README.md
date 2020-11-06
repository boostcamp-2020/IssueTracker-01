# IssueTracker-01

<p align="middle">
    <img alt="Swift" src="https://img.shields.io/badge/swift-v5.3-orange?logo=swift">
    <img alt="Node.js" src="https://img.shields.io/badge/node.js-v12.18.3-cf?logo=node.js)">
    <img alt="Javascript" src="https://img.shields.io/badge/javascript-ES6+-yellow?logo=javascript">
    <img alt="React" src="https://img.shields.io/badge/react-0.0.0-blue?logo=react">
    <img alt="Document" src="https://img.shields.io/badge/document-yes-important">
    <img alt="GitHub commit activity" src="https://img.shields.io/github/commit-activity/w/boostcamp-2020/IssueTracker-01">
</p>

## 👩‍💻 소개

### 🧙J019 권오민 [@ohmink](https://github.com/ohmink)
> 그냥 집순이 
### 🧐J167 이호영 [@2hoyeong](https://github.com/2hoyeong)
> 불편한 코드는 못참는
### :kr:J184 정상우 [@sangw3433](https://github.com/sangw3433)
> 롤을 좋아하는 한국인입니다. 
### :apple:S009 김석호 [@SeokBA](https://github.com/SeokBA)
>  일찍 일어나는 새ㄲ :bird: 
### 🛌 S059 최광현  [@nrurnru](https://github.com/nrurnru)
> 얼른 끝내고 쉬죠?

## :construction_worker: 프로젝트 소개 
### [GitHub 이슈 관리 서비스](https://github.com/issues) 클론 구현
- 웹과 앱을 통해 사용자의 이슈, 레이블, 마일스톤 목록을 관리할 수 있게 한다.



## :world_map: Wiki

* [**Team Rules**](https://github.com/boostcamp-2020/IssueTracker-01/wiki/Rules)
* [**Daily Scrum**](https://github.com/boostcamp-2020/IssueTracker-01/wiki/Daily-Scrum)
* [**API 명세**](https://github.com/boostcamp-2020/IssueTracker-01/wiki/API-%EB%AA%85%EC%84%B8)


##  :computer: Backend Server
### 구조
```
├bin
│  www
├passport
|  passport.js
├models
│  commentModel.js
│  index.js
│  issueLabelModel.js
│  issueModel.js
│  labelModel.js
│  milestoneModel.js
│  userModel.js
├services
└routes
```
### 흐름
![](https://i.imgur.com/UTtN70S.png)


### ERD
![erd](https://i.ibb.co/BfJdjGX/erd.png)

## :apple:iOS
- [x] Login
    - Github OAuth를 이용한 로그인  
    <img width="50%" src="https://user-images.githubusercontent.com/45285737/97650166-754af880-1a9c-11eb-87e0-2b548163696f.gif"></img>  
- [ ] Issue Tab
- [ ] Label Tab
- [ ] Milestone Tab
- [ ] 선택/추가 구현

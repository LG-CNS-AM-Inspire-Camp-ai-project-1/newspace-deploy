# newspace-deploy
<img src="https://github.com/user-attachments/assets/04d415b7-b379-4a0b-9aba-ff1d3609db85" width="300" />

<br>
newspace-deploy 입니다.
<br>
해당 레포지토리에는 CI/CD에 필요한 Dockerfile과 배포 스크립트가 포함되어있습니다. 
<br>

## 📽️ CI/CD 배포 시연 영상
[https://youtu.be/yXdEaNA0_rc](https://youtu.be/yXdEaNA0_rc)

## 📍 프로젝트 설명
25.02.21 ~ 25.02.26
<br>
LG CNS AM Inspire Camp
<br>
미니프로젝트 1 - 1조
<br>
<br>
현대 사회에서는 뉴스가 빠르게 생산되고 실시간으로 소비되는 경향이 강합니다. 
<br>
이러한 환경 속에서 사용자가 과거의 중요한 이슈를 되짚어보는 일이 마냥 쉽지만은 않습니다.
<br>
이에 저희는 AI를 활용하여 오늘 날짜에 있었던 과거의 핫 뉴스를 제공하는 서비스, Newspace를 개발하였습니다.


## 👩‍💻 Backend 팀원
<table>
    <tr>
        <!-- 첫 번째 팀원 -->
        <td align="center" width="33%">
            <img src="https://avatars.githubusercontent.com/u/151743721?v=4" alt="Avatar" width="100px"/><br/>
            <a href="https://github.com/95hyun">현민영(팀장)</a>
            <br/>
            <img src="https://github-readme-stats.vercel.app/api?username=95hyun&show_icons=true&theme=transparent" alt="95hyun's GitHub stats" width="300px"/>
            <br/>
            Spring AI(뉴스), 예외처리,
            <br>
            회원/카테고리/키워드/공지 CRUD
            <br>
            Spring Cloud Gateway 
        </td>
        <!-- 두 번째 팀원 -->
        <td align="center" width="33%">
            <img src="https://avatars.githubusercontent.com/u/39462045?v=4" alt="Avatar" width="100px"/><br/>
            <a href="https://github.com/dhku">구동혁</a>
            <br/>
            <img src="https://github-readme-stats.vercel.app/api?username=dhku&show_icons=true&theme=transparent" alt="dhku's GitHub stats" width="300px"/>
            <br/>
            Jenkins CI/CD, docker-compose, 
            <br>
            프로필 이미지 CRUD, 
            <br>
            Spring Cloud Eureka
        </td>
        <!-- 세 번째 팀원 -->
        <td align="center" width="33%">
            <img src="https://avatars.githubusercontent.com/u/124752866?v=4" alt="Avatar" width="100px"/><br/>
            <a href="https://github.com/minnnseokk">정민석</a>
            <br/>
            <img src="https://github-readme-stats.vercel.app/api?username=minnnseokk&show_icons=true&theme=transparent" alt="minnnseokk's GitHub stats" width="300px"/>
            <br/>
            Spring Security, 
            <br>
            JWT 토큰-쿠키 처리 로직, 
            <br>
            일반로그인, 로그아웃, 회원탈퇴
        </td>
    </tr>
</table>
<br/>

## 🛠️ 기술 스택

<img src="https://img.shields.io/badge/Spring%20Boot-6DB33F?style=for-the-badge&logo=SpringBoot&logoColor=white"> <img src="https://img.shields.io/badge/Spring%20Security-6DB33F?style=for-the-badge&logo=SpringSecurity&logoColor=white"> <img src="https://img.shields.io/badge/Gradle-02303A?style=for-the-badge&logo=Gradle&logoColor=white"> <img src="https://img.shields.io/badge/Spring%20Cloud-6DB33F?style=for-the-badge&logo=Spring&logoColor=white"> <img src="https://img.shields.io/badge/Spring%20AI-6DB33F?style=for-the-badge&logo=Spring&logoColor=white"> <img src="https://img.shields.io/badge/Spring%20WebFlux-6DB33F?style=for-the-badge&logo=SpringWebFlux&logoColor=white"> <img src="https://img.shields.io/badge/MariaDB-003545?style=for-the-badge&logo=MariaDB&logoColor=white"> <img src="https://img.shields.io/badge/Docker-2496ED?style=for-the-badge&logo=Docker&logoColor=white"> <img src="https://img.shields.io/badge/Jenkins-D24939?style=for-the-badge&logo=Jenkins&logoColor=white"> <img src="https://img.shields.io/badge/Postman-FF6C37?style=for-the-badge&logo=Postman&logoColor=white"> <img src="https://img.shields.io/badge/Swagger-85EA2D?style=for-the-badge&logo=Swagger&logoColor=white"> <img src="https://img.shields.io/badge/Notion-000000?style=for-the-badge&logo=Notion&logoColor=white"> <img src="https://img.shields.io/badge/NGINX-009639?style=for-the-badge&logo=NGINX&logoColor=white"> 

<br/>

## 📂 폴더 구조

```
.
├── jenkins // 젠킨스
│   ├── build.sh
│   ├── deploy-cloud.sh // 유레카, API-GATEWAY 통합 배포 스크립트
│   ├── deploy.sh // 모놀리식 배포 스크립트
│   ├── Dockerfile // 젠킨스 Dockerfile
│   ├── pipeline-cloud.sh 
│   ├── pipeline.sh
│   ├── remove.sh
│   └── run.sh
├── local // 로컬(Docker Desktop 용)
│   └── docker-compose.yml
├── README.md
├── release // 모놀리식
│   ├── backend
│   │   ├── Dockerfile
│   │   └── src
│   │       └── main
│   │           └── resources
│   │               └── application.yml
│   ├── docker-compose.yml
│   └── frontend // 프론트
│       ├── Dockerfile
│       └── nginx.conf
└── release-cloud // MSA
    ├── backend // 백엔드
    │   ├── Dockerfile
    │   └── src
    │       └── main
    │           └── resources
    │               └── application.yml
    ├── eureka // 유레카
    │   ├── Dockerfile
    │   └── src
    │       └── main
    │           └── resources
    │               └── application.yml
    └── gateway // 게이트웨이
        ├── Dockerfile
        └── src
            └── main
                └── resources
                    └── application.yml
```
<br/>


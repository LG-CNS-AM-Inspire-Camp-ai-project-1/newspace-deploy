# newspace-deploy


<br>

## 📍 프로젝트명: Newspace
<img src="https://github.com/user-attachments/assets/04d415b7-b379-4a0b-9aba-ff1d3609db85" width="300" />
<br>


## 👩‍💻 팀원
<table>
    <tr>
        <!-- 첫 번째 팀원 -->
        <td align="center" width="50%">
            <img src="https://avatars.githubusercontent.com/dhku" alt="Avatar" width="100px"/><br/>
            <a href="https://github.com/dhku">구동혁</a>
            <br/>
            <img src="https://github-readme-stats.vercel.app/api?username=dhku&show_icons=true&theme=transparent" alt="Minju's GitHub stats" width="350px"/>
        </td>
    </tr>
</table>
<br/>

## 🛠️ 기술 스택

<img src="https://img.shields.io/badge/SpringBoot-6DB33F?style=for-the-badge&logo=SpringBoot&logoColor=white"> <img src="https://img.shields.io/badge/SpringSecurity-6DB33F?style=for-the-badge&logo=SpringSecurity&logoColor=white"> <img src="https://img.shields.io/badge/Gradle-02303A?style=for-the-badge&logo=Gradle&logoColor=white"> <img src="https://img.shields.io/badge/SpringCloudeureka-6DB33F?style=for-the-badge&logo=Spring&logoColor=white"> <img src="https://img.shields.io/badge/SpringAI-6DB33F?style=for-the-badge&logo=Spring&logoColor=white"> <img src="https://img.shields.io/badge/SpringWebFlux-6DB33F?style=for-the-badge&logo=SpringWebFlux&logoColor=white"> <img src="https://img.shields.io/badge/MariaDB-003545?style=for-the-badge&logo=MariaDB&logoColor=white"> <img src="https://img.shields.io/badge/Docker-2496ED?style=for-the-badge&logo=Docker&logoColor=white"> <img src="https://img.shields.io/badge/Jenkins-D24939?style=for-the-badge&logo=Jenkins&logoColor=white"> <img src="https://img.shields.io/badge/NGINX-009639?style=for-the-badge&logo=NGINX&logoColor=white"> 

<br/>

## 📂 프로젝트 아키텍처

```
.
├── jenkins
│   ├── build.sh
│   ├── deploy-cloud.sh
│   ├── deploy.sh
│   ├── Dockerfile
│   ├── pipeline-cloud.sh
│   ├── pipeline.sh
│   ├── remove.sh
│   └── run.sh
├── local
│   └── docker-compose.yml
├── README.md
├── release
│   ├── backend
│   │   ├── Dockerfile
│   │   └── src
│   │       └── main
│   │           └── resources
│   │               └── application.yml
│   ├── docker-compose.yml
│   └── frontend
│       ├── Dockerfile
│       └── nginx.conf
└── release-cloud
    ├── backend
    │   ├── Dockerfile
    │   └── src
    │       └── main
    │           └── resources
    │               └── application.yml
    ├── eureka
    │   ├── Dockerfile
    │   └── src
    │       └── main
    │           └── resources
    │               └── application.yml
    └── gateway
        ├── Dockerfile
        └── src
            └── main
                └── resources
                    └── application.yml
```
<br/>


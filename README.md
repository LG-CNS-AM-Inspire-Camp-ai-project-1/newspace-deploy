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

<img src="https://img.shields.io/badge/HTML5-E34F26?style=for-the-badge&logo=HTML5&logoColor=white"> <img src="https://img.shields.io/badge/CSS3-1572B6?style=for-the-badge&logo=CSS3&logoColor=white"> <img src="https://img.shields.io/badge/JavaScript-F7DF1E?style=for-the-badge&logo=JavaScript&logoColor=black"> <img src="https://img.shields.io/badge/React-61DAFB?style=for-the-badge&logo=React&logoColor=black"> <img src="https://img.shields.io/badge/Vite-646CFF?style=for-the-badge&logo=Vite&logoColor=white"> <img src="https://img.shields.io/badge/Figma-F24E1E?style=for-the-badge&logo=Figma&logoColor=white"> 

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


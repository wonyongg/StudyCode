FROM node
# 도커 내 작업 디렉터리 설정
WORKDIR /app 
# backend 폴더의 package.json을 작업 디렉터리로 복사
COPY package.json .
# 빌드가 시작되면 npm install 명령어를 실행하여 프로젝트에서 요구하는 모든 종속성을 이미지 안에 설치
RUN npm install
# backend 폴더의 나머지 코드를 작업 디렉토리로 복사
COPY . .
# 80번 포트 노출
EXPOSE 80
# 이미지를 기반으로 컨테이너가 시작될 때 node 런타임으로 app.js 실행
CMD ["node", "app.js"]

FROM node:14
# node가 React 코드를 최적화하고 브라우저가 이해할 수 있는 코드로 변환하기 때문에 node 기반으로 이미지를 만든다.
WORKDIR /app
# 백엔드 컨테이너와 별개의 컨테이너이기 때문에 경로명이 같아도 된다.

COPY package.json .

RUN npm install

COPY . .

EXPOSE 3000

CMD [ "npm", "start" ]
# package.json 파일 내의 start 스크립트를 실행한다.
# JSON Server 환경 분리

이 디렉터리는 `json-server`를 이용해 목업 API를 실행하기 위한 전용 환경입니다.

## 설치
```bash
cd json-server
npm install
```

## 데이터 재생성
SERP API를 호출해 `data/hoteldb.json` 파일을 갱신합니다.
```bash
npm run build-data
```

## 서버 실행
```bash
npm start
```
기본 포트는 `4000`이며 필요하다면 `--port` 옵션을 변경해 사용할 수 있습니다.

## 참고
- 생성된 `node_modules` 디렉터리는 `.gitignore`에 추가되어 있습니다.
- `data/hoteldb.json` 파일은 기존 Java 웹 애플리케이션과 목업 API가 함께 사용하는 공유 데이터 파일입니다.

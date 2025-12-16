# JSP AI 프로젝트

Spring MVC + JSP + MyBatis 기반의 웹 애플리케이션 프로젝트입니다.

## 🚀 기술 스택

- **Backend**: Spring MVC 5.0.7, MyBatis
- **Frontend**: JSP, Tailwind CSS, Swiper.js
- **Template Engine**: Apache Tiles 3
- **Database**: PostgreSQL
- **Build Tool**: Maven
- **Java Version**: 1.8

## 📁 프로젝트 구조

```
jsp-ai/
├── src/main/
│   ├── java/com/core/
│   │   ├── event/          # Event 도메인 (Controller, Service, Mapper, Entity)
│   │   ├── product/        # Product 도메인
│   │   ├── brand/          # Brand 도메인
│   │   ├── config/         # 설정 클래스 (WebConfig, DataSourceConfig)
│   │   └── common/         # 공통 유틸리티
│   ├── resources/
│   │   ├── mapper/         # MyBatis XML Mapper
│   │   ├── db/migration/   # 데이터베이스 마이그레이션
│   │   ├── tiles.xml       # Apache Tiles 설정
│   │   └── mybatis-config.xml
│   └── webapp/
│       ├── WEB-INF/tags/   # JSP 태그 파일 (FSD 구조)
│       │   ├── app/        # 라우팅 (home, events)
│       │   ├── pages/      # 페이지 (페이지 템플릿 관리)
│       │   ├── widgets/    # 위젯 컴포넌트
│       │   ├── features/   # 기능별 컴포넌트
│       │   └── shared/     # 공유 UI 컴포넌트
│       └── public/         # 정적 리소스
│           ├── css/        # CSS 파일
│           ├── images/     # 이미지 파일
│           └── js/         # JavaScript 파일
└── pom.xml
```

## 🏃 실행 방법

### 1. 데이터베이스 설정

데이터베이스 연결 정보는 시스템 프로퍼티 또는 환경 변수로 설정합니다:

```bash
# 시스템 프로퍼티로 설정
-Ddb.url=jdbc:postgresql://localhost:5432/dbname
-Ddb.username=username
-Ddb.password=password
-Ddb.driver=org.postgresql.Driver

# 또는 환경 변수로 설정
export DB_URL=jdbc:postgresql://localhost:5432/dbname
export DB_USERNAME=username
export DB_PASSWORD=password
export DB_DRIVER=org.postgresql.Driver
```

기본값: (확인을 위해 올려둔 상태입니다.)
- URL: `jdbc:postgresql://199.192.27.181:10036/hddfs_dev`
- Username: `hddfs_dev`
- Password: `123456`

### 2. 빌드 및 실행

```bash
# Maven 빌드
mvn clean package

# Tomcat 실행 (Maven 플러그인 사용)
mvn tomcat7:run

# 또는 WAR 파일을 Tomcat에 배포
cp target/jsp-ai-1.0-SNAPSHOT.war $TOMCAT_HOME/webapps/
```

### 3. 접속

애플리케이션 실행 후 브라우저에서 접속:

- **컴포넌트 확인 페이지**: `http://localhost:8080/jsp-ai/`
- **Events 상세 과제 (ID=1)**: `http://localhost:8080/jsp-ai/events/1` ⭐

> ⚠️ **주의**: Events 상세 페이지는 `/events/1` 경로로 접근해야 확인할 수 있습니다.

### Home 페이지 (`/`)

- 메인 페이지
- 다양한 위젯 및 컴포넌트 예시

## 🎨 스타일링

- **Tailwind CSS**: 유틸리티 퍼스트 CSS 프레임워크
- **커스텀 값**: Figma 디자인 값 정확히 반영 (`bg-[#FFFFFF]`, `text-[18px]` 등)
- **반응형**: 모바일/PC 대응

## 🏗️ 아키텍처

### FSD (Feature-Sliced Design) 구조

- **app/**: 페이지 레벨 컴포넌트
- **widgets/**: 재사용 가능한 복잡한 컴포넌트
- **features/**: 비즈니스 로직이 포함된 기능 컴포넌트
- **shared/**: 순수 UI 컴포넌트

### 단방향 의존성

```
app → widgets → features → shared
```

상위 레벨은 하위 레벨만 import 가능하며, 하위 레벨은 상위 레벨을 import할 수 없습니다.

## 📝 개발 규칙

자세한 개발 규칙은 다음 문서를 참고하세요:

- `.cursor/fsd-rules.md`: FSD 구조 규칙
- `.cursor/publishing-rules.md`: 퍼블리싱 규칙
- `.cursor/folder-structure.md`: 폴더 구조 규칙
- `.cursorrules`: Cursor AI 규칙

## 🗄️ 데이터베이스

- **MyBatis**: SQL 매퍼 프레임워크
- **마이그레이션**: `src/main/resources/db/migration/` 폴더에 SQL 파일 관리

## 📦 의존성

주요 의존성:

- Spring MVC 5.0.7
- MyBatis 3.x
- HikariCP (Connection Pool)
- Apache Tiles 3
- Tailwind CSS
- Swiper.js

전체 의존성 목록은 `pom.xml`을 참고하세요.

## 🔧 설정 파일

- `pom.xml`: Maven 프로젝트 설정
- `src/main/resources/tiles.xml`: Apache Tiles 레이아웃 정의
- `src/main/resources/mybatis-config.xml`: MyBatis 설정
- `src/main/webapp/WEB-INF/web.xml`: 웹 애플리케이션 설정
- `src/main/java/com/core/config/WebConfig.java`: Spring MVC 설정
- `src/main/java/com/core/config/DataSourceConfig.java`: 데이터소스 설정
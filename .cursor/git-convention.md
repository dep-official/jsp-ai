# Git 커밋 메시지 컨벤션

## 형식
```
<type>(<scope>): <subject>

<body> (선택)
```

## Type (필수)
- `feat`: 새로운 기능 추가
- `fix`: 버그 수정
- `docs`: 문서 수정
- `style`: 코드 스타일 변경 (기능 변경 없음)
- `refactor`: 리팩토링
- `test`: 테스트 추가/수정
- `chore`: 빌드/설정 변경
- `perf`: 성능 개선

## Scope (선택)
- `@jsp`: JSP 파일 관련 (주로 사용)

## Subject (필수)
- 50자 이내
- 첫 글자 대문자 아님
- 마침표 없음
- 명령형으로 작성

## 예시

### 기본 형식
```
feat(@jsp): GNB 컴포넌트 추가 (Figma 디자인 반영)
fix(@jsp): header.jsp 디렉티브 중복 제거
style(@jsp): Tailwind 클래스 정리
refactor(@jsp): FSD 구조로 JSP 파일 재구성
chore(@jsp): Apache Tiles 설정 추가
```

### Body 포함 (복잡한 변경사항)
```
feat(jsp): GNB 컴포넌트 추가

- header.jsp 생성
- Figma MCP로 아이콘 추출 (ic-m-back, ic-m-search, ic-m-cart)
- Tailwind CSS 적용
- 정확한 Figma 디자인 값 반영 (#FFFFFF, #DDE0E5, 60px 등)
```

## 이슈 번호는?
- 커밋 메시지에는 포함하지 않음
- 브랜치명에 포함: `feature/#123-gnb-component`
- PR/MR 제목에 포함: `[JSP-123] GNB 컴포넌트 추가`
- PR/MR 본문에: `Closes #123` 또는 `Related to #123`

## 현재 프로젝트 적용 예시

### 커밋 1: Tiles 설정
```
chore: Apache Tiles 설정 추가
- tiles.xml 생성
- WebConfig에 TilesConfigurer, TilesViewResolver 추가
- Static 리소스 핸들러 설정 (public/)
```

### 커밋 2: View(jsp) 구조 재구성
```
refactor(jsp): FSD 구조로 JSP 파일 재구성
- app/, widgets/ 폴더 구조 생성
- 기존 views/index.jsp 삭제
- layout.jsp, home/page.jsp, events/page.jsp 생성
```

### 커밋 3: GNB 컴포넌트
```
feat(jsp): GNB 컴포넌트 추가 (Figma 디자인 반영)
- header.jsp 생성
- Figma MCP로 아이콘 추출
- Tailwind CSS 적용
```

### 커밋 4: Events 페이지
```
feat(jsp): Events 페이지 추가
- EventsController 추가
- events/page.jsp, events/[id]/page.jsp 생성
- tiles.xml에 events 정의 추가
```

### 커밋 5: 정적 리소스
```
chore(jsp): Public 리소스 추가
- public/images/icons/ 폴더 생성
- Figma 아이콘 SVG 파일 추가
```


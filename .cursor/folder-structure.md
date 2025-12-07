# 폴더 구조 및 네이밍 규칙 (FSD + Next.js 스타일)

## 폴더 구조
```
WEB-INF/
├── app/              # 페이지 (Pages)
│   ├── layout.jsp    # 루트 레이아웃
│   ├── home/         # 페이지 폴더 (kebab-case)
│   │   └── page.jsp  # 페이지 파일 (항상 page.jsp)
│   └── events/       # 페이지 폴더
│       ├── page.jsp
│       └── [id]/      # 동적 라우팅 (Next.js 스타일)
│           └── page.jsp
├── widgets/          # 위젯 (재사용 컴포넌트)
│   ├── Header/       # 위젯 폴더 (PascalCase)
│   │   ├── Header.jsp
│   │   └── ui/       # 위젯 내부 UI 컴포넌트 (선택)
│   │       ├── Button/
│   │       │   └── Button.jsp
│   │       └── Input/
│   │           └── Input.jsp
│   └── Footer/
│       └── Footer.jsp
├── shared/           # 공유
│   └── ui/           # 공유 UI 컴포넌트
│       ├── Button/
│       │   └── Button.jsp
│       ├── Input/
│       │   └── Input.jsp
│       └── Card/
│           └── Card.jsp
├── features/         # 기능별 (필요시)
├── entities/         # (제외)
```

## 네이밍 규칙

### app 폴더명
- kebab-case 사용 (소문자 + 하이픈)
- 예: `home`, `user-profile`, `product-detail`, `events`
- 동적 라우팅: `[id]`, `[slug]` (Next.js 스타일)

### app 폴더 파일명
- 페이지: 항상 `page.jsp` (Next.js 스타일)
- 레이아웃: `layout.jsp` (고정)

### widgets 폴더명
- PascalCase 사용 (컴포넌트명)
- 예: `Header`, `Footer`, `UserCard`, `ProductItem`

### widgets 폴더 파일명
- 위젯명과 동일한 PascalCase
- 예: `Header.jsp`, `Footer.jsp`, `UserCard.jsp`

### widgets/{WidgetName}/ui 폴더명
- 위젯 내부에서만 사용하는 UI 컴포넌트
- PascalCase 사용 (컴포넌트명)
- 예: `Button`, `Input`, `Card`, `Modal`
- 경로: `WEB-INF/widgets/{WidgetName}/ui/{ComponentName}/`

### widgets/{WidgetName}/ui 폴더 파일명
- 컴포넌트명과 동일한 PascalCase
- 예: `Button.jsp`, `Input.jsp`, `Card.jsp`
- 경로: `WEB-INF/widgets/{WidgetName}/ui/{ComponentName}/{ComponentName}.jsp`

### shared/ui 폴더명
- PascalCase 사용 (UI 컴포넌트명)
- 예: `Button`, `Input`, `Card`, `Modal`, `Dropdown`

### shared/ui 폴더 파일명
- 컴포넌트명과 동일한 PascalCase
- 예: `Button.jsp`, `Input.jsp`, `Card.jsp`, `Modal.jsp`

### Tiles Definition 이름
- app 페이지: 폴더 경로와 일치 (kebab-case)
  - 예: `home`, `user-profile`, `events/[id]`
- widgets: 위젯명과 일치 (PascalCase는 kebab-case로 변환)
  - 예: `Header` → `header`, `UserCard` → `user-card`
- widgets/{WidgetName}/ui: 위젯명-ui-컴포넌트명 (kebab-case)
  - 예: `Header/ui/Button` → `header-ui-button`
  - 예: `UserCard/ui/Modal` → `user-card-ui-modal`
- shared/ui: 컴포넌트명과 일치 (PascalCase는 kebab-case로 변환)
  - 예: `Button` → `button`, `UserCard` → `user-card`

## 예시

### ✅ 올바른 예시

**app 폴더:**
- 폴더: `user-profile/`, `product-detail/`, `events/`
- 파일: `page.jsp`
- Tiles: `user-profile`, `product-detail`, `events/[id]`

**widgets 폴더:**
- 폴더: `Header/`, `Footer/`, `UserCard/`
- 파일: `Header.jsp`, `Footer.jsp`, `UserCard.jsp`
- Tiles: `header`, `footer`, `user-card`

**widgets/{WidgetName}/ui 폴더:**
- 폴더: `Header/ui/Button/`, `Header/ui/Input/`
- 파일: `Button.jsp`, `Input.jsp`
- Tiles: `header-ui-button`, `header-ui-input`

**shared/ui 폴더:**
- 폴더: `Button/`, `Input/`, `Card/`, `Modal/`
- 파일: `Button.jsp`, `Input.jsp`, `Card.jsp`, `Modal.jsp`
- Tiles: `button`, `input`, `card`, `modal`

### ❌ 잘못된 예시

**app 폴더:**
- 폴더: `UserProfile/`, `ProductDetail/` (PascalCase ❌)
- 파일: `Page.jsp`, `Index.jsp` (PascalCase ❌)
- 파일: `index.jsp`, `home.jsp` (page.jsp가 아님 ❌)

**widgets 폴더:**
- 폴더: `header/`, `footer/` (kebab-case ❌)
- 파일: `header.jsp`, `footer.jsp` (kebab-case ❌)

**widgets/{WidgetName}/ui 폴더:**
- 폴더: `Header/ui/button/` (kebab-case ❌)
- 파일: `button.jsp` (kebab-case ❌)

**shared/ui 폴더:**
- 폴더: `button/`, `input/` (kebab-case ❌)
- 파일: `button.jsp`, `input.jsp` (kebab-case ❌)

## 경로 예시

```
✅ 올바른 경로:
- WEB-INF/app/home/page.jsp
- WEB-INF/app/user-profile/page.jsp
- WEB-INF/app/events/[id]/page.jsp
- WEB-INF/widgets/Header/Header.jsp
- WEB-INF/widgets/UserCard/UserCard.jsp
- WEB-INF/widgets/Header/ui/Button/Button.jsp
- WEB-INF/widgets/Header/ui/Input/Input.jsp
- WEB-INF/shared/ui/Button/Button.jsp
- WEB-INF/shared/ui/Input/Input.jsp
- WEB-INF/shared/ui/Card/Card.jsp

❌ 잘못된 경로:
- WEB-INF/app/Home/Page.jsp
- WEB-INF/widgets/header/header.jsp
- WEB-INF/widgets/Header/ui/button/button.jsp
- WEB-INF/shared/ui/button/button.jsp
```


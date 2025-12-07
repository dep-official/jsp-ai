# 퍼블리싱 규칙 (시맨틱 마크업, SEO, 접근성)

## 1. 시맨틱 마크업 및 SEO (필수)

### HTML5 시맨틱 태그 사용
- **시맨틱 태그 우선 사용**
  - `<header>`, `<nav>`, `<main>`, `<article>`, `<section>`, `<aside>`, `<footer>` 적절히 사용
  - `<div>` 남용 금지, 의미 있는 태그 우선 사용
  - 제목 계층 구조 준수: `<h1>` → `<h2>` → `<h3>` 순서 유지
  - 불필요한 `<div>` 사용 금지, 최대한 깔끔한 마크업 유지 
  - 순서가 있는 경우 `<ol>`, 리스트의 겨우 `<ul>`, 경우에 따라 `<dl>` 활용
  - `<img>`를 감싸는 경우 `<figure>` 활용

- **예시:**
```jsp
<!-- ✅ 올바른 예시 -->
<header>
    <nav aria-label="주 메뉴">
        <ul>
            <li><a href="/">홈</a></li>
        </ul>
    </nav>
</header>
<main>
    <h1>제목</h1>
    <section>
        <h2>섹션 제목</h2>
    </section>
</main>

<!-- ❌ 잘못된 예시 -->
<div class="header">
    <div class="nav">
        <div class="menu-item">홈</div>
    </div>
</div>
```

### SEO 메타 태그
```jsp
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${title != null ? title : 'JSP AI'}</title>
    
    <!-- 기본 SEO 메타 태그 -->
    <meta name="description" content="${seo != null && seo.description != null ? seo.description : '기본 설명'}">
    <meta name="keywords" content="${seo != null && seo.keywords != null ? seo.keywords : ''}">
    
    <!-- Open Graph (Facebook, LinkedIn 등) -->
    <meta property="og:title" content="${seo != null && seo.ogTitle != null ? seo.ogTitle : title}">
    <meta property="og:description" content="${seo != null && seo.ogDescription != null ? seo.ogDescription : description}">
    <meta property="og:image" content="${seo != null && seo.ogImage != null ? seo.ogImage : ''}">
    <meta property="og:url" content="${pageContext.request.requestURL}">
    <meta property="og:type" content="website">
    
    <!-- Twitter Card -->
    <meta name="twitter:card" content="summary_large_image">
    <meta name="twitter:title" content="${seo != null && seo.ogTitle != null ? seo.ogTitle : title}">
    <meta name="twitter:description" content="${seo != null && seo.ogDescription != null ? seo.ogDescription : description}">
    <meta name="twitter:image" content="${seo != null && seo.ogImage != null ? seo.ogImage : ''}">
    
    <!-- Canonical URL -->
    <link rel="canonical" href="${pageContext.request.requestURL}"> 
</head>
```

### 구조화된 데이터 (Schema.org)
- 가능한 경우 JSON-LD 형식으로 구조화된 데이터 추가
- 예: Article, Product, BreadcrumbList 등

```jsp
<!-- 예시: Article 구조화된 데이터 -->
<script type="application/ld+json">
{
  "@context": "https://schema.org",
  "@type": "Article",
  "headline": "${title}",
  "description": "${seo != null && seo.description != null ? seo.description : ''}",
  "image": "${seo != null && seo.ogImage != null ? seo.ogImage : ''}",
  "datePublished": "${publishedDate}",
  "author": {
    "@type": "Organization",
    "name": "JSP AI"
  }
}
</script>
```

### 이미지 최적화 및 SEO
- **모든 `<img>` 태그에 `alt` 속성 필수**
- 의미 있는 alt 텍스트 작성 (SEO 및 접근성)
- 예시:
  - ❌ `<img src="..." alt="상품 이미지">`
  - ✅ `<img src="..." alt="나이키 에어맥스 운동화 화이트 컬러">`
- 이미지 파일명도 의미 있게: `product-nike-airmax-white.jpg` ✅

## 2. 접근성 (Accessibility) - ARIA 및 스크린 리더 (필수)

### 스크린 리더 이해하기
- **스크린 리더의 3요소: 역할(Role), 레이블(Label), 상태(State)**
  - 스크린 리더는 화면 속 요소와 정보를 음성으로 전달하는 보조 기술
  - 접근성을 고려한 코드 작성 시 스크린 리더가 내용을 자연스럽게 읽도록 해야 함

- **스크린 리더가 읽는 순서:**
  1. **역할(Role)**: 요소가 어떤 종류인지 (예: 버튼, 입력창, 스위치 등)
  2. **레이블(Label)**: 컴포넌트의 이름, 어떤 기능인지 설명
  3. **상태(State)**: 현재 상태 (예: 활성화됨, 꺼짐, 선택됨 등)

- **예시:**
```jsp
<!-- 스크린 리더가 읽는 순서: 레이블 → 역할 → 상태 -->
<div
  role="radio"
  tabindex="0"
  aria-checked="true"
  aria-label="마케팅 알림"
></div>
<!-- 스크린 리더: "마케팅 알림, 체크상자, 선택됨" -->
```

### 역할(Role) 설정
- **역할은 요소가 어떤 종류인지 나타냄**
  - HTML 시맨틱 태그는 기본 역할을 가짐: `<button>` = 버튼 역할, `<nav>` = 네비게이션 역할
  - 시맨틱 태그로 표현 불가능한 경우 `role` 속성 사용
  - 예: `<div role="button">` (시맨틱 태그 사용 권장: `<button>`)

- **주요 역할 예시:**
  - `role="button"`: 버튼 역할
  - `role="tab"`: 탭 역할
  - `role="tablist"`: 탭 목록 역할
  - `role="dialog"`: 모달/다이얼로그 역할
  - `role="alert"`: 알림 메시지 역할

- **예시:**
```jsp
<!-- ✅ 올바른 예시: 시맨틱 태그 사용 -->
<button>클릭</button>

<!-- ✅ 올바른 예시: 역할 명시 -->
<div role="tablist" aria-label="메뉴">
  <button role="tab" aria-selected="true">첫번째 항목</button>
  <button role="tab" aria-selected="false">두번째 항목</button>
</div>
<!-- 스크린 리더: "메뉴, 탭그룹. 첫번째 항목, 탭, 선택됨" -->
```

### 레이블(Label) 설정
- **레이블은 컴포넌트의 이름, 어떤 기능인지 설명**
  - 버튼/링크에 명확한 `aria-label` 제공
  - 아이콘만 있는 버튼은 반드시 `aria-label` 필수
  - 예: `<button aria-label="장바구니로 이동"><img src="cart.svg" alt=""></button>`

- **레이블 제공 방법:**
  - `aria-label`: 직접 레이블 지정
  - `aria-labelledby`: 다른 요소의 ID를 참조
  - 텍스트 콘텐츠: 버튼 내부 텍스트가 레이블 역할

- **예시:**
```jsp
<!-- ✅ 올바른 예시: aria-label 사용 -->
<button aria-label="장바구니로 이동">
    <img src="cart.svg" alt="">
</button>

<!-- ✅ 올바른 예시: 텍스트 콘텐츠가 레이블 -->
<button>장바구니</button>

<!-- ✅ 올바른 예시: aria-labelledby 사용 -->
<h2 id="section-title">상품 목록</h2>
<section aria-labelledby="section-title">
    <!-- 콘텐츠 -->
</section>
```

### 상태(State) 설정
- **상태는 현재 상태를 알려줌**
  - `aria-expanded`: 드롭다운/아코디언 열림/닫힘 상태 (`true`/`false`)
  - `aria-selected`: 탭, 옵션 등 선택 상태 (`true`/`false`)
  - `aria-checked`: 체크박스, 라디오 선택 상태 (`true`/`false`/`mixed`)
  - `aria-hidden`: 스크린 리더에서 숨김 (`true`/`false`)
  - `aria-current`: 현재 페이지/항목 표시 (`page`, `step`, `location` 등)
  - `aria-live`: 동적 콘텐츠 변경 알림 (`polite`, `assertive`, `off`)
  - `aria-invalid`: 유효하지 않은 입력 표시 (`true`/`false`)

- **예시:**
```jsp
<!-- ✅ 올바른 예시: 상태 표시 -->
<button aria-label="메뉴 열기" aria-expanded="false" aria-controls="main-menu">
    <img src="menu.svg" alt="">
</button>
<nav id="main-menu" aria-label="주 메뉴" aria-hidden="true">
    <ul>
        <li><a href="/" aria-current="page">홈</a></li>
    </ul>
</nav>
```

- **예시:**
```jsp
<!-- ✅ 올바른 예시 -->
<button aria-label="메뉴 열기" aria-expanded="false" aria-controls="main-menu">
    <img src="menu.svg" alt="">
</button>
<nav id="main-menu" aria-label="주 메뉴" aria-hidden="true">
    <ul>
        <li><a href="/" aria-current="page">홈</a></li>
    </ul>
</nav>

<!-- ❌ 잘못된 예시 -->
<button><img src="menu.svg"></button>
<nav>
    <ul>
        <li><a href="/">홈</a></li>
    </ul>
</nav>
```

### 스크린 리더 고려
- **모든 인터랙티브 요소에 접근 가능한 텍스트 제공**
  - 숨김 텍스트 필요 시: `<span class="sr-only">설명</span>` 또는 `aria-label` 사용
  - Tailwind의 `sr-only` 클래스 활용: `<span class="sr-only">장바구니</span>`

- **폼 요소 접근성**
  - 모든 `<input>`, `<select>`, `<textarea>`에 `<label>` 태그 필수
  - `for` 속성으로 연결: `<label for="email">이메일</label><input id="email">`
  - 또는 `<label>`로 감싸기: `<label>이메일 <input type="email"></label>`

- **예시:**
```jsp
<!-- ✅ 올바른 예시 -->
<label for="search-input">검색어 입력</label>
<input type="search" id="search-input" aria-describedby="search-help">
<span id="search-help" class="sr-only">상품명, 브랜드명으로 검색하세요</span>

<!-- ❌ 잘못된 예시 -->
<input type="search" placeholder="검색어 입력">
```

### 키보드 접근성
- **모든 인터랙티브 요소는 키보드로 접근 가능해야 함**
  - `tabindex` 사용 시 주의:
    - `tabindex="0"`: 포커스 가능 (자연스러운 탭 순서)
    - `tabindex="-1"`: 프로그래밍적 포커스만 가능
    - `tabindex="1"` 이상 사용 금지 (접근성 저해)

- **포커스 관리**
  - 포커스 가능한 요소는 명확한 포커스 스타일 제공
  - Tailwind: `focus:outline-none focus:ring-1 focus:ring-blue-500`
  - 모달/드롭다운 열릴 때 포커스 이동 고려

### 폼 접근성
- **필수 입력 필드 표시**
  - `aria-required="true"` 또는 `required` 속성 사용
  - 시각적 표시도 함께: `<label>이메일 <span aria-hidden="true">*</span></label>`

- **에러 메시지 연결**
  - `aria-describedby`로 에러 메시지 연결
  - `aria-invalid="true"`로 유효하지 않은 입력 표시

- **예시:**
```jsp
<!-- ✅ 올바른 예시 -->
<label for="email">이메일 <span aria-hidden="true">*</span></label>
<input 
    type="email" 
    id="email" 
    required 
    aria-required="true"
    aria-describedby="email-error"
    aria-invalid="${hasError ? 'true' : 'false'}">
<span id="email-error" class="error-message" role="alert">
    ${emailError != null ? emailError : ''}
</span>

<!-- ❌ 잘못된 예시 -->
<input type="email" placeholder="이메일 *">
<span class="error">에러 메시지</span>
```

## 3. 기타 퍼블리싱 고려사항

### 성능 최적화
- **이미지 최적화**
  - 적절한 포맷 사용 (WebP 우선, fallback 제공)
  - 지연 로딩: `<img loading="lazy" src="...">` 속성 활용
  - 반응형 이미지: `<img srcset="..." sizes="...">` 사용

- **Critical CSS**
  - Critical CSS 인라인 고려
  - Tailwind CDN 사용 시 주의 (프로덕션에서는 빌드된 CSS 사용 권장)

### 반응형 디자인
- **모바일 퍼스트 접근**
  - Tailwind의 반응형 클래스 활용: `sm:`, `md:`, `lg:`, `xl:`, `2xl:`
  - 예: `text-sm md:text-base lg:text-lg`

### 크로스 브라우저 호환성 (필수)
- **주요 브라우저 테스트**
  - Chrome, Firefox, Safari, Edge 최신 버전
  - 벤더 프리픽스 필요한 경우 Tailwind 설정 또는 인라인 스타일 사용

- **폴백 제공**
  - 새로운 CSS 기능 사용 시 폴백 고려
  - 예: `display: grid` → `display: flex` 폴백

### 폰트 및 타이포그래피
- **웹폰트 최적화**
  - 웹폰트 사용 시 `font-display: swap` 고려

### 링크 및 버튼
- **의미에 맞는 태그 사용**
  - 링크는 `<a>` 태그, 버튼은 `<button>` 태그 사용
  - JavaScript로 동작하는 링크는 `<button>` 사용 고려

- **외부 링크 처리**
  - 외부 링크는 `target="_blank"` 사용
  - 예: `<a href="https://example.com" target="_blank">외부 사이트</a>`

## 4. 체크리스트

### 파일 생성/수정 전 확인사항
- [ ] 시맨틱 HTML 태그 사용했는가?
- [ ] 모든 이미지에 alt 속성 추가했는가?
- [ ] 인터랙티브 요소에 aria-label 추가했는가?
- [ ] 폼 요소에 label 연결했는가?
- [ ] SEO 메타 태그 추가했는가?
- [ ] 키보드로 접근 가능한가?
- [ ] 포커스 스타일이 명확한가?
- [ ] 색상 대비가 충분한가?
- [ ] 반응형 디자인이 적용되었는가?
- [ ] 링크/버튼 텍스트가 명확한가?

## 5. 참고 자료
- [A11y Fundamentals - 접근성 개발 입문하기](https://frontend-fundamentals.com/a11y/basic-guide/overview.html)
- [WCAG 2.1 가이드라인](https://www.w3.org/WAI/WCAG21/quickref/)
- [MDN Web Docs - ARIA](https://developer.mozilla.org/ko/docs/Web/Accessibility/ARIA)
- [WebAIM Contrast Checker](https://webaim.org/resources/contrastchecker/)
- [Schema.org](https://schema.org/)


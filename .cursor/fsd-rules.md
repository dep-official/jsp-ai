# FSD (Feature-Sliced Design) 규칙

## 🎯 핵심 원칙

### 1. 단방향 의존성 (Import 방향)

**레벨 구조 (상위 → 하위):**
```
[상위] app
   ↓
[중간 1] widgets
   ↓
[중간 2] features
   ↓
[하위] shared
```

**의존성 규칙:**
- ✅ **상위 레벨은 하위 레벨을 import 가능** (아래 방향만)
- ❌ **하위 레벨은 상위 레벨을 import 불가** (위 방향 불가)
- ❌ **같은 레벨 간 import 불가** (수평 방향 불가)

**구체적 예시:**
- `app` (최상위) → `widgets`, `features`, `shared` 모두 사용 가능 ✅
- `widgets` → `features`, `shared` 사용 가능 ✅
- `features` → `shared`만 사용 가능 ✅
- `shared` (최하위) → 아무것도 사용 불가 ❌

**규칙:**
- ✅ **상위 레벨은 하위 레벨을 import 가능**
- ❌ **하위 레벨은 상위 레벨을 import 불가**
- ❌ **같은 레벨 간 import 불가**

### 2. 레벨별 역할

#### `app/` (최상위)
- **역할**: 애플리케이션 진입점, 라우팅, 레이아웃, 페이지 단위 뷰, URL과 1:1 매핑
- **의존 가능**: 모든 하위 레벨 (`widgets`, `features`, `shared`)
- **의존 불가**: 없음 (최상위)

#### `widgets/` (위젯)
- **역할**: 재사용 가능한 복합 컴포넌트 (Header, Footer, Card 등)
- **의존 가능**: `features`, `shared`
- **의존 불가**: `app` (상위 레벨)

#### `features/` (기능)
- **역할**: 비즈니스 기능 단위 컴포넌트
- **의존 가능**: `shared`만
- **의존 불가**: `app`, `widgets` (상위 레벨)

#### `shared/` (공유)
- **역할**: 순수 UI 컴포넌트, 유틸리티
- **의존 가능**: 없음 (최하위)
- **의존 불가**: 모든 상위 레벨

## 📋 상세 규칙

### 규칙 1: 파일 생성 전 재사용 가능성 확인

**파일 생성 전 반드시 확인:**
1. **이미 존재하는 컴포넌트가 있는가?**
   - `shared/ui/` 확인
   - `widgets/` 확인
   - `features/` 확인

2. **재사용 가능한가?**
   - 2개 이상의 곳에서 사용 → `shared/ui/` 또는 `widgets/`
   - 특정 기능에서만 사용 → `features/`

3. **적절한 레벨에 배치되었는가?**
   - 순수 UI 컴포넌트 → `shared/ui/`
   - 복합 컴포넌트 → `widgets/`
   - 비즈니스 로직 포함 → `features/`

### 규칙 2: Import 경로 규칙

#### ✅ 올바른 예시

**app/layout.jsp에서:**
```jsp
<%@ include file="/WEB-INF/widgets/Header/Header.jsp" %>
<%@ include file="/WEB-INF/widgets/Footer/Footer.jsp" %>
<%@ include file="/WEB-INF/shared/ui/Button/Button.jsp" %>
```

**pages/home/page.jsp에서:**
```jsp
<%@ include file="/WEB-INF/widgets/UserCard/UserCard.jsp" %>
<%@ include file="/WEB-INF/features/user-profile/UserProfile.jsp" %>
<%@ include file="/WEB-INF/shared/ui/Button/Button.jsp" %>
```

**widgets/Header/Header.jsp에서:**
```jsp
<%@ include file="/WEB-INF/shared/ui/Button/Button.jsp" %>
<%@ include file="/WEB-INF/shared/ui/Input/Input.jsp" %>
```

#### ❌ 잘못된 예시

**shared/ui/Button/Button.jsp에서:**
```jsp
<!-- ❌ 상위 레벨 import 불가 -->
<%@ include file="/WEB-INF/widgets/Header/Header.jsp" %>
<%@ include file="/WEB-INF/pages/home/page.jsp" %>
```

**widgets/Header/Header.jsp에서:**
```jsp
<!-- ❌ 같은 레벨 import 불가 -->
<%@ include file="/WEB-INF/widgets/Footer/Footer.jsp" %>
<!-- ❌ 상위 레벨 import 불가 -->
<%@ include file="/WEB-INF/pages/home/page.jsp" %>
```

**features/user-profile/UserProfile.jsp에서:**
```jsp
<!-- ❌ 상위 레벨 import 불가 -->
<%@ include file="/WEB-INF/widgets/UserCard/UserCard.jsp" %>
<%@ include file="/WEB-INF/pages/home/page.jsp" %>
```

### 규칙 3: 컴포넌트 배치 가이드

#### `shared/ui/`에 배치
- **조건**: 순수 UI 컴포넌트, 비즈니스 로직 없음
- **예시**: `Button`, `Input`, `Card`, `Modal`, `Dropdown`
- **특징**: 어디서든 재사용 가능

#### `widgets/`에 배치
- **조건**: 여러 UI 컴포넌트 조합, 약간의 로직 포함
- **예시**: `Header`, `Footer`, `UserCard`, `ProductCard`
- **특징**: 여러 페이지에서 재사용

#### `features/`에 배치
- **조건**: 특정 비즈니스 기능, 데이터 처리 포함
- **예시**: `user-profile`, `product-detail`, `cart-summary`
- **특징**: 특정 기능에서만 사용

#### `app/`에 배치
- **조건**: 페이지 전용, URL과 1:1 매핑
- **예시**: `home/page.jsp`, `events/page.jsp`
- **특징**: 재사용 불가, 페이지 고유

### 규칙 4: Tiles Definition 사용 규칙

**Tiles를 통한 include도 동일한 FSD 규칙 적용:**

```xml
<!-- ✅ 올바른 예시: app에서 widgets 참조 -->
<definition name="baseLayout" template="/WEB-INF/app/layout.jsp">
    <put-attribute name="header" value="/WEB-INF/widgets/Header/Header.jsp" />
    <put-attribute name="footer" value="/WEB-INF/widgets/Footer/Footer.jsp" />
</definition>

<!-- ✅ 올바른 예시: pages에서 widgets 참조 -->
<definition name="home" extends="baseLayout">
    <put-attribute name="content" value="/WEB-INF/app/home/page.jsp" />
</definition>
```

## 🔍 체크리스트

### 파일 생성 전 확인사항

- [ ] **재사용 가능성 확인**
  - [ ] 이미 존재하는 유사 컴포넌트가 있는가?
  - [ ] 2개 이상의 곳에서 사용되는가?

- [ ] **적절한 레벨 선택**
  - [ ] 순수 UI → `shared/ui/`
  - [ ] 복합 컴포넌트 → `widgets/`
  - [ ] 비즈니스 기능 → `features/`
  - [ ] 페이지 전용 → `pages/`

- [ ] **의존성 방향 확인**
  - [ ] 상위 레벨에서만 하위 레벨을 import 하는가?
  - [ ] 같은 레벨 간 import가 없는가?
  - [ ] 하위 레벨이 상위 레벨을 import하지 않는가?

## 📚 예시 시나리오

### 시나리오 1: 버튼 컴포넌트 생성

**상황**: 여러 곳에서 사용할 버튼이 필요

**확인:**
1. `shared/ui/Button/` 확인 → 없음
2. 재사용 가능 → `shared/ui/`에 배치

**결과:**
```
✅ WEB-INF/shared/ui/Button/Button.jsp 생성
```

**사용:**
- `app/layout.jsp`에서 사용 가능
- `pages/home/page.jsp`에서 사용 가능
- `widgets/Header/Header.jsp`에서 사용 가능

### 시나리오 2: 사용자 프로필 카드 생성

**상황**: 사용자 정보를 표시하는 카드

**확인:**
1. `shared/ui/` 확인 → `Card` 있음 (재사용 가능)
2. 사용자 데이터 처리 필요 → `widgets/` 또는 `features/`
3. 여러 페이지에서 사용 → `widgets/`

**결과:**
```
✅ WEB-INF/widgets/UserCard/UserCard.jsp 생성
✅ 내부에서 shared/ui/Card/Card.jsp 재사용
```

**사용:**
- `pages/user-profile/page.jsp`에서 사용 가능
- `pages/home/page.jsp`에서 사용 가능
- `shared/ui/`에서는 사용 불가 (상위 레벨)

### 시나리오 3: 장바구니 요약 기능

**상황**: 장바구니 아이템 요약 표시

**확인:**
1. 비즈니스 로직 포함 (장바구니 계산)
2. 장바구니 기능 전용 → `features/`

**결과:**
```
✅ WEB-INF/features/cart/CartSummary/CartSummary.jsp 생성
✅ 내부에서 shared/ui/Card/Card.jsp 재사용
```

**사용:**
- `pages/cart/page.jsp`에서 사용 가능
- `widgets/`에서는 사용 불가 (상위 레벨)

## ⚠️ 주의사항

1. **절대 하위 레벨에서 상위 레벨 import 금지**
   - `shared/ui/` → `widgets/` ❌
   - `features/` → `pages/` ❌

2. **같은 레벨 간 import 금지**
   - `widgets/Header/` → `widgets/Footer/` ❌
   - `features/user-profile/` → `features/cart/` ❌

3. **재사용 가능한 컴포넌트는 항상 하위 레벨에 배치**
   - 여러 곳에서 사용 → `shared/ui/` 또는 `widgets/`
   - 페이지 전용이면 → `pages/`

4. **파일 생성 전 반드시 기존 컴포넌트 확인**
   - 중복 생성 방지
   - 재사용성 극대화


# Components Rules - Buttons (Material Design 기준, 가이드 전용)

## 컴포넌트 기본 구조 (필수)

### 폴더 및 파일 구조
모든 컴포넌트는 `/WEB-INF/tags/` 아래 FSD 구조로 **반드시** 배치해야 합니다:

```
WEB-INF/tags/
├── shared/ui/{ComponentName}/
│   ├── {ComponentName}.jsp    # 컴포넌트 구현 파일
│   └── {ComponentName}.tag    # 커스텀 태그 파일 (선택사항, 권장)
├── widgets/{WidgetName}/
│   └── {WidgetName}.jsp
├── features/{FeatureName}/
│   └── {FeatureName}.jsp
└── app/{PageName}/
    └── page.jsp
```

**예시:**
- `tags/shared/ui/IconButton/IconButton.jsp` + `IconButton.tag`
- `tags/shared/ui/Button/Button.jsp` + `Button.tag`
- `tags/widgets/Header/Header.jsp`
- `tags/app/home/page.jsp`

### 규칙
1. **모든 컴포넌트는 `/WEB-INF/tags/` 아래에 FSD 구조로 배치**
2. **컴포넌트명은 PascalCase** 사용 (예: `IconButton`, `Button`, `Input`)
3. **폴더명과 파일명은 동일**해야 함 (예: `IconButton/IconButton.jsp`)
4. **태그 파일(`.tag`)과 JSP 파일(`.jsp`)은 같은 폴더에 위치** (편의성)
5. **태그 파일은 선택사항이지만 권장** - 깔끔한 사용을 위해
6. **JSP 파일은 항상 존재**해야 함 (태그 파일이 있어도 내부에서 JSP를 include)

### 사용법
커스텀 태그가 있는 경우:
```jsp
<%@ taglib prefix="ui" tagdir="/WEB-INF/tags/shared/ui" %>
<ui:iconButton variant="ghost" size="md" iconUrl="${iconUrl}" />
```

JSP 직접 include:
```jsp
<jsp:include page="/WEB-INF/tags/shared/ui/IconButton/IconButton.jsp">
    <jsp:param name="variant" value="ghost" />
    <jsp:param name="size" value="md" />
</jsp:include>
```

## 공통 작성 원칙
- 기존 규칙 준수: absolute/x,y 좌표 금지, inline-style 금지, 불필요 태그 생성 금지, Tailwind 유틸 사용.
- FSD 방향 준수: `app → widgets → features → shared`; 모든 컴포넌트는 `/WEB-INF/tags/` 아래에 FSD 구조로 배치.
- 버튼 류는 기본적으로 `tags/shared/ui`에 위치, 조합형/도메인형은 `tags/widgets` 또는 `tags/features`로 승격 가능.
- Variant/State/Size는 Figma 값 우선. 불필요한 props로 무거워지지 않게 역할별로 분리.

## 버튼 계열 정의 (Material Design 분류)
- Button: 기본 클릭 액션용.
- Toggle Button: on/off 상태 전환, pressed 토글 가능.
- Icon Button: 아이콘-only 또는 아이콘 중심, 작은 액션.
- Toggle Icon Button: 아이콘 토글 on/off 상태.
- Split Button: 주요 액션 + 보조 드롭다운(chevron) 결합.
- Standard Button Group: 인접 버튼을 묶어 정렬/간격 일관화.
- Connected Button Group: 경계 공유/라운드 연결형 그룹(필요 시).
- Floating Action Button (FAB): 원형, 주요 단일 액션.
- Extended FAB: 라벨+아이콘 확장형 FAB.
- FAB Menu: FAB 확장 메뉴(여러 액션).

## 배치 가이드
- 기본 버튼/아이콘 버튼/토글 버튼은 `tags/shared/ui/Button` 계열로 역할별 컴포넌트 분리 또는 옵션 분리.
- 그룹형(Split/Standard/Connected)은 별도 래퍼 컴포넌트로 관리하여 단일 버튼이 과도하게 비대해지지 않도록 함.
- FAB/Extended FAB/FAB Menu는 별도 컴포넌트로 분리하고 포지션은 레이아웃 측에서 제어(absolute 금지, 컨테이너 내 flex/grid 또는 상대 배치).

## 상태/접근성 체크
- Hover/Focus/Pressed/Disabled 정의는 Figma 토큰에 맞춰 명시.
- Toggle류는 `aria-pressed`로 상태 전달, Icon-only는 `aria-label` 필수.
- 그룹형은 키보드 포커스 이동(좌우/상하) 고려.


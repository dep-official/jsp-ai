# 컴포넌트 분할 기획 (개발 전 제안)

## 공통 전제
- Tailwind 커스텀 bp: `md 600`, `lg 1200` (필요 시 `xl 1600` 확장 합의 후 반영)
- Container padding 유지, inline-style/absolute 좌표 금지, 불필요 태그 생성 금지
- FSD 의존 방향 준수: `app → widgets → features → shared`
- CSS 주석/inline-style 금지, Tailwind 유틸리티만 사용

## shared/ui (순수 UI, 재사용 다수)
- Button: variant(기본/outline/ghost), size(sm/md/lg), state(loading/disabled)
- Icon: SVG sprite/파일 매핑
- Badge/Tag/Chip: 색/톤 variant
- Input/Textarea, Checkbox/Radio, Select/Dropdown
- Tabs, Pagination, Tooltip
- Modal/Drawer, Skeleton/Spinner, Divider
- Card primitives: Card, CardHeader, CardBody, CardFooter

## widgets (복합 컴포넌트)
- Header(완료 기반 개선), Footer
- Hero/TopBanner, CTA Banner
- FilterBar 또는 SortTabs (검색/정렬/필터)
- Carousel/Slider(필요 시)
- Grid/List wrappers for Card 리스트
- Breadcrumb, BottomActionBar/Sticky CTA(모바일 필요 시)

## features (도메인/비즈니스)
- EventCard / EventList (썸네일, 제목, 기간, 액션)
- ProductCard / ProductList (가격/뱃지/상태)
- Review/Rating 블록, Q&A 블록 (있다면)
- Coupon/Benefit 블록, Delivery info 블록 (있다면)

## app (페이지 조립)
- Home, Events 목록/상세 등 Figma 페이지: widgets/features 조합만, layout.jsp 활용

## 추천 구현 순서
1) shared/ui/Button, shared/ui/Icon (아이콘 자산 지정 필요)
2) shared/ui/Badge|Chip, shared/ui/Input, shared/ui/Tabs, shared/ui/Pagination
3) widgets/Header 보완, widgets/Footer, widgets/FilterBar or SortTabs
4) features/EventCard(+리스트 wrapper), 필요 시 ProductCard 패턴
5) 페이지(app/home, app/events 등) 조립

## 협의 필요
- 첫 착수 컴포넌트 선택(권장: Button + Icon)
- 아이콘/이미지 추출 대상(Figma) 지정
- Variant 정의: 버튼 색/사이즈/상태, 뱃지 톤, 카드 variant(기본/할인/품절 등)


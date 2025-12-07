# Cursor Rules 사용 가이드

## 파일 구조
- `.cursorrules`: 메인 Rules 파일 (프로젝트 루트)
- `.cursor/git-convention.md`: Git 커밋 메시지 컨벤션
- `.cursor/folder-structure.md`: 폴더 구조 및 네이밍 규칙 (상세)
- `.cursor/fsd-rules.md`: FSD (Feature-Sliced Design) 규칙 (단방향 의존성, 재사용 원칙)
- `.cursor/publishing-rules.md`: 퍼블리싱 규칙 (시맨틱 마크업, SEO, 접근성)
- `.cursor/README.md`: 이 파일 (사용 가이드)

## 사용 방법
1. Cursor가 자동으로 `.cursor/` 폴더의 모든 `.md` 파일을 읽습니다
2. Git 커밋 메시지 작성 시 `.cursor/git-convention.md` 참고
3. 파일 생성 전 `.cursor/fsd-rules.md` 참고하여 적절한 레벨 선택
4. 퍼블리싱 작업 시 `.cursor/publishing-rules.md` 참고하여 시맨틱 마크업, SEO, 접근성 준수
5. 규칙 업데이트 후 Git에 커밋하여 팀과 공유

## 기존 코드 보호
- 기존 파일은 절대 수정하지 않음
- 새로 생성하는 파일에만 규칙 적용
- 사용자가 명시적으로 요청한 경우만 기존 파일 수정

## FSD 핵심 원칙
- **단방향 의존성**: `app → widgets → features → shared`
- **재사용 우선**: 파일 생성 전 반드시 기존 컴포넌트 확인
- **적절한 레벨 선택**: 순수 UI → `shared/ui/`, 복합 컴포넌트 → `widgets/`, 비즈니스 기능 → `features/`

## 규칙 업데이트
규칙을 수정한 후 반드시 커밋하고 팀과 공유

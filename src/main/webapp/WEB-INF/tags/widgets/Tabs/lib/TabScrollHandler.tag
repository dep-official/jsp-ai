<script>
/**
 * 탭 스크롤 핸들러
 * 탭 클릭 시 섹션으로 스크롤하고, 스크롤 위치에 따라 탭 활성화 상태를 업데이트합니다.
 * 
 * @param {Object} options - 설정 옵션
 * @param {string} options.tabsContainerId - 탭 컨테이너 ID
 * @param {Object} options.sections - 섹션 정보 객체 (key: 인덱스, value: 섹션 ID)
 * @param {number} options.tabBarHeight - 탭 바 높이 (기본값: 56)
 */
(function(window) {
    'use strict';
    
    function TabScrollHandler(options) {
        this.tabsContainerId = options.tabsContainerId;
        this.sections = options.sections || {};
        this.tabBarHeight = options.tabBarHeight || 56;
        
        this.tabsContainer = document.getElementById(this.tabsContainerId);
        this.tabs = this.tabsContainer ? this.tabsContainer.querySelectorAll('.tab-item') : [];
        this.sectionElements = {};
        
        // 섹션 ID를 실제 DOM 요소로 변환
        Object.keys(this.sections).forEach(function(key) {
            var sectionId = this.sections[key];
            this.sectionElements[key] = document.getElementById(sectionId);
        }.bind(this));
        
        this.isScrolling = false;
        this.clickedTabIndex = null;
        this.scrollDebounceTimer = null;
        this.lastScrollTop = 0;
        
        // 활성화 바 생성
        this.initActiveBar();
        
        // 이벤트 리스너 등록
        this.initEventListeners();
        
        // 초기 탭 활성화 상태 설정
        if (Object.keys(this.sectionElements).length > 0) {
            this.updateActiveTab();
        } else {
            // sections가 없으면 첫 번째 활성 탭 찾아서 활성화 바 위치 설정
            var initialActiveIndex = 0;
            this.tabs.forEach(function(tab, index) {
                if (tab.getAttribute('data-active') === 'true') {
                    initialActiveIndex = index;
                }
            });
            this.updateActiveBarPosition(initialActiveIndex);
        }
    }
    
    TabScrollHandler.prototype.initActiveBar = function() {
        // 활성화 바는 Tabs 컨테이너(nav)에 직접 추가하여 border-bottom 위에 위치
        if (!this.tabsContainer.querySelector('.tab-active-bar-global')) {
            this.activeBar = document.createElement('div');
            this.activeBar.className = 'tab-active-bar-global absolute bottom-0 left-0 h-[2px] bg-[#1B1E23] transition-all duration-200 ease-smooth z-10';
            this.tabsContainer.style.position = 'relative';
            this.tabsContainer.appendChild(this.activeBar);
        } else {
            this.activeBar = this.tabsContainer.querySelector('.tab-active-bar-global');
        }
        
        // 컨테이너 내부 div 참조 (위치 계산용)
        this.tabsContainerInner = this.tabsContainer ? this.tabsContainer.querySelector('div') : null;
    };
    
    TabScrollHandler.prototype.updateActiveBarPosition = function(activeIndex) {
        if (!this.activeBar || !this.tabs[activeIndex] || !this.tabsContainerInner) return;
        
        var activeTab = this.tabs[activeIndex];
        // Tabs 컨테이너(nav) 기준으로 탭 위치 계산
        var tabRect = activeTab.getBoundingClientRect();
        var containerRect = this.tabsContainer.getBoundingClientRect();
        
        // Tabs 컨테이너 기준 상대 위치 계산
        var left = tabRect.left - containerRect.left;
        var width = tabRect.width;
        
        // 활성화 바를 border-bottom 위에 정확히 위치
        this.activeBar.style.left = left + 'px';
        this.activeBar.style.width = width + 'px';
        this.activeBar.style.bottom = '0px';
    };
    
    TabScrollHandler.prototype.updateActiveTab = function() {
        // 프로그래밍 방식 스크롤 중에는 업데이트하지 않음
        if (this.isScrolling && this.clickedTabIndex !== null) {
            return;
        }
        
        // sections가 없으면 스크롤 기반 업데이트 건너뛰기
        if (Object.keys(this.sectionElements).length === 0) {
            return;
        }
        
        var scrollY = window.scrollY || window.pageYOffset;
        var viewportHeight = window.innerHeight;
        var activeIndex = 0;
        var maxVisibleArea = 0;
        
        // 각 섹션이 화면에 보이는 영역 계산
        Object.keys(this.sectionElements).forEach(function(key) {
            var section = this.sectionElements[key];
            if (section) {
                var rect = section.getBoundingClientRect();
                var sectionTop = rect.top;
                var sectionBottom = rect.bottom;
                
                var visibleTop = Math.max(0, sectionTop);
                var visibleBottom = Math.min(viewportHeight, sectionBottom);
                var visibleArea = Math.max(0, visibleBottom - visibleTop);
                
                var adjustedTop = sectionTop + this.tabBarHeight;
                if (adjustedTop <= this.tabBarHeight + 50 && visibleArea > maxVisibleArea) {
                    maxVisibleArea = visibleArea;
                    activeIndex = parseInt(key);
                }
            }
        }.bind(this));
        
        // 가장 많이 보이는 섹션 찾기
        var bestMatch = 0;
        var bestScore = -1;
        
        Object.keys(this.sectionElements).forEach(function(key) {
            var section = this.sectionElements[key];
            if (section) {
                var rect = section.getBoundingClientRect();
                var sectionTop = rect.top;
                var sectionBottom = rect.bottom;
                
                if (sectionTop <= this.tabBarHeight + 100 && sectionBottom > this.tabBarHeight) {
                    var visibleTop = Math.max(this.tabBarHeight, sectionTop);
                    var visibleBottom = Math.min(viewportHeight, sectionBottom);
                    var visibleArea = Math.max(0, visibleBottom - visibleTop);
                    
                    if (visibleArea > bestScore) {
                        bestScore = visibleArea;
                        bestMatch = parseInt(key);
                    }
                }
            }
        }.bind(this));
        
        if (bestScore > 0) {
            activeIndex = bestMatch;
        }
        
        // 탭 활성화 상태 업데이트
        this.tabs.forEach(function(tab, index) {
            var textButton = tab.querySelector('button');
            var tabActiveBar = tab.querySelector('.tab-active-bar');
            
            if (tabActiveBar) {
                tabActiveBar.remove();
            }
            
            if (textButton) {
                if (index === activeIndex) {
                    tab.setAttribute('data-active', 'true');
                    textButton.classList.remove('text-[#ABB2BE]', 'font-normal');
                    textButton.classList.add('text-[#1B1E23]', 'font-bold');
                } else {
                    tab.setAttribute('data-active', 'false');
                    textButton.classList.remove('text-[#1B1E23]', 'font-bold');
                    textButton.classList.add('text-[#ABB2BE]', 'font-normal');
                }
            }
        });
        
        // 활성화 바 위치 업데이트
        if (!this.isScrolling || this.clickedTabIndex === null) {
            this.updateActiveBarPosition(activeIndex);
        }
    };
    
    TabScrollHandler.prototype.handleTabClick = function(tab, index) {
        // 클릭한 탭 인덱스 저장
        this.clickedTabIndex = index;
        
        // 활성화 바 위치 즉시 업데이트
        this.updateActiveBarPosition(index);
        
        // 탭 활성화 상태 즉시 업데이트
        this.tabs.forEach(function(t, i) {
            var textButton = t.querySelector('button');
            if (textButton) {
                if (i === index) {
                    t.setAttribute('data-active', 'true');
                    textButton.classList.remove('text-[#ABB2BE]', 'font-normal');
                    textButton.classList.add('text-[#1B1E23]', 'font-bold');
                } else {
                    t.setAttribute('data-active', 'false');
                    textButton.classList.remove('text-[#1B1E23]', 'font-bold');
                    textButton.classList.add('text-[#ABB2BE]', 'font-normal');
                }
            }
        });
        
        // sections가 있으면 스크롤 기능 사용
        var section = this.sectionElements[index];
        if (section) {
            this.isScrolling = true;
            var sectionTop = section.offsetTop - this.tabBarHeight;
            
            // 기존 디바운스 타이머 취소
            if (this.scrollDebounceTimer) {
                clearTimeout(this.scrollDebounceTimer);
            }
            
            window.scrollTo({
                top: sectionTop,
                behavior: 'smooth'
            });
            
            // 스크롤 완료 감지
            var self = this;
            var checkScrollComplete = function() {
                var currentScrollTop = window.scrollY || window.pageYOffset;
                
                if (Math.abs(currentScrollTop - self.lastScrollTop) < 1) {
                    self.isScrolling = false;
                    self.clickedTabIndex = null;
                    self.lastScrollTop = currentScrollTop;
                    self.updateActiveTab();
                } else {
                    self.lastScrollTop = currentScrollTop;
                    self.scrollDebounceTimer = setTimeout(checkScrollComplete, 100);
                }
            };
            
            setTimeout(function() {
                self.lastScrollTop = window.scrollY || window.pageYOffset;
                self.scrollDebounceTimer = setTimeout(checkScrollComplete, 150);
            }, 500);
        } else {
            // sections가 없으면 스크롤 없이 탭 활성화만 처리
            this.clickedTabIndex = null;
        }
    };
    
    TabScrollHandler.prototype.initEventListeners = function() {
        var self = this;
        
        // 탭 클릭 이벤트 (button 요소에 직접 등록)
        this.tabs.forEach(function(tab, index) {
            var button = tab.querySelector('button');
            if (button) {
                button.addEventListener('click', function(e) {
                    e.preventDefault();
                    e.stopPropagation();
                    self.handleTabClick(tab, index);
                });
            } else {
                // button이 없으면 tab-item에 등록
                tab.addEventListener('click', function(e) {
                    e.preventDefault();
                    self.handleTabClick(tab, index);
                });
            }
        });
        
        // 스크롤 이벤트 (sections가 있을 때만)
        if (Object.keys(this.sectionElements).length > 0) {
            var ticking = false;
            window.addEventListener('scroll', function() {
                if (self.isScrolling && self.clickedTabIndex !== null) {
                    return;
                }
                
                if (!ticking) {
                    window.requestAnimationFrame(function() {
                        self.updateActiveTab();
                        ticking = false;
                    });
                    ticking = true;
                }
            });
        }
        
        // 리사이즈 이벤트
        var resizeTicking = false;
        window.addEventListener('resize', function() {
            if (!resizeTicking) {
                window.requestAnimationFrame(function() {
                    var currentActiveIndex = 0;
                    self.tabs.forEach(function(tab, index) {
                        if (tab.getAttribute('data-active') === 'true') {
                            currentActiveIndex = index;
                        }
                    });
                    self.updateActiveBarPosition(currentActiveIndex);
                    resizeTicking = false;
                });
                resizeTicking = true;
            }
        });
    };
    
    // 전역으로 노출
    window.TabScrollHandler = TabScrollHandler;
    
})(window);
</script>


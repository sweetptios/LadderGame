# LadderGame
Let'Swift 2019 워크숍 실습

간단한 사다리게임 화면을 구현하면서 clean architecture를 적용해보는 실습이었다.

clean architecture를 기반으로 여러 디자인 패턴을 적용해봤다.

## 4개의 프로젝트
clean architecture를 적용하여 entity layer, use case layer 코드를 공용할 수 있었다.
1. LadderGameLibrary
    entity layer, use case layer  코드 구현
2. LadderGame
    macOS 기반
    entity layer 사용
    함수형 프로그래밍
3. LadderGameiOS
    iOS 기반
    UIKit 사용
    entity layer, use case layer 사용
    viper 적용 
    > viper에서 Clean Architecture를 따르지 않은 부분을 개선했다 (컴포넌트 레벨에 DIP 적용)
4. LadderGameSwiftUI
   iOS 기반
   SwiftUI 와 Combine 사용
   entity layer, use case layer 사용
   clean architecture + MVVM  적용

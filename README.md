
# iAddThree

## Overview
A small math app based on a cognitive exercise developer by clinical psychologist Daniel Kahneman.

Much like the cognitive exercise, iAddThree helps users train their working memory in just a few minutes. While the game used in the clinical setting only focused on ADDING 3 to a serious of four numbers, iAddThree expands on the game with various modes (Only Add and Subtract at the moment). And to provide a bit of a challenge, as the user progresses through the game, the amount of time they have to complete each level decreases.

## Rules of the Game
Pending on the mode, the user is presented with four random numbers. It is their job to add 3 to each number starting from the left (or subtract 3 in subtract mode).

Following the rules set for by Kahneman, rather than using double digits, the user is required to 'wrap around' an imaginary number line when necessary.

For example:
In reality, 8 + 3 = 11
In iAddThree, 8 + 3 = 1

In the number line below, if you start at 8 and move 3 places to the right, you end up at 1.

7 -> 8 -> 9 -> 0 -> 1 -> 2

Alternatively, in 'Subtract' mode, you would reverse the direction. So if presented with 1, you would move 3 places to the left, ending up at 8.

## Game Modes
- **Add Mode**: Add three to each number.
- **Subtract Mode**: Subtract three from each number.
- **Hybrid Mode**: A mix of addition and subtraction tasks.

## Architecture
The app is divided into two modules:
- **iAddThreeCore**: Hosts all the game logic, allowing efficient unit testing on Mac. This module includes classes like `GameManager` and `GameStorageManager` for handling game states and data management.
- **iAddThree Main Module**: Manages UI, dependencies, and integrates GoogleMobileAds, StoreKit2, and `iAddThreeClassicKit` XCFramework for gameplay. It features SwiftUI views like the `ProUpgradeView` for in-app purchases and settings management.

## Prerequisites
- Xcode 15.0 or later
- iOS 17 or later

## License
This app is available under the MIT license. See the [LICENSE](LICENSE) file for more information.


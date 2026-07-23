# Dice Roller 🎲🎲

A simple native iPhone app (SwiftUI) that rolls **two dice**.

## Features

- Two dice rendered as classic pip faces (drawn in code — no image assets needed)
- **Roll** button with a tumbling roll animation
- **Shake the phone** to roll (uses the accelerometer)
- Running **total** of both dice, with an animated number transition
- Haptic feedback on roll and on the result settling
- Green "felt table" background

## Requirements

- Xcode 15 or newer
- iOS 16.0+ (iPhone or iPad; runs great in the Simulator)

## How to run

1. Open `DiceRoller.xcodeproj` in Xcode.
2. Pick an iPhone simulator (e.g. *iPhone 15*) from the scheme selector at the top.
3. Press **▶ Run** (⌘R).
4. Tap **Roll** — or, on a physical device, shake the phone.
   In the Simulator you can trigger a shake with **Device ▸ Shake** (⌃⌘Z).

## Project layout

```
DiceRoller/
├── DiceRoller.xcodeproj        # Xcode project
└── DiceRoller/
    ├── DiceRollerApp.swift      # App entry point
    ├── ContentView.swift        # Main screen: dice, total, roll button
    ├── DieView.swift            # Draws a single die face from its value
    ├── ShakeDetector.swift      # Shake-to-roll gesture support
    └── Assets.xcassets          # App icon / accent color placeholders
```

## Notes

The app icon is an empty placeholder — add a 1024×1024 image to
`Assets.xcassets/AppIcon.appiconset` in Xcode if you want a custom icon.

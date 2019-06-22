# Hey it's a project

## Why for

I want to give an example of regular SwiftUI architecture right alongside other architectures for the same application, so people can use it as a guide to migrating from one architecture to the next, see the costs, and decide which path will benefit them most in the long term.

## OK then how

First build a thing like this, to show a codebase with long term support that gets opted into all the best stuff from here on out.

- Regular App 2.0: SwiftUI BindableObjects Combine

And then backport it to this, to show how we can do something similar now.

- Community Goodness Sampler Platter: UIKit MVVM Rx

And then backport it to this, to show differences needed to upgrade from one architecture to the next or all the way to SwiftUI.

- Regular App 1.0 AKA Orange Sonic: UIKit MVC

## What is it though

We're going to need an app that can show meaningful implementation differences between these three architectures. So we need to cover:

- Multiple screens
- Table views
- Hierarchical navigation
- Modal presentation and dismissal
- Something UIKit can do that SwiftUI can't do
- Something SwiftUI can do that UIKit can't do
- At least two backing data services
- NSNotifications
- Complex data flow
- Deep links
- Dark mode
- Dynamic Type
- Complete VoiceOver support
- Accessibility elements aggregating text and actions
- Contextual menus

I'm not sure what to put in there, so in any case, I need a theme to come up with something. How about magnets? Magnets are cool. How do they work? That's excellent. Let's revisit the checklist:

- Multiple screens
- Table views
- Hierarchical navigation
    - Magnetic materials
    - List and detail
    - Detail: material properties
    - Action: favoriting
- Modal presentation and dismissal
- Something UIKit can do that SwiftUI can't do
    - Play with magnets in SceneKit
    - Include magnets and wooden walls
    - Use fused device motion to contribute force
    - Use a button to turn on and off electromagnets
    - Touch to pull an object
    - Present it modally
    - Dismiss with swipe from top or Close
- Something SwiftUI can do that UIKit can't do
    - A button with the image on top of the text
    - Lines of force as paths
    - Radar chart on detail screen
- At least two backing data services
    - CMMotionManager for raw 3-axis magnetometer data in microteslas
    - CMMotionManager for fused device motion
    - Definition of materials in a format on disk
    - Favorites backed by user defaults
- NSNotifications
    - Use application state changes to pause and unpause the scene
- Complex data flow
    - Favorite from anywhere and see it everywhere
- Deep links
    - Maybe I can supply a few from the readme
    - Route to each screen
- Dark mode
- Dynamic Type
- Complete VoiceOver support
    - OK how do I do this with a 3D magnet playground?
    - I can fix the board to the screen and flatten it
    - I can use haptics on object collisions
    - I can use dragging sounds on object motion and collision
    - I can use device motion rather than direct interaction
- Accessibility elements aggregating text and actions
    - Wrap the materials' text and favorite buttons in an element
- Contextual menus
    - Long press a magnetic material list item to favorite or unfavorite
    - Long press the play scene to reset it


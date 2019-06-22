# Magnets

## Goal

I want to give an example of regular SwiftUI architecture right alongside other architectures for the same application, so people can use it as a guide to migrating from one architecture to the next, see the costs, and decide which path will benefit them most in the long term.

## Approach

First I'll build an app with SwiftUI providing presentation and Combine providing data through BindableObjects, to show a codebase with long term first-party support that is likely to benefit the most from further platform improvements. This is a great architecture for a brand new app, but it will require iOS 13 at a minimum so isn't necessarily a great fit for existing apps right away.

Then, to show an implementation that balances iOS 12 support with similarity to Apple's new architecture, I'll backport views to UIKit, BindableObjects to MVVM-style view models, and Combine Publishers to RxSwift Observables. Depending on your app's present day starting point, this might be a good architecture to adopt until you can drop iOS 12 support. A diff between these two implementations should clarify what you have to do to migrate to SwiftUI and Combine at that time.

Finally, since some of us preferred to stick with regular Apple MVC, I'll backport to our UIKit / MVC baseline first-party architecture, "massive" view controllers and all. Again, diffing this implementation with either of the other two should show what it takes to migrate between them, and I hope that helps you make the best long term architecture decision for your case.

## What's the app?

We're going to need an app that can show meaningful implementation differences, including strengths and weaknesses, between these three architectures. So we need to cover:

- Multiple screens
- Table views
- Hierarchical navigation
- Modal presentation and dismissal
- Something view related you have to reach outside SwiftUI to accomplish
- Something SwiftUI can do that UIKit can't do as easily
- At least two backing data services
- NSNotifications
- Complex data flow
- Deep links
- Dark mode
- Dynamic Type
- Complete VoiceOver support
- Accessibility elements aggregating text and actions
- Contextual menus

I'm not sure what to put in there, so in any case, I need a theme to come up with something. [Here I looked around my living room and kitchen and noticed refrigerator magnets.] How about magnets? Magnets are cool. How do they work? Let's expand:

- Multiple screens, table views, hierarchical navigation
    - Magnetic materials
    - List and detail
    - Detail: material properties
    - Common action: favoriting
    - List: Show all or favorites
- Modal presentation and dismissal, something view related you have to reach outside SwiftUI to accomplish
    - Play with magnets in SceneKit
    - Include magnets and wooden walls
    - Use fused device motion to contribute force
    - Use a button to turn on and off electromagnets
    - Present it modally
    - Dismiss with swipe from top or close button
- Something SwiftUI can do that UIKit can't do as easily
    - A button with the image on top of the text
    - Lines of force as paths without involving Core Animation
    - Radar chart on detail screen
- At least two backing data services
    - CMMotionManager for raw 3-axis magnetometer data in microteslas
    - CMMotionManager for fused device motion
    - Definition of materials in a format on disk
    - Favorites backed by user defaults
- NSNotifications
    - Expose these through Publishers / Observables to show "combined" asynchronous pattern
    - Use application state changes to pause and unpause the play scene
- Complex data flow
    - Data services as injected dependencies
    - Favorite from anywhere and see it everywhere
- Deep links
    - Maybe I can supply a few from the readme?
    - Route to each screen
- Dark mode, Dynamic Type
    - Table stakes
    - Do it everywhere and let's see what it takes
- Complete VoiceOver support
    - OK, how do I do this with a 3D magnet playground?
    - I can fix the board to the screen and flatten it
    - I can use haptics on object collisions
    - I can maybe use light haptics when objects separate
    - I can use dragging sounds on object motion and collision
    - I can use device motion rather than direct interaction
    - I can use 3D sound with stereo speakers in landscape orientation
    - That will be a challenge. Let's see if I learn something.
- Accessibility elements aggregating text and actions
    - Wrap the materials' text and favorite buttons in an element
- Contextual menus
    - Long press a magnetic material list item to favorite or unfavorite
    - Long press the play scene to reset it


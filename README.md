# Primitives

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

Let's expand:

- Multiple screens, table views, hierarchical navigation
    - A catalog of items: SceneKit primitive shapes
    - List and detail
    - Detail: item properties
    - Common action: favoriting, sharing
    - List: Show all or favorites
- Modal presentation and dismissal
    - Material preview with each object
    - Dismiss with swipe from top or close button
- Something view related you have to reach outside SwiftUI to accomplish
    - Use SceneKit on item detail screens
    - Spotlight from above
    - Ambient light determined by light / dark mode
- Something SwiftUI can do that UIKit can't do as easily
    - Animations within a screen
    - A button with the image on top of the text
- At least two backing data services, NSNotifications, complex data flow
    - Definition of item catalog in a format on disk
    - Favorites backed by user defaults
    - Favorite from anywhere and see it everywhere
    - Use application state changes to pause and unpause the play scene
    - Use proximity sensor state changes to dim the spotlight
    - Data services as injected dependencies
    - Expose these through Publishers / Observables to show "combined" asynchronous pattern
- Deep links
    - Maybe I can supply a few from the readme?
    - Route to each screen
- Dark mode, Dynamic Type
    - Table stakes
    - Do it everywhere and let's see what it takes
    - Contribute to lighting parameters in scene
- Complete VoiceOver support
    - Let's 
- Accessibility elements aggregating text and actions
    - Wrap the catalog items' text and favorite buttons in an element
- Contextual menus
    - Long press a catalog item to favorite/unfavorite or preview with materials


#  Youtine

Habit tracker/routine builder app. The name comes from a play on
words of 'You' and 'Routine', reminding the user that these Routines
are to reinforce positive habits that benefit you.

Takes idea of simple todo app but incoporates habit
building tips/suggestions from Atomic Habits by James Clear.

### Data Model (evolving)
```Swift
import SwiftData
import SwiftUI

@Model
class Youtine: Identifiable {
    // a unique identifier for a 'Youtine'
    var id: UUID
    
    // when this routine should be started
    var start: String
    var days: [String]
    var title: String
    var todos: [Todo]
    
    // Limited offering for now, but would like to incoporate
    // themeing/customization for tracker
    var borderColor: String
    
    init(
        start: String,
        days: [String],
        title: String,
        todos: [Todo],
        borderColor: Color
    ) {
        self.id = UUID()
        self.start = start
        self.days = days
        self.title = title
        self.todos = todos
        self.borderColor = borderColor.description
    }
}

@Model
class Todo: Identifiable {
    var id: UUID
    var label: String
    var desc: String
    var completed: Bool
    
    init(label: String, desc: String, completed: Bool = false) {
        self.id = UUID()
        self.label = label
        self.desc = desc
        self.completed = completed
    }
}
```

### Swift Data
Swift Data is a modern framework developed by Apple to phase out Core Data. Core Data
is still widely used, however Swift Data reduces overhead with its @Model declarations and
integrates nicely with SwiftUI. I am using this [article](https://www.hackingwithswift.com/articles/263/build-your-first-app-with-swiftui-and-swiftdata) currently as reference.

                                                          
### Todos
[X] Build out display for empty container view (no local data persisted/previous routines saved)
[X] Complete refactor of View Hierarchy and respective subview hierarchy
[X] Finish building out Routine creation screen
-  [X] Tidy up navigation from and to HabitInitView
-  [X] Create cancel button to discard currently created Routine
-  [X] Create done button to complete current Routine and save to local storage

[X] Finish building out Edit creation screen
-  [X] Create ManageRoutineView screen that conditionally intializes state variables and serves said state to EditRoutineView

[X] Explore Swift Data integration

[ ] Create env vars and functions to attach to view hierarchy to execute Swift Data operations
[ ] Create unit tests

[ ] Explore cloud based storage solution with firebase to optimize local memory usage


### Pragma Marks
- // MARK: NAVIGATE TO {PAGE}
- // MARK: SET selectedCellIndex {nil/index}

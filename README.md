# 🏠 rumii

### Rumii is a household management mobile app made to help keep things running smoothly at home.

![image 26 (1)](https://github.com/Jdd2020/rumii/assets/92334262/d3bccbef-51e2-4f67-b576-689d9ffe71d7)

## How to Execute Rumii

1. Ensure Flutter, Dart, and Visual Studio Code are properly installed on your system.

2. Clone a copy of this repository to your local device to the location of your choosing.

3. Open Visual Studio code, and cd to the location of the root directory (rumii).

4. Open a new terminal, and run the "flutter run" command. This will resolve any dependency issues. You will be prompted to choose a web browser at this time (your system browser is recommended, e.g. press "1" for Windows on a Windows machine).

7. Rumii should boot up momentarily! :)
   -  Note: Rumii has a responsive interface suitable to different screen sizes, however we recommend condensing your browser to a mobile size for the best User Experience! (e.g. 25-30% as wide as your computer screen)

## How to Perform Key Tasks

### 1. Logging In
#### _A simple login page to get new and existing users into their Rumii account._

+ **Sample Login Details** → Please feel free to use these sample login credentials if you would like: 

    + **Username:** Henry
    + **Password:** KP4EVA

Or, feel free to create a new account using the house key "DSBU781" to join our sample household!

+ **Typical Login Sequence** → Enter your username and password and select "Submit" when fields are complete. Valid credentials will direct you to the Dashboard landing page.

+ **New User Registration** → Click "Register Now" below the pink Submit button and enter your information into the required fields. Then, you will be asked to either join an existing household (given you have a house key to do so), or create a new household. Select the choice that fits your use case and follow the on-screen instructions.

After joining or creating a household, you will be routed to the Dashboard langing page! 

----

### 2. Checking What's New with the Dashboard
#### _A summary of the latest updates from each Rumii module (Unfinished Chores, Store Needs, and Upcoming Events)._
+ **Overview** → Each module header is accompanied by the recent items that are most critical for the logged-in user to notice or complete. 

+ **User Panel** → The user panel features a log out button, a module header, the user's profile photo, a welcome message, the house key of the currently logged-in user, and an Edit Household button. 

+ **Edit Household** → The Edit Household view allows users to see everyone in their household group and remove any members from the household who may have moved out or joined by mistake. There is also an Add Household Member button where users can view their house key or copy an invite link to share with new roommates.

+ **Viewing/Editing Items At a Glance** → Users may easily view an item directly from the Dashboard (e.g. clicking the "Wash the Dishes" card to view the chore details). From there, they can choose the Edit button in the upper left to make any desired changes.

+ **Navigation** → The user can navigate to the other modules using the arrows next to each respective module header. The bottom navigation bar also follows the user across all of the app's main views. It can be used to travel from one module to another with ease!

----

### 3. Utilizing the Chore List 
#### _An organizational system to keep your shared living space spick and span!_
+ **Overview** → This chore list is organized by household member and features priority stars which can be toggled on/off to emphasize importance. Due dates give users clear deadlines so they can hold themselves accountable for their household responsibilities.

+ **Mark a Chore as Complete** → Click the check box next to a chore to mark it as complete! This memory is preserved when a user leaves the page. 

+ **Adding a New Chore** → Choose the "+ New" button from the top right of the main chore list page. Complete all fields and choose "Save" when done to add the chore to the choreDB.json database.

+ **Viewing a Chore** → From the main Chore View, tap on any chore (one of yours or that of a household member) to see the details that were entered upon creation of the chore.

+ **Editing a Chore** → From the View Chore page, click the Edit button in the top right corner of the page to enter Edit Mode. Fields are mutable here, and any changes made upon clicking "Save" will be applied and reflected in the choreDB.json database! A chore may also be deleted within this view.

+ **Prioritize a Chore** → Click the Star icon next to a chore to mark it as a priority. A filled-in star means the chore is prioritized! This memory is preserved when the user leaves the page.

----
### 4. Utilizing the Shopping List 
#### _A collaborative shopping list to help each other remember what to grab at the store!_
+ **Overview** → This shopping list is organized by household member and features icons which organize items into categories... making shopping trips a breeze! 

+ **Mark an Item as Purchased** → Click the check box next to an item to mark it as purchased/acquired! This memory is preserved when a user leaves the page.

+ **Adding a New Item** → Choose the "+ New" button from the top right of the main shopping list page. Complete all fields and choose "Save" when done to add the chore to the shopDB.json database.

+ **Viewing an Item** → From the main Shopping List View, tap on any item (one of yours or that of a household member) to see the details that were entered upon creation of the item.

+ **Editing an Item** → From the View Item page, click the Edit button in the top right corner of the page to enter Edit Mode. Fields are mutable here, and any changes made upon clicking "Save" will be applied and reflected in the shopDB.json database! An item may also be deleted within this view.

----

### 5. Utilizing the Calendar
#### _A collective tracker of the events everyone needs to know about—rent payments, trash day, roommate meetings, parties, and so on!_
+ **Overview** → This calendar provides a monthly overview of the events to come including a list of "Upcoming Events," the most imminent events to be aware of. Pink dots on calendar dates specify that at least one event occurs on that date. 

+ **Adding a New Event** → Choose the "+ New" button from the top right of the main calendar page. Complete all fields and choose "Save" when done to add the chore to the eventDB.json database.

+ **Viewing Event Details** → From the main Calendar View, the user can click on a specific day to see its events in more detail. From this list view, the user can tap a specific event to see all of the details that were entered upon its creation.

+ **Editing an Event** → From the View Event page, click the Edit button in the top right corner of the page to enter Edit Mode. Fields are mutable here, and any changes made upon clicking "Save" will be applied and reflected in the eventDB.json database! An event may also be deleted within this view.


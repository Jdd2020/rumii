# 🏠 rumii

### Rumii is a household management mobile app made to help keep things running smoothly at home.

![image 26 (1)](https://github.com/Jdd2020/rumii/assets/92334262/d3bccbef-51e2-4f67-b576-689d9ffe71d7)

## How to Execute Rumii

1. Ensure Flutter, Dart, and Visual Studio Code are properly installed on your system.

2. Clone a copy of this repository to your local device to the location of your choosing.

3. Open Visual Studio code, and cd to the location of the root directory (rumii-main).

4. Open a new terminal, and run the "flutter run" command. This will resolve any dependency issues. You will be prompted to choose a web browser at this time (your system browser is recommended).

7. The first launch may take longer than usual, but Rumii should boot up momentarily! :)

## How to Perform Key Tasks

### 1. Logging In
#### _A simple login page to get new and existing users into their Rumii account._

+ **Sample Login Details** → Please feel free to use these sample login credentials if you would like:

    + **Username:** Henry
    + **Password:** KP4EVA

+ **Typical Login Sequence** → Enter your username and password and select "Submit" when fields are complete. Valid credentials will direct you to the Dashboard landing page.

+ **New User Registration** → Click "Register Now" below the pink Submit button and enter your information into the required fields. Be sure to submit & you will be routed to the Dashboard langing page! (Currently, the new user information _will_ be written to the user database, but we have not yet implemented the unique memory for each user. Hence, you will still see Henry's household data upon logging in even as a different user.)

----

### 2. Checking What's New with the Dashboard
#### _A summary of the latest updates from each Rumii module (Unfinished Chores, Store Needs, and Upcoming Events)._
+ **Overview** → Each module header is accompanies by the three most recent items that are most critical for the logged-in user to complete. The user may navigate to the other modules using the arrows next to each respective module header. They may also view an item directly from the Dashboard (e.g. clicking "Wash the Dishes" to view the chore details).

+ **Bottom Navigation Panel** → This bottom navigation bar follows the user across all of the app's main views. It can be used to travel from one module to another with ease!

----

### 3. Utilizing the Chore List 
#### _An organizational system to keep your living space spick and span!_
+ **Adding a New Chore** → Choose the "+ New" button from the top right of the main chore list page. Complete all fields and choose "Save" when done to add the chore to the database.

+ **Viewing a Chore** → From the main Chore View, tap on any chore (one of yours or that of a household member) to see the details that were entered upon creation of the chore.

+ **Editing a Chore** → From the View Chore page, click the pencil icon in the top right corner of the Rumii App Bar to enter Edit Mode. Fields are mutable here, but these changes will not yet appear in the database upon saving (this is a work in progress!).

+ **Prioritize a Chore** → Click the Star icon next to a chore to mark it as a priority. A filled-in star means the chore is prioritized.

+ **Mark a Chore as Complete** → Click the check box next to a chore to mark it as complete!

# Software Development Plan - Attendance Log

## Statement of Purpose

In a world where plastic straws are evil and you now have too *cut* up your lunch with wooden sporks, it is about time we start to take a look around our offices, classrooms & kitchens (I'm looking at you paper plates!) and seeing if we can find digital solutions to replace these manual tasks, think of the forests - And not to mention all the unnecessary admin work to duplicate this into an electronic system.

With my eco-warrior cloak & digitizing stare, I look around the classroom, there's a daily task which both annoys me & confuses me, the attendance log is still on paper!

The solution is easy, a program must be written which will allow students to log their attendance digitally, that will allow the staff to view each students attendance and check the frequency on which they have been attending class.

## How will this change the everyday lives of students & teachers?

Each day as students attend class, they will be able too use their student ID too login to their systems & mark themselves as attended.

A student will be able to check their attendance & retrieve statistics about how often they have attended their classes.

As all students are now fellow eco-warriors, they will have this warm fuzzy feeling each day knowing that after 6 months, they have potentially saved a tree (branch)

Admin/Teachers will be able to monitor attendance, having the ability to change days, time & add/remove students from the course. While they may still be climate change deniers, they won't be able to deny how much easier a system, that requires them to do less work is!

Admins will be able to edit the default config, advising what days are included in the semester and remove any public holidays.

This will all be published to a LOCAL or REMOTE database depending on the configuration file.

## Features

These features are split between the admin users (Teachers) and the Students. While Students may have access to some features, such as retrieving statistics in regards to their attendance, they will only be able to see this information for themselves.

### Teacher/Admin

#### Add New User / Remove User

This will allow the creation of new users, you will be required to supply the following information:
* Name
* Role Student/Teacher

If Student:
* Student ID
* Student Email

If Teacher:

* Username
* Email Address

A teacher will be able to disable a student & remove all students data.

Upon first login, the user will be required to set a password for future interactions.

#### Show Statistics for Individual Students and All students

Those with an admin role will be able to display usage statistics for each student, or for all students at once.

These statistics will include:
 
 * Days attended
 * Days missed
 * Attendance Percentage
 
 #### Force Sign-in/Modify Current Sign-ins 
 
 A teacher will be able to backdate previous sign-ins, along with changing existing ones if any errors are found.
 They will also be able too approve any outstanding sign-ins from students that require a manual authorisation.
 

### Students 

#### Sign In/Out with Student ID

A student will be able to easily sign in/out based on todays date/time and a simple action after confirming their password.

A student can overwrite the date/time but these changes won't take effect until a teacher has approved.

#### Show statistics for own student ID

These statistics will include:
 
 * Days attended
 * Days missed
 * Attendance Percentage
 
 A student will only be able to view their own statistics.
 
#### Save to database - SQlite (Local)

In order for changes to be persistent and the same over multiple machines, we would be utilizing a remote database.

For the purpose of this example, we won't be pushing data to a remote database, but will be storing in a local database saved on your local machine.
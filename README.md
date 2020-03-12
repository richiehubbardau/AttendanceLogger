R3	Provide full attribution to referenced sources (where applicable).	 

R4	Provide a link to your source control repository	 
 	Design a Software Development Plan for a terminal application. The following requirements provide details of what needs to be included in this plan,	

R7	Develop an outline of the user interaction and experience for the application.

Your outline must include:
- how the user will find out how to interact with / use each feature
- how the user will interact with / use each feature
- how errors will be handled by the application and displayed to the user	
 
R8	Develop a diagram which describes the control flow of your application. Your diagram must:
- show the workflow/logic and/or integration of the features in your application for each feature.
- utilise a recognised format or set of conventions for a control flow diagram, such as UML.	
 
R9	Develop an implementation plan which:
- outlines how each feature will be implemented and a checklist of tasks for each feature
- prioritise the implementation of different features, or checklist items within a feature
- provide a deadline, duration or other time indicator for each feature or checklist/checklist-item

Utilise a suitable project management platform to track this implementation plan

> Your checklists for each feature should have at least 5 items.	 
R10	Design help documentation which includes a set of instructions which accurately describe how to use and install the application.
# Attendance Logger! Useful Application to record and retrieve students class attendance!

To use this software please enter the following commands into your terminal.

Nb. You must have Ruby installed before attempting to run this application.

    git clone https://github.com/richiehubbardau/AttendanceLogger.git
    ruby src/main.rb

On first run, application will create a new database and a default user: admin/password

Once logged in, you will be guided to the different sections, you must at first login as a teacher to be able to create students.

A local database will be created in the root directory called database.db

# R5 Software Development Plan - Attendance Log

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

## R6 Features

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
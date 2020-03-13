echo "Welcome to Attendance Logger Installer!"
echo "Lets download and install this application now"
git clone "https://github.com/richiehubbardau/AttendanceLogger.git"
cd AttendanceLogger/src
echo "Lets install the required gems & get this all up and running!"
bundle install
echo "All gems installed, running application for the first time now - in future please run ruby main.rb from src directory"
ruby main.rb
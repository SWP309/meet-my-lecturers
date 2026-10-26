# Meet My Lecturers

Web app for FPT University students to book consultation slots with lecturers. Lecturers publish free slots with a Google Meet link; students book them or send meeting requests; admins load timetables and users from Excel.

**Status:** Course project (SWP391), FPT University, 2023 — archived. Not deployed.

## My role

Team Lead and full-stack developer (Java Servlet/JSP). I built or did most of the work on:

- **Lecturer side:** the created-slots view with update, delete and hide, time validation and duplicate start/end checks; lecturer home and profile pages.
- **Student side:** the booking view (book and cancel slots), the student home page, lecturer search and free-slot search with pagination.
- **Requests and users:** the request list pages and the user list page.
- **Admin:** the admin page layout and dashboard queries (for example the top 3 students).
- **Shared:** the site header and most of the page styling; merging the team's branches into `mymain`.
- **2026 cleanup:** moved mail, database and Google OAuth credentials out of the code into environment variables.

## Team

Commits in this repository: [@hiep-tm](https://github.com/hiep-tm) (free-slot creation, block list), [@Let-cal](https://github.com/Let-cal), [@ToniRakkaen](https://github.com/ToniRakkaen) (Excel import, Google login, subjects, mail) and [@briantran2003](https://github.com/briantran2003) (meeting requests).

## Stack

Java 8, Servlet and JSP, JSTL, JDBC with SQL Server, JavaMail (Gmail SMTP), Apache POI (Excel import), Google OAuth 2.0 sign-in, Bootstrap, Apache Tomcat, NetBeans (Ant).

## Features

- Three roles: admin, lecturer, student. Sign in with email and password or with Google.
- **Lecturers** create free slots with a subject, time and Google Meet link (entered by hand), can email a list of students about a slot, edit, hide or delete slots, accept or decline requests, and check attendance.
- **Students** search lecturers and free slots, book or cancel a slot, send a meeting request and follow its status.
- **Admins** import students, subjects and timetables from Excel files, manage users, majors and a block list, view booked slots, and see a dashboard of students with the most requests, cancellations and absences.

## Configuration

Credentials are read from environment variables. `.env.example` lists them with empty values:

| Variable | Used for |
| --- | --- |
| `MML_MAIL_USER` | Gmail address that sends booking emails |
| `MML_MAIL_APP_PASSWORD` | Gmail app password for that address |
| `MML_DB_USER` | SQL Server login |
| `MML_DB_PASSWORD` | SQL Server password |
| `MML_GOOGLE_CLIENT_SECRET` | Client secret for "Login with Google" |

Set them in the environment of the Tomcat process (for example in Tomcat's `bin/setenv.bat` or `setenv.sh`). Never commit real values.

For "Login with Google", create your own OAuth client in Google Cloud and put its client ID in `src/java/sample/loginByGoogle/Constants.java`. The redirect URI there is `http://localhost:8080/meet-my-lecturers/LoginGoogleHandler`.

**Repository history:** in October 2026 the full Git history of this repository was rewritten to remove credentials and personal email addresses that had been committed in 2023. The SQL scripts now use placeholder addresses (`student01@example.edu` and so on). If you cloned the repository before that, delete the old clone.

## How to run

1. Install JDK 8 or newer, Apache Tomcat and NetBeans, and SQL Server on `localhost:1433`.
2. Run `MeetMyLecturer2_ver3.sql`. The script creates a database named `MeetMyLecturer2`, but `DBUtils.java` connects to `MeetMyLecturer3`: rename the database or change the name in `src/java/sample/utils/DBUtils.java`.
3. Add these jars to the project libraries (their paths in `nbproject/project.properties` point to the team's 2023 machines): `sqljdbc4`, `mail-1.4.7`, `poi-3.17`, `poi-ooxml-3.17`, `poi-ooxml-schemas-3.17`, `xmlbeans-2.6.0`, `commons-collections4-4.1`, `commons-fileupload-1.3`, `httpclient-4.5.5`, `httpcore-4.4.9`, `fluent-hc-4.5.5`, `gson-2.8.2`, `commons-logging-1.2`.
4. Set the environment variables above and run the project on Tomcat from NetBeans.

## Known limitations

- Library jars are not in the repository, and the build paths are machine-specific.
- The database name in the SQL script and in the code differ (see step 2).
- Google Meet links are typed in by the lecturer; the app does not call the Google Calendar or Meet APIs.
- No automated tests.

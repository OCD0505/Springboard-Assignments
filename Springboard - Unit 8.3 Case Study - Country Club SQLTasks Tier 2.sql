/* Welcome to the SQL mini project. You will carry out this project partly in
the PHPMyAdmin interface, and partly in Jupyter via a Python connection.

This is Tier 2 of the case study, which means that there'll be less guidance for you about how to setup
your local SQLite connection in PART 2 of the case study. This will make the case study more challenging for you: 
you might need to do some digging, aand revise the Working with Relational Databases in Python chapter in the previous resource.

Otherwise, the questions in the case study are exactly the same as with Tier 1. 

PART 1: PHPMyAdmin
You will complete questions 1-9 below in the PHPMyAdmin interface. 
Log in by pasting the following URL into your browser, and
using the following Username and Password:

URL: https://sql.springboard.com/
Username: student
Password: learn_sql@springboard

The data you need is in the "country_club" database. This database
contains 3 tables:
    i) the "Bookings" table,
    ii) the "Facilities" table, and
    iii) the "Members" table.

In this case study, you'll be asked a series of questions. You can
solve them using the platform, but for the final deliverable,
paste the code for each solution into this script, and upload it
to your GitHub.

Before starting with the questions, feel free to take your time,
exploring the data, and getting acquainted with the 3 tables. */


/* QUESTIONS 
/* Q1: Some of the facilities charge a fee to members, but some do not.
Write a SQL query to produce a list of the names of the facilities that do. */

Springboard PHPMyadmin Server/country_club/Facilities/		https://frankfletcher.co/springboard_phpmyadmin/index.php?route=/database/sql&db=country_club

   Showing rows 0 -  4 (5 total, Query took 0.0004 seconds.)


SELECT name AS Facility, membercost AS Fee
FROM Facilities 
WHERE membercost >0;


Facility	Fee	
Tennis Court 1	5.0	
Tennis Court 2	5.0	
Massage Room 1	9.9	
Massage Room 2	9.9	
Squash Court	3.5	


/* Q2: How many facilities do not charge a fee to members? */

Springboard PHPMyadmin Server/country_club/Facilities/		https://frankfletcher.co/springboard_phpmyadmin/index.php?route=/database/sql&db=country_club
Your SQL query has been executed successfully.

SELECT COUNT(name) AS 'Number of facilities that do not charge a fee.'
FROM Facilities 
WHERE membercost >0;

5	


/* Q3: Write an SQL query to show a list of facilities that charge a fee to members,
where the fee is less than 20% of the facility's monthly maintenance cost.
Return the facid, facility name, member cost, and monthly maintenance of the
facilities in question. */

Springboard PHPMyadmin Server/country_club/Facilities/		https://frankfletcher.co/springboard_phpmyadmin/index.php?route=/database/sql&db=country_club

   Showing rows 0 -  4 (5 total, Query took 0.0005 seconds.)


SELECT 
	facid AS Facility_ID, 
    name AS Facility, membercost AS Fee, 
    monthlymaintenance AS Monthly_Maintenance
FROM Facilities 
WHERE membercost >0 AND membercost < .20*monthlymaintenance;


Facility_ID	Facility	Fee	Monthly_Maintenance	
0	Tennis Court 1	5.0	200	
1	Tennis Court 2	5.0	200	
4	Massage Room 1	9.9	3000	
5	Massage Room 2	9.9	3000	
6	Squash Court	3.5	80	



/* Q4: Write an SQL query to retrieve the details of facilities with ID 1 and 5.
Try writing the query without using the OR operator. */


Springboard PHPMyadmin Server/country_club/Facilities/		https://frankfletcher.co/springboard_phpmyadmin/index.php?route=/database/sql&db=country_club

   Showing rows 0 -  1 (2 total, Query took 0.0004 seconds.)


SELECT *
FROM Facilities
WHERE facid IN (1,5);


facid	name	membercost	guestcost	initialoutlay	monthlymaintenance	expense_label	
1	Tennis Court 2	5.0	25.0	8000	200	expensive	
5	Massage Room 2	9.9	80.0	4000	3000	expensive	



/* Q5: Produce a list of facilities, with each labelled as
'cheap' or 'expensive', depending on if their monthly maintenance cost is
more than $100. Return the name and monthly maintenance of the facilities
in question. */

Springboard PHPMyadmin Server/country_club/Facilities/		https://frankfletcher.co/springboard_phpmyadmin/index.php?route=/database/sql&db=country_club

   Showing rows 0 -  8 (9 total, Query took 0.0003 seconds.)


SELECT  
    name AS Facility,
    monthlymaintenance AS Monthly_Maintenance,
    CASE WHEN monthlymaintenance > 100 THEN 'expensive'
    ELSE 'cheap' END AS Cost  
FROM Facilities;


Facility	Monthly_Maintenance	Cost	
Tennis Court 1	200	expensive	
Tennis Court 2	200	expensive	
Badminton Court	50	cheap	
Table Tennis	10	cheap	
Massage Room 1	3000	expensive	
Massage Room 2	3000	expensive	
Squash Court	80	cheap	
Snooker Table	15	cheap	
Pool Table	15	cheap	



/* Q6: You'd like to get the first and last name of the last member(s)
who signed up. Try not to use the LIMIT clause for your solution. */

Springboard PHPMyadmin Server/country_club/Members/		https://frankfletcher.co/springboard_phpmyadmin/index.php?route=/database/sql&db=country_club

   Showing rows 0 -  0 (1 total, Query took 0.0005 seconds.)


SELECT firstname, surname, joindate
FROM Members
	WHERE joindate 
	IN (SELECT MAX(joindate)
       	FROM Members);



Darren	Smith	2012-09-26 18:08:45	


/* Q7: Produce a list of all members who have used a tennis court.
Include in your output the name of the court, and the name of the member
formatted as a single column. Ensure no duplicate data, and order by
the member name. */

Springboard PHPMyadmin Server/country_club/Members/		https://frankfletcher.co/springboard_phpmyadmin/index.php?route=/table/sql&db=country_club&table=Members

   Showing rows 0 - 23 (24 total, Query took 0.0043 seconds.)


SELECT DISTINCT name AS Facility, CONCAT(firstname,' ',surname) AS Member 
FROM Members
LEFT JOIN Bookings
USING (memid) 
	LEFT JOIN Facilities
    USING (facid)
    WHERE facid = 0
ORDER BY Member;


Facility	Member   	
Tennis Court 1	Anne Baker	
Tennis Court 1	Burton Tracy	
Tennis Court 1	Charles Owen	
Tennis Court 1	David Farrell	
Tennis Court 1	David Jones	
Tennis Court 1	David Pinker	
Tennis Court 1	Douglas Jones	
Tennis Court 1	Erica Crumpet	
Tennis Court 1	Florence Bader	
Tennis Court 1	Gerald Butters	
Tennis Court 1	GUEST GUEST	
Tennis Court 1	Jack Smith	
Tennis Court 1	Janice Joplette	
Tennis Court 1	Jemima Farrell	
Tennis Court 1	Joan Coplin	
Tennis Court 1	John Hunt	
Tennis Court 1	Matthew Genting	
Tennis Court 1	Nancy Dare	
Tennis Court 1	Ponder Stibbons	
Tennis Court 1	Ramnaresh Sarwin	
Tennis Court 1	Tim Boothe	
Tennis Court 1	Tim Rownam	
Tennis Court 1	Timothy Baker	
Tennis Court 1	Tracy Smith	


/* Q8: Produce a list of bookings on the day of 2012-09-14 which
will cost the member (or guest) more than $30. Remember that guests have
different costs to members (the listed costs are per half-hour 'slot'), and
the guest user's ID is always 0. Include in your output the name of the
facility, the name of the member formatted as a single column, and the cost.
Order by descending cost, and do not use any subqueries. */

Springboard PHPMyadmin Server/country_club/Members/		https://frankfletcher.co/springboard_phpmyadmin/index.php?route=/table/sql&db=country_club&table=Members

   Showing rows 0 - 11 (12 total, Query took 0.0047 seconds.)


SELECT 
	name AS Facility, 
    CONCAT(firstname,' ',surname) AS Member, 
    CASE WHEN memid = 0 THEN guestcost*slots
    ELSE membercost*slots END AS Cost,
    starttime
FROM Members
	LEFT JOIN Bookings
	USING (memid) 
		LEFT JOIN Facilities
    	USING (facid)
    WHERE  DATE(starttime) = '2012-09-14' 
    AND (CASE WHEN memid = 0 THEN guestcost*slots
    ELSE membercost*slots END) > 30 
    ORDER BY Cost DESC;


Facility	Member	Cost   	starttime	
Massage Room 2	GUEST GUEST	320.0	2012-09-14 11:00:00	
Massage Room 1	GUEST GUEST	160.0	2012-09-14 09:00:00	
Massage Room 1	GUEST GUEST	160.0	2012-09-14 13:00:00	
Massage Room 1	GUEST GUEST	160.0	2012-09-14 16:00:00	
Tennis Court 2	GUEST GUEST	150.0	2012-09-14 17:00:00	
Tennis Court 1	GUEST GUEST	75.0	2012-09-14 16:00:00	
Tennis Court 1	GUEST GUEST	75.0	2012-09-14 19:00:00	
Tennis Court 2	GUEST GUEST	75.0	2012-09-14 14:00:00	
Squash Court	GUEST GUEST	70.0	2012-09-14 09:30:00	
Massage Room 1	Jemima Farrell	39.6	2012-09-14 14:00:00	
Squash Court	GUEST GUEST	35.0	2012-09-14 12:30:00	
Squash Court	GUEST GUEST	35.0	2012-09-14 15:00:00	

/* Q9: This time, produce the same result as in Q8, but using a subquery. */

Springboard PHPMyadmin Server/country_club/cost/		https://frankfletcher.co/springboard_phpmyadmin/index.php?route=/table/sql&db=country_club&table=Members

   Showing rows 0 - 11 (12 total, Query took 0.0049 seconds.) [Cost: 320.0... - 35.0...]


/*SELECT 	done.memid,
		done.name, 
		done.Member,
        done.Guest_cost AS Guest_Cost,
        done.Member_cost AS Member_Cost
FROM 
(SELECT 
    f.name, memberbooking.memid,
	CONCAT(memberbooking.firstname,' ',memberbooking.surname) AS Member,
    f.guestcost*memberbooking.slots AS Guest_cost, 
    f.membercost*memberbooking.slots AS Member_cost
FROM (SELECT m.memid, m.firstname, m.surname, b.facid, b.slots
      FROM Members AS m
      LEFT JOIN Bookings AS b
      ON m.memid = b.memid
      WHERE DATE(b.starttime) = '2012-09-14') AS memberbooking
LEFT JOIN (SELECT facid, name, membercost, guestcost
           FROM Facilities) AS f
ON memberbooking.facid = f.facid) AS done
WHERE (done.Guest_cost > 30 or done.Member_cost>30); 
                */
                
SELECT 
    cost.name AS Facility,
    CONCAT(m.firstname, ' ', m.surname) AS Member,
    cost.Cost AS Cost
FROM
    (SELECT
        f.name, 
     	b.memid,
        b.facid,
        CASE WHEN [...]

Facility	Member	Cost   	
Massage Room 2	GUEST GUEST	320.0	
Massage Room 1	GUEST GUEST	160.0	
Massage Room 1	GUEST GUEST	160.0	
Massage Room 1	GUEST GUEST	160.0	
Tennis Court 2	GUEST GUEST	150.0	
Tennis Court 1	GUEST GUEST	75.0	
Tennis Court 1	GUEST GUEST	75.0	
Tennis Court 2	GUEST GUEST	75.0	
Squash Court	GUEST GUEST	70.0	
Massage Room 1	Jemima Farrell	39.6	
Squash Court	GUEST GUEST	35.0	
Squash Court	GUEST GUEST	35.0	


/* PART 2: SQLite

Export the country club data from PHPMyAdmin, and connect to a local SQLite instance from Jupyter notebook 
for the following questions.  

QUESTIONS:
/* Q10: Produce a list of facilities with a total revenue less than 1000.
The output of facility name and total revenue, sorted by revenue. Remember
that there's a different cost for guests and members! */

/* Q11: Produce a report of members and who recommended them in alphabetic surname,firstname order */


/* Q12: Find the facilities with their usage by member, but not guests */


/* Q13: Find the facilities usage by month, but not guests */


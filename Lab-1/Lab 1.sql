
use CSE_4B_407
select * FROM Artists

SELECT * FROM Albums

SELECT * FROM Songs
--PART   A

--1. Retrieve a unique genre of songs. 

SELECT DISTINCT Genre FROM Songs

--2. Find top 2 albums released before 2010.

SELECT TOP 2 * FROM Albums WHERE Release_year<2010

--3. Insert Data into the Songs Table. (1245, ‘Zaroor’, 2.55, ‘Feel good’, 1005) 

INSERT INTO Songs VALUES(1245,'Zaroor',2.55,'Feel good',1005)

--4. Change the Genre of the song ‘Zaroor’ to ‘Happy’ 

UPDATE Songs
SET Song_title ='HAPPY'
WHERE Song_title='Zaroor'

--5. Delete an Artist ‘Ed Sheeran’

delete from Artists where Artist_name='Ed Sheeran'

--6. Add a New Column for Rating in Songs Table. [Ratings decimal(3,2)] 

alter table Songs add Rating decimal(3,2)

--7. Retrieve songs whose title starts with 'S'.

select * from Songs where Song_title like 's%'

--8. Retrieve all songs whose title contains 'Everybody'.

select * from Songs where Song_title like '%Everybody%'


--9. Display Artist Name in Uppercase. 

select upper(Artist_name) from Artists  

--10. Find the Square Root of the Duration of a Song ‘Good Luck’ 

select sqrt(Duration) from Songs where Song_title='Good Luck'

--11. Find Current Date.

select getdate()

--12. Find the number of albums for each artist. 

select Artists.Artist_name, count(Albums.Album_id)
from Artists 
inner join 
Albums 
on Artists.Artist_id=Albums.Artist_id 
group by Artists.Artist_name

--13. Retrieve the Album_id which has more than 5 songs in it. 

select Album_id, count(Song_id) from Songs group by Album_id having count(Song_id)>5

--14. Retrieve all songs from the album 'Album1'. (using Subquery)

select Song_title from Songs where Album_id=(select Album_id from Albums where Album_title='Album1');

--15. Retrieve all albums name from the artist ‘Aparshakti Khurana’ (using Subquery) 

select Album_title from Albums where Artist_id=(select Artist_id from Artists where Artist_name='Aparshkti Khurana');

--16. Retrieve all the song titles with its album title.

select Songs.Song_title,Albums.Album_title 
from Songs
inner join Albums
on Songs.Album_id=Albums.Album_id

--17. Find all the songs which are released in 2020. 

select Albums.Release_year,Songs.Song_title from Songs
left outer join Albums
on Songs.Album_id=Albums.Album_id
where Albums.Release_year =2020

--18. Create a view called ‘Fav_Songs’ from the songs table having songs with song_id 101-105.

create view vw_Fav_songs as select Song_id from Songs where Song_id between 101 and 105;

--19. Update a song name to ‘Jannat’ of song having song_id 101 in Fav_Songs view. 

update view vw_Fav_Songs
set Song_title='Jannat'
where Song_id=101;


--20. Find all artists who have released an album in 2020.

select Artists.Artist_name,Albums.Release_year 
from Artists
left outer join Albums
on Artists.Artist_id=Albums.Artist_id
where Albums.Release_year=2020


--21. Retrieve all songs by Shreya Ghoshal and order them by duration. 
select Songs.Song_title,Songs.Duration,Artists.Artist_name from Songs 
inner join Artists
on Songs.Song_id=Artists.Artist_id
where Artists.Artist_name='Shreya Ghoshal'
order by Songs.Duration

--Part – B 
--22. Retrieve all song titles by artists who have more than one album. 

select Songs.Song_title from Songs
inner join Albums
on Songs.Album_id=Albums.Album_id join Artists on Albums.Album_id=Artists.Artist_id
where Artists.Artist_id in(select Albums.Artist_id from Albums group by Albums.Artist_id having count(Albums.Album_id)>1

--23. Retrieve all albums along with the total number of songs.

select Albums.Album_title,COUNT(Songs.Song_id) 
FROM Albums 
inner JOIN Songs ON Albums.Album_id=Songs.Song_id
GROUP BY Albums.Album_title;

--24. Retrieve all songs and release year and sort them by release year. 

SELECT Songs.Song_title, Albums.Release_year
FROM Songs
JOIN Albums  ON Songs.Album_id=Albums.Album_id
ORDER BY Albums.Release_year

--25. Retrieve the total number of songs for each genre, showing genres that have more than 2 songs. 

SELECT g.name AS genre_name, COUNT(Songs.Song_id) AS total_songs
FROM genres
JOIN Songs  ON g.id = Songs.genre_id
GROUP BY g.name
HAVING COUNT(Songs.Song_id) > 2;

--26. List all artists who have albums that contain more than 3 songs. 

SELECT Artists.Artist_name
FROM Artists 
JOIN Albums  ON Artists.Artist_id=Albums.Artist_id
JOIN Songs ON Albums.Album_id=Songs.Album_id
GROUP BY Artists.Artist_name
HAVING COUNT(Songs.Song_id) > 3;



--Part – C 
--27. Retrieve albums that have been released in the same year as 'Album4' 

SELECT a2.Album_title
FROM Albums a1
JOIN Albums a2 ON a1.Release_year = a2.Release_year
WHERE a1.Album_title = 'Album4' AND a2.Album_title != 'Album4';

--28. Find the longest song in each genre 

SELECT g.name AS genre_name, Songs.Song_title, MAX(Songs.duration) AS longest_duration
FROM genres g
JOIN songs s ON g.id = s.genre_id
GROUP BY g.name, s.title
ORDER BY g.name, longest_duration DESC;

--29. Retrieve the titles of songs released in albums that contain the word 'Album' in the title. 

SELECT Songs.Song_title
FROM Songs 
JOIN Albums ON Songs.Album_id = Albums.Album_id
WHERE Albums.Album_title LIKE '%Album%';

--30. Retrieve the total duration of songs by each artist where total duration exceeds 15 minutes.

SELECT Artists.Artist_name , SUM(Songs.Duration)
FROM Artists 
JOIN Albums ON Artists.Artist_id=Albums.Artist_id
JOIN Songs ON Albums.Album_id=Songs.Album_id
GROUP BY Artists.Artist_name
HAVING SUM(Songs.Duration) > 900;  

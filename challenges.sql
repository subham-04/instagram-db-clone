-- Finding the five oldest user

select * from users order by created_at limit 5;


-- Day when maximum users are registered 

select  dayname(created_at) as day, count(username) as total_user 
from users 
group by day  
order by total_user desc limit 3;


-- Identify Inactive Users (Users with no photos)

select username, image_url, 
case
when isnull(image_url)  then 'Inctive' else 'Active'
end as S
from users
left join photos
on users.id= photos.user_id
where photos.image_url is null; 


-- Identify the most popular photo and the user who created it

select  username as 'User', image_url as 'Image', count(likes.photo_id) as 'Total likes'  from likes
inner join photos
	on likes.photo_id = photos.id
inner join users
	on photos.id = users.id
    group by likes.photo_id order by 3 desc ;
    

-- Calculate the average number of photos per user

select (select count(*) from photos) / (select count(*) from users) as 'Avg post per user';
 
 
 -- Five most popular Hashtags

select tags.tagname, count(tagname) from tags
inner join photo_tags
	on photo_tags.tag_id = tags.id
group by tags.id order by 2 desc limit 5;


-- Finding bots (Users who liked almost all of the photos on the site)

select username, count(*) as likes from users
inner join likes
	on users.id = likes.user_id
group by likes.user_id
having likes= (select count(*) from photos);


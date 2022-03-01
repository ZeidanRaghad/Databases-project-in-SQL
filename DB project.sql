--I.D: 322514282
--QUEST NO.5
create table tblClubMember( 
memberCode int primary key,
firstName varchar(50) not null,
lastName varchar(50) not null,
birthdate date,
gender char(1) check (gender in ('F', 'M', 'O')),
maritalStatus char(1) check (maritalStatus in ('D', 'M', 'S', 'W')),
joinDate date,
email varchar (255) check (email ~ '^\S+@\S+$'),
cellphone char(10) check (cellphone ~ '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
check(birthdate < joinDate));

create table tblBrand( brandCode int primary key, brandName varchar(50) unique);

create table tblProduct( 
brandCode int,
productCode int check (productCode>0),
productName varchar(30),
primary key(brandCode, productCode),
unique (brandCode, productName),
CONSTRAINT fk_tblProduct
      FOREIGN KEY(brandCode) 
	  REFERENCES tblBrand (brandCode) on delete cascade on update cascade
	)

create table tblIntrestedIn(
primary key (memberCode, brandCode),
memberCode int,
brandCode int,
markingDate date not null,
uncheckingDate date,
CONSTRAINT fk_tblIntrestedIn
      FOREIGN KEY(memberCode) 
	  references tblClubMember (memberCode) on delete cascade on update cascade,
	  FOREIGN KEY(brandCode) references tblBrand (brandCode) on delete cascade on update cascade)

create table tblCampaign(
campaignCode int primary key,
CampaignName varchar(30),
beginDate date, 
endDate date check (beginDate<=endDate ),
leadingCampCode int,
CONSTRAINT fk_tblCampaign
     foreign key(leadingCampCode) references tblCampaign (campaignCode)
)	 


create table tblCampaignOfBrand(
campaignCode int primary key,
brandCode int,
CONSTRAINT fk_tblCampaignOfBrand
     foreign key(campaignCode) references tblCampaign (campaignCode) on delete cascade on update cascade,
     foreign key(brandCode) references tblBrand (brandCode))
	 
create table tblCampaignOfProduct(
campaignCode int primary key,
CONSTRAINT fk_tblCampaignOfProduct
	foreign key(campaignCode) references tblCampaign (campaignCode) on delete cascade on update cascade
)


create table tblProductsInCampaign( 
primary key (campaignCode, brandCode,productCode),
campaignCode int,
brandCode int,
productCode int,
CONSTRAINT fk_tblProductsInCampaign
	foreign key(campaignCode) references tblCampaignOfProduct (campaignCode) on delete cascade on update cascade,
	foreign key (brandCode,productCode) references tblProduct (brandCode,productCode) on delete cascade on update cascade
)



create table tblSocialMedia( 
mediaCode int  primary key, 
mediaName varchar(30) unique)

create table tblPersonalMedia( 
mediaCode int primary key,
mediaName varchar(30) unique)



create table tblCampaignInSocialMedia(
primary key (campaignCode, mediaCode),
campaignCode int,
mediaCode int,
publishDate date not null,
pageURL varchar(255) unique, 
noOfLikes int check (noOfLikes>=0),
NoOfShares int check (NoOfShares>=0), 
noOfComments int check (noOfComments>=0),
CONSTRAINT fk_tblCampaignInSocialMedia
	foreign key(campaignCode) references tblCampaign (campaignCode),
	foreign key(mediaCode) references tblSocialMedia(mediaCode)
)


create table tblActiveInCampaign( 
primary key (memberCode, campaignCode, mediaCode),
memberCode int,
campaignCode int,
mediaCode int,
hasLiked bit,
hasComment bit,
noOfShares int check (noOfShares >=0),
CONSTRAINT fk_tblActiveInCampaign
	foreign key(memberCode) references tblClubMember (memberCode),
	foreign key (campaignCode, mediaCode) references tblCampaignInSocialMedia (campaignCode,mediaCode )
)


create table tblSentToMember( 
primary key (memberCode, campaignCode),
memberCode int,
campaignCode int,
mediaCode int not null,
sendDate date not null,
hasOpend bit,
CONSTRAINT fk_tblSentToMember
	foreign key(memberCode) references tblClubMember (memberCode),
	foreign key (campaignCode) references tblCampaign (campaignCode) on delete cascade on update cascade,
	foreign key(mediaCode) references tblPersonalMedia(mediaCode)

)

--QUEST NO.7

INSERT INTO tblClubMember (memberCode, firstName, lastName, birthdate, gender, maritalStatus, joinDate, email, cellphone)
VALUES (11111111, 'Israel', 'Israeli', CAST('1979-10-12' AS Date), 'M', 'M', CAST('2017-09-18' AS Date), 'IsraelIsraeli@gmail.com', '0527765897')


INSERT INTO tblClubMember (memberCode, firstName, lastName, birthdate, gender, maritalStatus, joinDate, email, cellphone) 
VALUES  (11111112, 'Dani', 'Din', CAST('1991-04-04' AS Date), 'M', 'S', CAST('2019-09-12' AS Date), 'DaniDin@gmail.com', '0546667898')
 
INSERT INTO tblClubMember (memberCode, firstName, lastName, birthdate, gender, maritalStatus, joinDate, email, cellphone)
VALUES (11111113, 'Peter', 'Pan', CAST('1980-01-09' AS Date), 'M', 'S', CAST('2020-10-10' AS Date), 'peter@gmail.com', '0522445566')
 
INSERT INTO tblBrand (brandCode, brandName) VALUES (5, 'ariel')
 
INSERT INTO tblBrand (brandCode, brandName) VALUES(7, 'BillBing')
 
INSERT INTO tblBrand (brandCode, brandName) VALUES (1, 'FAX')
 
INSERT INTO tblBrand (brandCode, brandName) VALUES (2, 'FAX House')
 
INSERT INTO tblBrand (brandCode, brandName) VALUES (9, 'Foot Opener')
 
INSERT INTO tblBrand (brandCode, brandName) VALUES (3, 'Lilene')
 
INSERT INTO tblBrand (brandCode, brandName) VALUES (6, 'Mangi')
 
INSERT INTO tblBrand (brandCode, brandName) VALUES (10, 'Sporti')
 
INSERT INTO tblBrand (brandCode, brandName) VALUES (8, 'Terminal Y')
 
INSERT INTO tblBrand (brandCode, brandName) VALUES (4, 'UK Eagle')

INSERT INTO tblIntrestedIn (memberCode, brandCode, markingDate, uncheckingDate) VALUES (11111111, 1, CAST('2020-01-01' AS Date), NULL)
 
INSERT INTO tblIntrestedIn (memberCode, brandCode, markingDate, uncheckingDate) VALUES (11111111, 2, CAST('2020-03-09' AS Date), CAST(N'2020-04-19' AS Date))
 
INSERT INTO tblIntrestedIn (memberCode, brandCode, markingDate, uncheckingDate) VALUES (11111111, 4, CAST('2020-09-20' AS Date), NULL)
 
INSERT INTO tblIntrestedIn (memberCode, brandCode, markingDate, uncheckingDate) VALUES (11111111, 7, CAST('2020-09-20' AS Date), NULL)
 
INSERT INTO tblIntrestedIn (memberCode, brandCode, markingDate, uncheckingDate) VALUES (11111112, 1, CAST('2020-04-20' AS Date), NULL)
 
INSERT INTO tblIntrestedIn (memberCode, brandCode, markingDate, uncheckingDate) VALUES (11111112, 4, CAST('2020-09-08' AS Date), NULL)
 
INSERT INTO tblIntrestedIn (memberCode, brandCode, markingDate, uncheckingDate) VALUES (11111112, 5, CAST('2020-09-19' AS Date), NULL)
 
INSERT INTO tblCampaign (campaignCode, CampaignName, beginDate, endDate, leadingCampCode) VALUES (1, '50% על הפריט השני פסח 2020', CAST('2020-04-01' AS Date), CAST('2020-04-17' AS Date), NULL)
 
INSERT INTO tblCampaign (campaignCode, CampaignName, beginDate, endDate, leadingCampCode) VALUES (2, '30% הנחה על כל החנות', CAST('2020-05-01' AS Date), CAST('2020-05-07' AS Date), NULL)
 
INSERT INTO tblCampaign (campaignCode, CampaignName, beginDate, endDate, leadingCampCode) VALUES (3, '50% הנחה על כל החנות', CAST('2020-05-08' AS Date), CAST('2020-05-10' AS Date), 2)
 
INSERT INTO tblCampaign (campaignCode, CampaignName, beginDate, endDate, leadingCampCode) VALUES (4, '50% הנחה על כל החנות', CAST('2020-11-20' AS Date), CAST('2020-12-31' AS Date), NULL)
 
INSERT INTO tblCampaign (campaignCode, CampaignName, beginDate, endDate, leadingCampCode) VALUES (5, '30% הנחה על כל החנות', CAST('2020-10-10' AS Date), CAST('2020-12-07' AS Date), 2)
 
INSERT INTO tblCampaign (campaignCode, CampaignName, beginDate, endDate, leadingCampCode) VALUES (6, 'בלאק פריידי 2020', CAST('2020-11-11' AS Date), CAST('2020-11-30' AS Date), NULL)

INSERT INTO tblSocialMedia (mediaCode, mediaName) VALUES (1, 'Facebook')
 
INSERT INTO tblSocialMedia (mediaCode, mediaName) VALUES (3, 'Instegram')
 
INSERT INTO tblSocialMedia (mediaCode, mediaName) VALUES (9, 'Pinterest')
 
INSERT INTO tblSocialMedia (mediaCode, mediaName) VALUES (11, 'Reddit')
 
INSERT INTO tblSocialMedia (mediaCode, mediaName) VALUES (13, 'Tik Tok')
 
INSERT INTO tblSocialMedia (mediaCode, mediaName) VALUES (5, 'Twitter')
 
INSERT INTO tblSocialMedia (mediaCode, mediaName) VALUES (7, 'Youtube')
 




INSERT INTO tblCampaignInSocialMedia (campaignCode, mediaCode, publishDate, pageURL, noOfLikes, NoOfShares, noOfComments) VALUES (1, 1, CAST('2020-04-01' AS Date), 'camp1facebool.com', 5020, NULL, 999)
 
INSERT INTO tblCampaignInSocialMedia (campaignCode, mediaCode, publishDate, pageURL, noOfLikes, NoOfShares, noOfComments) VALUES (1, 3, CAST('2020-04-02' AS Date), 'camp1.com', 100, NULL, 3)
 
INSERT INTO tblCampaignInSocialMedia (campaignCode, mediaCode, publishDate, pageURL, noOfLikes, NoOfShares, noOfComments) VALUES (1, 5, CAST('2020-04-02' AS Date), 'camp1_1.com', 3894, 293, 394)
 
INSERT INTO tblCampaignInSocialMedia (campaignCode, mediaCode, publishDate, pageURL, noOfLikes, NoOfShares, noOfComments)VALUES (2, 1, CAST('2020-05-01' AS Date), 'facebook.com', 4000, 0, 0)
 
INSERT INTO tblCampaignInSocialMedia (campaignCode, mediaCode, publishDate, pageURL, noOfLikes, NoOfShares, noOfComments) VALUES (3, 1, CAST('2020-05-08' AS Date), 'facebook1.com', 6000, 0, 0)
 
INSERT INTO tblCampaignInSocialMedia (campaignCode, mediaCode, publishDate, pageURL, noOfLikes, NoOfShares, noOfComments) VALUES (6, 1, CAST('2020-11-11' AS Date), 'blackFacebook.com', 2034, 392, 8232)
 
INSERT INTO tblCampaignInSocialMedia (campaignCode, mediaCode, publishDate, pageURL, noOfLikes, NoOfShares, noOfComments) VALUES (6, 3, CAST('2020-11-11' AS Date), 'blackInsta.com', 20394, 392, 4829)
 
INSERT INTO tblActiveInCampaign (memberCode, campaignCode, mediaCode, hasLiked, hasComment, noOfShares) VALUES (11111111, 1, 1, '1', '0', 0)
 
INSERT INTO tblActiveInCampaign (memberCode, campaignCode, mediaCode, hasLiked, hasComment, noOfShares) VALUES (11111111, 2, 1, '0', '0', 1)
 
INSERT INTO tblActiveInCampaign (memberCode, campaignCode, mediaCode, hasLiked, hasComment, noOfShares) VALUES (11111112, 1, 1, '1', '1', 9)
 
INSERT INTO tblActiveInCampaign (memberCode, campaignCode, mediaCode, hasLiked, hasComment, noOfShares) VALUES (11111112, 1, 3, '1', '1', 8)
 
INSERT INTO tblActiveInCampaign (memberCode, campaignCode, mediaCode, hasLiked, hasComment, noOfShares) VALUES (11111112, 1, 5, '1', '1', 9)

 
INSERT INTO tblPersonalMedia (mediaCode, mediaName) VALUES (6, 'Call')
 
INSERT INTO tblPersonalMedia  (mediaCode, mediaName) VALUES (4, 'Cellphone')
 
INSERT INTO tblPersonalMedia  (mediaCode, mediaName) VALUES (2, 'Mail')
 
INSERT INTO tblPersonalMedia (mediaCode, mediaName) VALUES (10, 'Message')
 
INSERT INTO tblPersonalMedia (mediaCode, mediaName) VALUES (8, 'Tag')
 
INSERT INTO tblSentToMember (memberCode, campaignCode, mediaCode, sendDate, hasOpend) VALUES (11111111, 1, 2, CAST('2020-04-05' AS Date), '0')
 
INSERT INTO tblSentToMember  (memberCode, campaignCode, mediaCode, sendDate, hasOpend) VALUES (11111111, 3, 2, CAST('2020-05-09' AS Date), NULL)
 
INSERT INTO tblSentToMember (memberCode, campaignCode, mediaCode, sendDate, hasOpend) VALUES (11111111, 4, 2, CAST('2020-11-28' AS Date), '0')
 
INSERT INTO tblSentToMember (memberCode, campaignCode, mediaCode, sendDate, hasOpend) VALUES (11111111, 5, 4, CAST('2020-12-01' AS Date), '1')
 
INSERT INTO tblSentToMember (memberCode, campaignCode, mediaCode, sendDate, hasOpend) VALUES (11111112, 1, 2, CAST('2020-04-05' AS Date), '1')
 
INSERT INTO tblSentToMember (memberCode, campaignCode, mediaCode, sendDate, hasOpend) VALUES (11111112, 2, 6, CAST('2020-05-02' AS Date), '0')
 
INSERT INTO tblSentToMember (memberCode, campaignCode, mediaCode, sendDate, hasOpend) VALUES (11111112, 4, 2, CAST('2020-11-28' AS Date), '0')
 


INSERT INTO tblProduct (brandCode, productCode, productName) VALUES (1, 2, 'חולצה אדומה')
 
INSERT INTO tblProduct (brandCode, productCode, productName) VALUES(1, 1, 'חולצה צהובה')
 
INSERT INTO tblProduct  (brandCode, productCode, productName) VALUES (1, 4, 'מכנסיים ארוכים')
 
INSERT INTO tblProduct (brandCode, productCode, productName) VALUES (1, 3, 'מכנסיים קצרים')
 
INSERT INTO tblProduct (brandCode, productCode, productName) VALUES (2, 6, 'כוסות וויסקי')
 
INSERT INTO tblProduct (brandCode, productCode, productName) VALUES (2, 5, 'כוסות יין')
 
INSERT INTO tblProduct (brandCode, productCode, productName) VALUES (2, 2, 'צלחות גדולות')
 
INSERT INTO tblProduct (brandCode, productCode, productName) VALUES (2, 3, 'צלחות קטנות')
 
INSERT INTO tblProduct (brandCode, productCode, productName) VALUES (2, 4, 'צלחות קינוח')
 
INSERT INTO tblProduct (brandCode, productCode, productName) VALUES (2, 1, 'קעריות')
 
INSERT INTO tblProduct (brandCode, productCode, productName) VALUES (3, 1, 'מפיץ ריח')
 
INSERT INTO tblProduct (brandCode, productCode, productName) VALUES (3, 2, 'סבון גוף')
 
INSERT INTO tblProduct (brandCode, productCode, productName) VALUES (3, 3, 'סבון ידיים')
 
INSERT INTO tblCampaignOfBrand (campaignCode, brandCode) VALUES (2, 1)
 
INSERT INTO tblCampaignOfBrand (campaignCode, brandCode) VALUES (3, 2)
 
INSERT INTO tblCampaignOfProduct (campaignCode) VALUES (1)
 
INSERT INTO tblProductsInCampaign (campaignCode, brandCode, productCode) VALUES (1, 2, 1)
 
INSERT INTO tblProductsInCampaign (campaignCode, brandCode, productCode) VALUES (1, 2, 2)
 
INSERT INTO tblProductsInCampaign (campaignCode, brandCode, productCode) VALUES (1, 2, 3)
 
INSERT INTO tblProductsInCampaign (campaignCode, brandCode, productCode) VALUES (1, 2, 4)
 

--FIRST QUERY

SELECT m.memberCode, CONCAT(m.firstName, ' ', m.lastName) as mName,
DATE_PART('year', NOW()::date) - DATE_PART('year', m.birthdate) as Age,
EXTRACT(year FROM age(now(),m.joinDate))*12 + EXTRACT(month FROM age(now(),m.joinDate)) as Membership_months
FROM tblClubMember m WHERE (DATE_PART('year', NOW()) - DATE_PART('year', joinDate)) <=2 ORDER by mName

--SECOND QUERY

SELECT m.memberCode, CONCAT(m.firstName, ' ', m.lastName) as mName,
DATE_PART('year', NOW()::date) - DATE_PART('year', m.birthdate) as Age,
EXTRACT(year FROM age(now(),m.joinDate))*12 + EXTRACT(month FROM age(now(),m.joinDate)) as Membership_months,
i.brandCode, b.brandName
FROM tblClubMember m 
inner join tblIntrestedIn i on m.memberCode = i.memberCode 
inner join tblBrand b on i.brandCode = b.brandCode
WHERE (DATE_PART('year', NOW()) - DATE_PART('year', joinDate)) <=2 ORDER by mName, brandCode

--THIRD QUERY

SELECT b.brandCode, b.brandName, cob.campaignCode, cam.CampaignName, cam.beginDate, cam.endDate,
coalesce(csm.mediaCode, null) AS Media_Code,
coalesce(sm.mediaName, null) AS Media_Name ,
(coalesce(csm.noOfLikes,0) + coalesce(csm.noOfComments * 2, 0) + coalesce(csm.NoOfShares * 3,0)) as Flame 
FROM tblBrand b inner join tblCampaignOfBrand cob on b.brandCode=cob.brandCode 
inner join tblCampaign cam on cob.campaignCode = cam.campaignCode 
inner join tblCampaignInSocialMedia csm on cam.campaignCode = csm.campaignCode 
inner join tblSocialMedia sm on csm.mediaCode=sm.mediaCode 
where begindate between'31-12-2019'and'01-01-2021' 
ORDER by b.brandCode, Flame DESC

--FOURTH QUERY
SELECT 
	C.campaignCode,
	C.CampaignName,
	C.beginDate ,
	C.endDate ,
	C2.CampaignName ,
	C2.beginDate,
	C2.endDate ,
	ROUND((((CISM.noOfLikes)+(CISM.noOfComments*2)+(coalesce(CISM.NoOfShares,null)*3)))::decimal/
	((CSM.noOfLikes)+(CSM.noOfComments*2)+(coalesce(CSM.NoOfShares,null)*3)),2) AS Conversion_Rate
FROM tblCampaign C 
	INNER JOIN tblCampaign C2 
		ON C2.campaignCode = C.leadingCampCode
	INNER JOIN tblCampaignInSocialMedia CSM 
		ON CSM.campaignCode = C.campaignCode 
	INNER JOIN tblCampaignInSocialMedia CISM
		ON CISM.campaignCode = C2.campaignCode	
WHERE C.leadingCampCode <> 0;

--FIFTH QUERY
Select distinct cam.*
From tblCampaign cam
inner join tblCampaignInSocialMedia c on (c.campaignCode = cam.campaignCode)
LEFT Outer JOIN tblSentToMember stm on stm.campaignCode = c.campaignCode 
WHERE stm.campaignCode is null
--SIXTH QUERY
Select cam.*
from (
	SELECT campaignCode FROM tblCampaignInSocialMedia
	EXCEPT 
	SELECT campaignCode FROM tblSentToMember ) c
inner join tblCampaign cam on (c.campaignCode = cam.campaignCode)

--SEVENTH QUERY
Select distinct cam.*
From tblCampaign cam
inner join tblCampaignInSocialMedia c on (c.campaignCode = cam.campaignCode)
where cam.campaignCode NOT in (SELECT campaignCode FROM tblSentToMember)

--EIGHT QUERY
SELECT *
  FROM tblClubMember m
  WHERE (DATE_PART('year', NOW()::date) - DATE_PART('year', m.birthdate)) > 
  (SELECT AVG(DATE_PART('year', NOW()::date) - DATE_PART('year', m1.birthdate))
			FROM tblClubMember m1
			WHERE m.gender = m1.gender)







create table location
(
    Id          int auto_increment primary key,
    Town        varchar(255),
    PostCode    int,
    CreatedAt   timestamp default current_timestamp,
    EditedAt    timestamp default current_timestamp on update current_timestamp
);

create table user
(
    Id            int auto_increment primary key,
    Email         varchar(255),
    Name          varchar(255),
    Privileges    varchar(255),
    TutorialStep  int,
    Password      varchar(255),
    LocationId    int,
    ProfileId     int,
    CreatedAt     timestamp default current_timestamp,
    EditedAt      timestamp default current_timestamp on update current_timestamp,
    constraint localizesUser foreign key (LocationId) references location (Id)
);

create table picture
(
    Id         int auto_increment primary key,
    Filename   varchar(255),
    CreatedAt  timestamp default current_timestamp,
    EditedAt   timestamp default current_timestamp on update current_timestamp
);

create table advertisement
(
    Id            int auto_increment primary key,
    Title         varchar(255),
    Content       text,
    AdCategory    varchar(255),
    `Condition`   varchar(255),
    Periods       timestamp,
    Price         double,
    Discriminator varchar(255),
    UserId        int,
    LocationId    int,
    PictureId     int,
    CreatedAt     timestamp default current_timestamp,
    EditedAt      timestamp default current_timestamp on update current_timestamp,
    constraint advertises foreign key (UserId) references user (Id),
    constraint localizesAd foreign key (LocationId) references location (Id),
    constraint advertisementPicture foreign key (PictureId) references picture (Id)
);

create table message
(
    Id         int auto_increment primary key,
    Content    text,
    UserIdFrom int,
    UserIdTo   int,
    PictureId  int,
    CreatedAt  timestamp default current_timestamp,
    EditedAt   timestamp default current_timestamp on update current_timestamp,
    constraint receives foreign key (UserIdTo) references user (Id),
    constraint sends foreign key (UserIdFrom) references user (Id),
    constraint messagePicture foreign key (PictureId) references picture (Id)
);

create table notification
(
    Id              int auto_increment primary key,
    Icon            blob,
    Content         text,
    UserId          int,
    AdvertisementId int,
    ChatMessageId   int,
    CreatedAt       timestamp default current_timestamp,
    EditedAt        timestamp default current_timestamp on update current_timestamp,
    constraint notifies foreign key (UserId) references user (Id),
    constraint triggers foreign key (ChatMessageId) references message (Id),
    constraint triggers2 foreign key (AdvertisementId) references advertisement (Id)
);

create table profile
(
    Id          int auto_increment primary key,
    FirstName   varchar(255),
    LastName    varchar(255),
    Description varchar(255),
    PictureId   int,
    CreatedAt   timestamp default current_timestamp,
    EditedAt    timestamp default current_timestamp on update current_timestamp,
    constraint profilePicture foreign key (PictureId) references picture (Id)
);

create table review
(
    Id        int auto_increment primary key,
    Title     varchar(255),
    UserId    int,
    Stars     smallint,
    Content   text,
    CreatedAt timestamp default current_timestamp,
    EditedAt  timestamp default current_timestamp on update current_timestamp,
    constraint getsReviewed foreign key (UserId) references user (Id)
);

create table user_advertisement
(
    UserId          int,
    AdvertisementId int,
    primary key (UserId, AdvertisementId),
    CreatedAt       timestamp default current_timestamp,
    EditedAt        timestamp default current_timestamp on update current_timestamp,
    constraint subscribes foreign key (UserId) references user (Id),
    constraint subscribes2 foreign key (AdvertisementId) references advertisement (Id)
);

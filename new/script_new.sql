create table location
(
    Id       int          not null AUTO_INCREMENT primary key,
    Town     varchar(255) null,
    PostCode int          null
);

create table user
(
    Id           int          not null AUTO_INCREMENT primary key,
    Email        varchar(255) null,
    Name         varchar(255) null,
    Privileges   varchar(255) null,
    TutorialStep int          null,
    Password     varchar(255) null,
    LocationId   int          null,
    ProfileId    int          null,
    constraint localizesUser
        foreign key (LocationId) references location (Id)
);

create table picture
(
    Id    int  not null AUTO_INCREMENT primary key,
    image blob null
);
create table advertisement
(
    Id            int          not null AUTO_INCREMENT primary key,
    Title         varchar(255) null,
    Time          timestamp    null,
    Content       text         null,
    AdCategory    varchar(255) null,
    `Condition`   varchar(255) null,
    Periods       timestamp    null,
    Price         double       null,
    Date          timestamp    null,
    Discriminator varchar(255) null,
    UserId        int          null,
    LocationId    int          null,
    PictureId     int          null,
    constraint advertises
        foreign key (UserId) references user (Id),
    constraint localizesAd
        foreign key (LocationId) references location (Id),
    constraint advertisementPicture
        foreign key (PictureId) references picture (Id)
);

create table message
(
    Id         int       not null AUTO_INCREMENT primary key,
    Content    text      null,
    Time       timestamp null,
    UserIdFrom int       null,
    UserIdTo   int       null,
    PictureId  int       null,
    constraint receives
        foreign key (UserIdTo) references user (Id),
    constraint sends
        foreign key (UserIdFrom) references user (Id),
    constraint messagePicture
        foreign key (PictureId) references picture (Id)
);

create table notification
(
    Id              int       not null AUTO_INCREMENT primary key,
    TimeStamp       timestamp null,
    Icon            blob      null,
    Content         text      null,
    UserId          int       null,
    AdvertisementId int       null,
    ChatMessageId   int       null,
    constraint notifies
        foreign key (UserId) references user (Id),
    constraint triggers
        foreign key (ChatMessageId) references message (Id),
    constraint triggers2
        foreign key (AdvertisementId) references advertisement (Id)
);

create table profile
(
    Id          int          not null AUTO_INCREMENT primary key,
    FirstName   varchar(255) null,
    LastName    varchar(255) null,
    Description varchar(255) null,
    PictureId   int          null,
    constraint profilePicture
        foreign key (PictureId) references picture (Id)
);



create table review
(
    Id      int          not null AUTO_INCREMENT primary key,
    Title   varchar(255) null,
    UserId  int          null,
    Stars   smallint     null,
    Content text         null,
    constraint getsReviewed
        foreign key (UserId) references user (Id)
);

create table user_advertisement
(
    UserId          int not null,
    AdvertisementId int not null,
    primary key (UserId, AdvertisementId),
    constraint subscribes
        foreign key (UserId) references user (Id),
    constraint subscribes2
        foreign key (AdvertisementId) references advertisement (Id)
);
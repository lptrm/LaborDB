create table location
(
    Town     varchar(32) not null,
    PostCode int(10)     not null,
    primary key (Town, PostCode)
);

create table user
(
    Email            varchar(255) not null
        primary key,
    LocationPostCode int(10)      null,
    LocationTown     varchar(32)  null,
    Name             varchar(255) null,
    Privileges       varchar(255) null,
    TutorialStep     int(10)      null,
    Discriminator    varchar(16)  null,
    Password         varchar(255) null,
    Privliges        varchar(255) null,
    `Column`         varchar(255) null,
    constraint localizesUser
        foreign key (LocationTown, LocationPostCode) references location (Town, PostCode),
    constraint check_empty_name
        check (`Name` <> ''),
    constraint check_name
        check (`Name` not like '% %')
);

create table advertisement
(
    Title            varchar(64)  not null,
    Time             timestamp    not null,
    UserEmail        varchar(255) not null,
    LocationPostCode int(10)      null,
    LocationTown     varchar(32)  null,
    Content          text         not null,
    AdCategory       varchar(32)  not null,
    `Condition`      varchar(255) null,
    Period timestamp null,
    Price            double       null,
    Date             timestamp    null,
    Discriminator    varchar(16)  null,
    `Column`         varchar(255) null,
    primary key (Title, Time),
    constraint advertises
        foreign key (UserEmail) references user (Email),
    constraint localizesAd
        foreign key (LocationTown, LocationPostCode) references location (Town, PostCode)
);

create table chatmessage
(
    Content       text         null,
    Time          timestamp    not null
        primary key,
    UserEmailFrom varchar(255) not null,
    UserEmailTo   varchar(255) not null,
    constraint receives
        foreign key (UserEmailTo) references user (Email),
    constraint sends
        foreign key (UserEmailFrom) references user (Email)
);

create table notification
(
    UserEmail                varchar(255) not null,
    TimeStamp                timestamp    not null
        primary key,
    AdvertisementTitle       varchar(64)  null,
    AdvertisementTime        timestamp    null,
    ChatMessageTime          timestamp    null,
    ChatMessageUserEmailTo   varchar(255) null,
    ChatMessageUserEmailFrom varchar(255) null,
    Icon                     blob         null,
    Content                  text         not null,
    constraint notifies
        foreign key (UserEmail) references user (Email),
    constraint triggers
        foreign key (ChatMessageTime) references chatmessage (Time),
    constraint triggers2
        foreign key (AdvertisementTitle, AdvertisementTime) references advertisement (Title, Time)
);

create table profile
(
    FirstName   varchar(255)  not null,
    LastName    varchar(255)  not null,
    UserEmail   varchar(255)  not null,
    Description varchar(1000) null,
    primary key (FirstName, LastName),
    constraint isProfile
        foreign key (UserEmail) references user (Email)
);

create table photo
(
    Id                       int(10) auto_increment
        primary key,
    AdvertisementTime        timestamp    null,
    AdvertisementTitle       varchar(64)  null,
    ProfileLastName          varchar(255) not null,
    ProfileUserEmail         varchar(255) null,
    ProfileFirstName         varchar(255) null,
    ChatMessageTime          timestamp    null,
    ChatMessageUserEmailTo   varchar(255) null,
    ChatMessageUserEmailFrom varchar(255) null,
    image                    blob         not null,
    constraint attachedToAd
        foreign key (AdvertisementTitle, AdvertisementTime) references advertisement (Title, Time),
    constraint attachedToChat
        foreign key (ChatMessageTime) references chatmessage (Time),
    constraint attachedToProfile
        foreign key (ProfileLastName, ProfileFirstName) references profile (FirstName, LastName)
);

create table review
(
    Title         varchar(64)  not null
        primary key,
    UserEmailFrom varchar(255) not null,
    UserEmailTo   varchar(255) not null,
    Stars         smallint     not null,
    Content       text         null,
    constraint getsReviewed
        foreign key (UserEmailTo) references user (Email),
    constraint reviews
        foreign key (UserEmailFrom) references user (Email)
);

create table user_advertisement
(
    UserEmail          varchar(255) not null,
    AdvertisementTitle varchar(64)  not null,
    AdvertisementTime  timestamp    not null,
    primary key (AdvertisementTime, UserEmail, AdvertisementTitle),
    constraint subscribes
        foreign key (UserEmail) references user (Email),
    constraint subscribes2
        foreign key (AdvertisementTitle, AdvertisementTime) references advertisement (Title, Time)
);



create database music_app character set utf8mb4 collate utf8mb4_0900_ai_ci;

use music_app;

create table users(
    id int primary key auto_increment,
    role tinyint,
    name varchar(100),
    email varchar(50),
    username varchar(20),
    password varchar(150),
    image varchar(200)
);

create table songs(
    id int primary key auto_increment,
    image varchar(200),
    src varchar(200),
    name varchar(150),
    play_count int
);

create table artists(
    id int primary key auto_increment,
    name varchar(150),
    image varchar(200)
);

create table tags(
    id int primary key auto_increment,
    name varchar(150)
);

create table playlists(
    id int primary key auto_increment,
    name varchar(200),
    user_id int,
    foreign key (user_id) references users(id)
);

create table albums(
    id int primary key auto_increment,
    name varchar(200),
    cover varchar(200)
);

create table playlist_song(
    id int primary key auto_increment,
    playlist_id int,
    song_id int,
    foreign key (playlist_id) references playlists(id),
    foreign key (song_id) references songs(id)
);

create table album_song(
    id int primary key auto_increment,
    song_id int,
    foreign key (song_id) references songs(id)
);

create table tag_song(
    id int primary key auto_increment,
    tag_id int,
    song_id int,
    foreign key (tag_id) references tags(id),
    foreign key (song_id) references songs(id)
);

create table artist_song(
    id int primary key auto_increment,
    artist_id int,
    song_id int,
    foreign key (artist_id) references artists(id),
    foreign key (song_id) references songs(id)
);

alter table album_song
    add column album_id int,
    add foreign key (album_id) references albums(id);

/*
 Deleting table
 */
drop table if exists public.messages;
drop table if exists public.chat_users;
drop table if exists public.chats;
drop table if exists public.users;

/*
 Creating tables
 */
create table public.users
(
    id bigint not null generated always as identity,
    username varchar(255) not null,
    password varchar(255) not null,
    email varchar(255) not null,
    unique (id, username, email),
    primary key (id)
);

create table public.chats
(
    id bigint not null generated always as identity,
    name varchar(255) not null,
    owner_id bigint not null,
    unique (id),
    primary key (id),
    foreign key (owner_id) references users (id)
);

create table public.messages
(
    id bigint not null generated always as identity,
    text varchar(255) not null,
    user_id bigint not null,
    chat_id bigint not null,
    time timestamp not null,
    unique (id),
    primary key (id),
    foreign key (user_id) references users (id),
    foreign key (chat_id) references chats (id)
);

create table public.chat_users
(
    chat_id bigint not null,
    user_id bigint not null,
    foreign key (chat_id) references chats (id),
    foreign key (user_id) references users (id)
);
create table tasks
(
    id          serial
        primary key,
    title       varchar(255) not null,
    description text,
    status      varchar(50) default 'PENDING'::character varying
        constraint tasks_status_check
            check ((status)::text = ANY
                   ((ARRAY ['PENDING'::character varying, 'IN_PROGRESS'::character varying, 'COMPLETED'::character varying])::text[])),
    user_id     integer      not null
        constraint user_id
            references users
            on delete cascade,
    created_at  timestamp   default CURRENT_TIMESTAMP,
    updated_at  timestamp   default CURRENT_TIMESTAMP
);

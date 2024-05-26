namespace dhbw.caco.users;

@assert.unique: {username: [username], }
entity Users {
    key email        : String;
        username     : String @mandatory;
        passwordHash : String @mandatory;
}

entity Friendships {
    user1 : Association to Users;
    user2 : Association to Users;
}

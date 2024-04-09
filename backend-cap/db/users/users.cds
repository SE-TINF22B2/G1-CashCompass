namespace dhbw.caco.users;

@assert.unique: {username: [username], }
entity Users {
    key email        : String;
        username     : String @mandatory;
        passwordHash : String @mandatory;
}

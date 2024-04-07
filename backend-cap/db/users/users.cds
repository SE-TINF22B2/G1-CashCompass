namespace dhbw.caco.users;

@assert.unique: {username: [username], }
entity Users {
        key mail         : String;
            username     : String @mandatory;
            passwordHash : String @mandatory;
}

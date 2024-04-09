using dhbw.caco.users as users from '../../db';

@rest
service AuthService {
        entity Users as projection on users.Users;
        action signup( @mandatory email : String, @mandatory password : String, @mandatory username : String) returns String;
        action login( @mandatory email : String, @mandatory password : String)                                returns String;
}

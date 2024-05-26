using dhbw.caco.schema as schema from '../../db';

@rest
service AuthService {
        entity Users as projection on schema.Users;
        action signup( @mandatory email : String, @mandatory password : String, @mandatory username : String) returns String;
        action login( @mandatory email : String, @mandatory password : String)                                returns String;
}

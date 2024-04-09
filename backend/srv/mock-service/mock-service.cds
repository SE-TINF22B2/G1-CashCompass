using dhbw.caco.mock as mock from '../../db';

@rest
service MockService {
        entity MockEntity as projection on mock.MockEntity;
}

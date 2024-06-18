import { ApplicationService } from "@sap/cds";
import { SanitizedEntity } from "../../lib/types/dhbw.caco.schema";
import { Request } from "@sap/cds";


/**
 * DataService.
 * This is the service that is used for all the main logic of our app.
 * The code is so short as this automatically serves all CRUD endpoints defined for the entities in the data-service.cds (notice the same name. This is important here.)
 * SO everything is served without extra work but we are still able to overwrite the handlers or dock in at specific points.
 *
 * @extends {ApplicationService}
 */
export class DataService extends ApplicationService {
  /**
   * init.
   * This init overrides the init of the Application Service. Its used to define custom handler.
   * Because of this, we have to declare our handlers vefore calling the super method.
   */
  async init() {
    this.before("CREATE", SanitizedEntity.Accounts, this.handleBeforeAccountCreate);

    await super.init();
  }

  /**
   * handleBeforeAccountCreate.
   * This method is called before an Account is created to set the username from the id of the user, where the express object (or CAP) saves the id.
   * This may be replacable by just using the managed aspect, depending on for what filter this is important.
   *
   * @param {Request} req The CAP request object
   */
  private async handleBeforeAccountCreate(req: Request) {
    req.data.user_username = req.user.id;
  }

}

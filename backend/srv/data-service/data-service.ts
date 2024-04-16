import { ApplicationService } from "@sap/cds";
import { SanitizedEntity } from "../../lib/types/dhbw.caco.schema";
import { Request } from "@sap/cds";


export class DataService extends ApplicationService {
  async init() {
    this.before("CREATE", SanitizedEntity.Accounts, this.handleBeforeAccountCreate);

    await super.init();
  }

  //this may be replacable by just using the managed aspect, depending on for what filter this is important
  private async handleBeforeAccountCreate(req: Request) {
    req.data.user_username = req.user.id;
  }

}

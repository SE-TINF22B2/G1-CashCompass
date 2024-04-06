import { ApplicationService } from "@sap/cds";
import { SanitizedEntity, MockEntity } from '../../lib/types/dhbw.caco.mock';

export class MockService extends ApplicationService {
	async init() {

		this.after("READ", SanitizedEntity.MockEntity, this.handleAfterMockRead);

		await super.init();
	}

	handleAfterMockRead(res: MockEntity[]) {
		for (const mockEntity of res) {
			mockEntity.name += " !";
		}
	}
}

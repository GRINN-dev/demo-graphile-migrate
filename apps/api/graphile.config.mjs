import { PostGraphileAmberPreset } from "postgraphile/presets/amber";
import { makePgService } from "postgraphile/adaptors/pg";

/** @type {GraphileConfig.Preset} */
const preset = {
  extends: [PostGraphileAmberPreset],
  pgServices: [
    makePgService({
      connectionString: process.env.AUTH_DATABASE_URL,
      superuserConnectionString: process.env.DATABASE_URL,
      schemas: ["publ"],
      pgSettings: {
        role: process.env.DATABASE_VISITOR,
      },
    }),
  ],
  grafserv: { watch: true },
};

export default preset;

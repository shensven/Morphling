import * as dotenv from "dotenv";
import fs from "fs";
import { api } from "node-app-store-connect-api";

dotenv.config();

const { read } = await api({
  issuerId: process.env.APP_STORE_CONNECT_API_ISSUER_ID,
  apiKey: process.env.APP_STORE_CONNECT_API_KEY,
  privateKey: fs.readFileSync("privateKey.p8"),
});

const { data } = await read(
  "https://api.appstoreconnect.apple.com/v1/builds?filter[app]=1669993843"
);

if (data.length > 0) {
  console.log(data[0].attributes.version);
}
console.log(0);

import { configDotenv } from "dotenv";
import express from "express";

const { parsed } = configDotenv();
const PORT = parsed?.PORT || 8080;

const app = express();

app.listen(PORT, () => {
  console.log(`running at ${PORT}`);
});

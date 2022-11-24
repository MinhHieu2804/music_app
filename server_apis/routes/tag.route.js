const express = require("express");

const { tagController } = require("../controllers");
const { authMiddleware } = require("../middlewares");

const router = express.Router();

router.post("/", authMiddleware, tagController.createNewTag);
router.get("/", tagController.searchTag);

module.exports = router;

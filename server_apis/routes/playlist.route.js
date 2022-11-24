const express = require("express");

const { playlistController } = require("../controllers");

const router = express.Router();

router.post("/", playlistController.createPlaylist);
router.get("/", playlistController.getPlaylists);
router.delete("/:id", playlistController.deletePlaylist);

module.exports = router;

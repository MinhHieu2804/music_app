const express = require("express");

const { playlistController } = require("../controllers");

const router = express.Router();

router.post("/", playlistController.createPlaylist);
router.get("/details/:id", playlistController.getPlaylistDetails);
router.get("/", playlistController.getPlaylists);
router.put("/:playlistId", playlistController.addSongsToPlaylist);
router.delete("/:id", playlistController.deletePlaylist);

module.exports = router;

const express = require("express");
const multer = require("multer");

const { songController } = require("../controllers");
const { authMiddleware } = require("../middlewares");

const storage = multer.diskStorage({
  destination: (req, file, cb) => {
    if (file.fieldname === "track") {
      cb(null, "./public/files");
    } else {
      cb(null, "./public/images");
    }
  },
  filename: (req, file, cb) => {
    cb(null, file.originalname);
  },
});

const upload = multer({ storage: storage });

const router = express.Router();

router.post(
  "/",
  authMiddleware,
  upload.fields([
    { name: "track", maxCount: 1 },
    { name: "image", maxCount: 1 },
  ]),
  songController.createSong
);

router.get("/", songController.getSongs);
router.get("/:id", songController.getSongDetails);

module.exports = router;

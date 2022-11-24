const express = require("express");
const multer = require("multer");

const { artistController } = require("../controllers");
const { authMiddleware } = require("../middlewares");

const storage = multer.diskStorage({
  destination: (req, file, cb) => {
    cb(null, "./public/images");
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
  upload.single("image"),
  artistController.createArtist
);

router.get("/", artistController.getArtists);

module.exports = router;

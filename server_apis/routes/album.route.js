const express = require("express");
const multer = require("multer");

const { albumController } = require("../controllers");
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
  upload.single("cover"),
  albumController.createAlbum
);

router.get("/", albumController.getAlbums);

module.exports = router;

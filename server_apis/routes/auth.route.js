const express = require("express");
const multer = require("multer");
const { userController } = require("../controllers");

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

router.post("/login", userController.authenticate);
router.post("/register", upload.single("image"), userController.createUser);

module.exports = router;

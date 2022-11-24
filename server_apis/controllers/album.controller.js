const { albums, Sequelize } = require("../models");
const { Response, Contants } = require("../utils");

const createAlbum = async (req, res) => {
  try {
    const { name } = req.body;

    const imgPath = req.file
      ? `/public/images/${req.file.filename}`
      : `/public/images/album_default.jpg`;

    const newAlbum = {
      name,
      cover: imgPath,
    };
    const resData = await albums.create(newAlbum);
    const response = new Response(200, "OK! Album created.", resData);
    res.status(200).send(response);
  } catch (error) {
    const response = new Response(500, "Error", error);
    res.status(500).send(response);
  }
};

const getAlbums = async (req, res) => {
  try {
    const { page = 1, size = 20 } = req.query;

    const resData = await albums.findAndCountAll({
      limit: size - 0,
      offset: (page - 1) * (size - 0),
    });

    const response = new Response(200, "OK", resData);
    res.status(200).send(response);
  } catch (error) {
    const response = new Response(500, "Error", error);
    res.status(500).send(response);
  }
};

module.exports = {
  createAlbum,
  getAlbums,
};

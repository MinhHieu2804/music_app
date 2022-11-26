const { artists, Sequelize } = require("../models");
const { Response, Contants } = require("../utils");

const createArtist = async (req, res) => {
  try {
    const { name } = req.body;
    const imgPath = req.file
      ? `/public/images/${req.file.filename}`
      : `/public/images/artist_default.jpg`;

    const newArtist = {
      name,
      image: imgPath,
    };

    const resData = await artists.create(newArtist);
    const response = new Response(200, "OK! Artist created.", resData);
    res.status(200).send(response);
  } catch (error) {
    const response = new Response(500, "Error", error);
    res.status(500).send(response);
  }
};

const getArtists = async (req, res) => {
  try {
    const { page = 1, size = 20, name = "" } = req.query;

    const resData = await artists.findAndCountAll({
      limit: size - 0,
      offset: (page - 1) * (size - 0),
      where: {
        name: {
          [Sequelize.Op.like]: `%${name}%`,
        },
      },
    });

    const response = new Response(200, "OK", resData);
    res.status(200).send(response);
  } catch (error) {
    const response = new Response(500, "Error", error);
    res.status(500).send(response);
  }
};

module.exports = {
  createArtist,
  getArtists,
};

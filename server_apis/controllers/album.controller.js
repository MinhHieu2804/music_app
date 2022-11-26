const { albums, album_song, songs, Sequelize } = require("../models");
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

const addSongsToAlbum = async (req, res) => {
  try {
    if (req.user_data.role !== Contants.USER.ROLE.ADMIN) {
      const response = new Response(403, "Permission denied");
      return res.status(403).send(response);
    }
    const { songIds } = req.body;
    const albumId = req.params.id;

    if (!albumId || !songIds) {
      const response = new Response(500, "Missing require value");
      return res.status(500).send(response);
    }

    const data = songIds.map((id) => {
      return {
        song_id: id,
        album_id: albumId,
      };
    });
    const resData = await album_song.bulkCreate(data);
    const response = new Response(200, "OK! Songs added.", resData);
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

const getAlbumDetails = async (req, res) => {
  try {
    const { id } = req.params;

    const data = await album_song.findAll({
      include: [
        {
          model: songs,
          attributes: ["id", "name", "play_count", "image"],
        },
        {
          model: albums,
        },
      ],
      where: {
        album_id: id,
      },
    });

    const resData = data.reduce((arr, item) => {
      return [...arr, ...item.songs];
    }, []);

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
  getAlbumDetails,
  addSongsToAlbum,
};

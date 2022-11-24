const { playlists, Sequelize } = require("../models");
const { Response, Contants } = require("../utils");

const createPlaylist = async (req, res) => {
  try {
    const { name } = req.body;

    const user_id = req.user_data?.id;

    const newplaylist = {
      name,
      user_id,
    };
    const resData = await playlists.create(newplaylist);
    const response = new Response(200, "OK! Playlist created.", resData);
    res.status(200).send(response);
  } catch (error) {
    const response = new Response(500, "Error", error);
    res.status(500).send(response);
  }
};

const getPlaylists = async (req, res) => {
  try {
    const { page = 1, size = 20 } = req.query;
    const user_id = req.user_data?.id;

    const resData = await playlists.findAndCountAll({
      limit: size - 0,
      offset: (page - 1) * (size - 0),
      where: {
        user_id,
      },
    });

    const response = new Response(200, "OK", resData);
    res.status(200).send(response);
  } catch (error) {
    const response = new Response(500, "Error", error);
    res.status(500).send(response);
  }
};

const deletePlaylist = async (req, res) => {
  try {
    const { id } = req.params;
    const user_id = req.user_data?.id;

    const playlistRes = await playlists.findOne({
      where: {
        user_id,
        id,
      },
    });

    if (!playlistRes) {
      const response = new Response(404, "Playlist does not exist");
      return res.status(404).send(response);
    }

    const resData = await playlists.destroy({
      where: {
        user_id,
        id,
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
  createPlaylist,
  getPlaylists,
  deletePlaylist,
};

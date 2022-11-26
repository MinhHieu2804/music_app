const { songs, artist_song, artists, Sequelize } = require("../models");
const { Response, Contants } = require("../utils");

const createSong = async (req, res) => {
  try {
    if (req.user_data.role !== Contants.USER.ROLE.ADMIN) {
      const response = new Response(403, "Permission denied");
      return res.status(403).send(response);
    }

    const { name, artistIds } = req.body;

    if (!req.files.track[0]) {
      const response = new Response(500, "Missing require value");
      return res.status(500).send(response);
    }

    const src = `/public/files/${req.files.track[0].filename}`;

    const imgPath = req.files.image[0]
      ? `/public/images/${req.files.image[0].filename}`
      : `/public/images/song_default.jpg`;

    const newSong = {
      name,
      image: imgPath,
      src,
      play_count: 0,
    };

    const resData = await songs.create(newSong);
    const dataMapArtistSong = artistIds.map((id) => {
      return { artist_id: id, song_id: resData.id };
    });
    await artist_song.bulkCreate(dataMapArtistSong);

    const response = new Response(200, "OK! Song created.");
    res.status(200).send(response);
  } catch (error) {
    const response = new Response(500, "Error", error);
    res.status(500).send(response);
  }
};

const getSongs = async (req, res) => {
  try {
    const { page = 1, size = 20, name = "" } = req.query;

    const resData = await songs.findAndCountAll({
      limit: size - 0,
      offset: (page - 1) * (size - 0),
      attributes: ["id", "image", "name"],
      where: {
        name: {
          [Sequelize.Op.like]: `%${name}%`,
        },
      },
    });

    const ids = resData.rows.map((item) => item.id);

    const artistList = await artist_song.findAll({
      include: [
        {
          model: artists,
        },
      ],
      where: {
        song_id: {
          [Sequelize.Op.in]: ids,
        },
      },
    });

    const data = resData.rows.map((song) => {
      let s = { ...song.dataValues, artists: [] };
      for (let i = 0; i < artistList.length; i++) {
        const ar = artistList[i].dataValues;
        if (s.id === ar.song_id) {
          s.artists = !s.artists.length
            ? [...ar.artists]
            : [...s.artists, ...ar.artists];
        }
      }
      return s;
    });

    resData.rows = data;

    const response = new Response(200, "OK", resData);
    res.status(200).send(response);
  } catch (error) {
    const response = new Response(500, "Error", error);
    res.status(500).send(response);
  }
};

const getSongDetails = async (req, res) => {
  try {
    const { id } = req.params;

    const songData = await songs.findOne({
      where: {
        id,
      },
    });

    if (!songData) {
      const response = new Response(404, "Not found");
      return res.status(404).send(response);
    }

    const [artistData, temp] = await Promise.all([
      artist_song.findAll({
        include: [
          {
            model: songs,
          },
          {
            model: artists,
          },
        ],
        where: {
          song_id: id,
        },
      }),
      songs.update(
        { play_count: ++songData.play_count },
        {
          where: {
            id,
          },
        }
      ),
    ]);

    const resData = {
      ...songData.dataValues,
      artists: artistData.reduce((arr, item) => {
        return [...arr, ...item.artists];
      }, []),
    };

    const response = new Response(200, "OK", resData);
    res.status(200).send(response);
  } catch (error) {
    const response = new Response(500, "Error", error);
    res.status(500).send(response);
  }
};

const getSongsByArtist = async (req, res) => {
  try {
    const { artistId } = req.params;

    const resData = await artist_song.findAll({
      include: [
        {
          model: songs,
        },
        {
          model: artists,
        },
      ],
      where: {
        artist_id: artistId,
      },
    });

    const data = resData.reduce((arr, item) => {
      return [...arr, ...item.songs];
    }, []);

    const response = new Response(200, "OK", data);
    res.status(200).send(response);
  } catch (error) {
    const response = new Response(500, "Error", error);
    res.status(500).send(response);
  }
};

const deleteSong = async (req, res) => {
  try {
    const { id } = req.params;

    const songRes = await songs.findOne({
      where: {
        id,
      },
    });

    if (!songRes) {
      const response = new Response(404, "Song does not exist");
      return res.status(404).send(response);
    }

    const resData = await songs.destroy({
      where: {
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
  createSong,
  getSongs,
  getSongDetails,
  getSongsByArtist,
  deleteSong,
};

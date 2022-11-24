module.exports = function (sequelize, Sequelize) {
  const Playlist_Song = sequelize.define(
    "playlist_song",
    {
      id: {
        autoIncrement: true,
        primaryKey: true,
        type: Sequelize.INTEGER,
      },

      song_id: {
        type: Sequelize.INTEGER,
      },

      playlist_id: {
        type: Sequelize.INTEGER,
      },
    },
    { createdAt: false, updatedAt: false, freezeTableName: true }
  );

  return Playlist_Song;
};

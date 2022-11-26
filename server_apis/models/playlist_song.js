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

  Playlist_Song.associate = function (models) {
    Playlist_Song.hasMany(models.playlists, {
      foreignKey: "id",
      sourceKey: "playlist_id",
    });
    Playlist_Song.hasMany(models.songs, {
      foreignKey: "id",
      sourceKey: "song_id",
    });
  };

  return Playlist_Song;
};

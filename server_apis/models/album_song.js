module.exports = function (sequelize, Sequelize) {
  const Album_Song = sequelize.define(
    "album_song",
    {
      id: {
        autoIncrement: true,
        primaryKey: true,
        type: Sequelize.INTEGER,
      },

      song_id: {
        type: Sequelize.INTEGER,
      },

      album_id: {
        type: Sequelize.INTEGER,
      },
    },
    { createdAt: false, updatedAt: false, freezeTableName: true }
  );

  Album_Song.associate = function (models) {
    Album_Song.hasMany(models.albums, {
      foreignKey: "id",
      sourceKey: "album_id",
    });
    Album_Song.hasMany(models.songs, {
      foreignKey: "id",
      sourceKey: "song_id",
    });
  };

  return Album_Song;
};

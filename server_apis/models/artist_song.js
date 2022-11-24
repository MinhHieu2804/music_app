module.exports = function (sequelize, Sequelize) {
  const Artist_Song = sequelize.define(
    "artist_song",
    {
      id: {
        autoIncrement: true,
        primaryKey: true,
        type: Sequelize.INTEGER,
      },

      song_id: {
        type: Sequelize.INTEGER,
      },

      artist_id: {
        type: Sequelize.INTEGER,
      },
    },
    { createdAt: false, updatedAt: false, freezeTableName: true }
  );

  Artist_Song.associate = function (models) {
    Artist_Song.hasMany(models.artists, {
      foreignKey: "id",
      sourceKey: "artist_id",
    });
    Artist_Song.hasMany(models.songs, {
      foreignKey: "id",
      sourceKey: "song_id",
    });
  };

  return Artist_Song;
};

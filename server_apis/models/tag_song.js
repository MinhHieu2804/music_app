module.exports = function (sequelize, Sequelize) {
  const Tag_Song = sequelize.define(
    "tag_song",
    {
      id: {
        autoIncrement: true,
        primaryKey: true,
        type: Sequelize.INTEGER,
      },

      song_id: {
        type: Sequelize.INTEGER,
      },

      tag_id: {
        type: Sequelize.INTEGER,
      },
    },
    { createdAt: false, updatedAt: false, freezeTableName: true }
  );

  Tag_Song.associate = function (models) {
    Tag_Song.hasMany(models.tags, {
      foreignKey: "id",
      sourceKey: "tag_id",
    });
    Tag_Song.hasMany(models.songs, {
      foreignKey: "id",
      sourceKey: "song_id",
    });
  };

  return Tag_Song;
};

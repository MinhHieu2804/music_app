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

  return Album_Song;
};

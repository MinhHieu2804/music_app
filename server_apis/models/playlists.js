module.exports = function (sequelize, Sequelize) {
  const Playlist = sequelize.define(
    "playlists",
    {
      id: {
        autoIncrement: true,
        primaryKey: true,
        type: Sequelize.INTEGER,
      },

      user_id: {
        type: Sequelize.INTEGER,
      },

      name: {
        type: Sequelize.STRING,
      },
    },
    { createdAt: false, updatedAt: false, freezeTableName: true }
  );

  return Playlist;
};

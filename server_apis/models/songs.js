module.exports = function (sequelize, Sequelize) {
  const Song = sequelize.define(
    "songs",
    {
      id: {
        autoIncrement: true,
        primaryKey: true,
        type: Sequelize.INTEGER,
      },

      image: {
        type: Sequelize.STRING,
      },

      src: {
        type: Sequelize.STRING,
      },

      name: {
        type: Sequelize.STRING,
      },

      play_count: {
        type: Sequelize.INTEGER,
      },
    },
    { createdAt: false, updatedAt: false, freezeTableName: true }
  );

  return Song;
};

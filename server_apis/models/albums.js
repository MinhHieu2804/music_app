module.exports = function (sequelize, Sequelize) {
  const Album = sequelize.define(
    "albums",
    {
      id: {
        autoIncrement: true,
        primaryKey: true,
        type: Sequelize.INTEGER,
      },

      cover: {
        type: Sequelize.STRING,
      },

      name: {
        type: Sequelize.STRING,
      },
    },
    { createdAt: false, updatedAt: false, freezeTableName: true }
  );

  return Album;
};

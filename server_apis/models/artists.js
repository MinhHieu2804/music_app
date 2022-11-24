module.exports = function (sequelize, Sequelize) {
  const Artist = sequelize.define(
    "artists",
    {
      id: {
        autoIncrement: true,
        primaryKey: true,
        type: Sequelize.INTEGER,
      },

      image: {
        type: Sequelize.STRING,
      },

      name: {
        type: Sequelize.STRING,
      },
    },
    { createdAt: false, updatedAt: false, freezeTableName: true }
  );

  return Artist;
};

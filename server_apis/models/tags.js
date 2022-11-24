module.exports = function (sequelize, Sequelize) {
  const Tag = sequelize.define(
    "tags",
    {
      id: {
        autoIncrement: true,
        primaryKey: true,
        type: Sequelize.INTEGER,
      },

      name: {
        type: Sequelize.STRING,
      },
    },
    { createdAt: false, updatedAt: false, freezeTableName: true }
  );

  return Tag;
};

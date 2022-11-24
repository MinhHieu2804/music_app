module.exports = function (sequelize, Sequelize) {
  const User = sequelize.define(
    "users",
    {
      id: {
        autoIncrement: true,
        primaryKey: true,
        type: Sequelize.INTEGER,
      },

      username: {
        type: Sequelize.STRING,
      },

      password: {
        type: Sequelize.STRING,
      },

      role: {
        type: Sequelize.INTEGER,
      },

      email: {
        type: Sequelize.STRING,
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

  return User;
};

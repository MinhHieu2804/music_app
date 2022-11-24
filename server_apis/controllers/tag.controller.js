const { tags, Sequelize } = require("../models");
const { Response } = require("../utils");

const createNewTag = async (req, res) => {
  try {
    const { tagList } = req.body;

    const newTagList = tagList.map((name) => {
      return { name };
    });

    const tagsRes = await tags.bulkCreate(newTagList);
    const response = new Response(200, "OK! New tag created.", tagsRes);
    res.status(200).send(response);
  } catch (error) {
    const response = new Response(500, "Error", error);
    res.status(500).send(response);
  }
};

const searchTag = async (req, res) => {
  try {
    const { name } = req.query;

    const tagsRes = await tags.findAll({
      where: {
        name: {
          [Sequelize.Op.like]: `%${name}%`,
        },
      },
    });

    const response = new Response(200, "OK", tagsRes);
    res.status(200).send(response);
  } catch (error) {
    const response = new Response(500, "Error", error);
    res.status(500).send(response);
  }
};

module.exports = {
  createNewTag,
  searchTag,
};

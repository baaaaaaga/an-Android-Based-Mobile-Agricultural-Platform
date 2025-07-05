module.exports = {
  // 当前配置为根配置，将不再从上级文件夹查找配置
  root: true,
  /* 指定如何解析语法。可以为空，但若不为空，只能配该值，原因见下文。*/
  parser: 'vue-eslint-parser',
  // https://eslint.bootcss.com/docs/user-guide/configuring#specifying-globals
  // globals: {
  //   Nullable: true,
  // },
  extends: [
    'eslint:recommended',
    // prettier推荐规则,
    'prettier',
    'plugin:prettier/recommended',
  ],
  rules: {},
};

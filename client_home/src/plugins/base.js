export const getBaseImgUrl = (url) => {
  if (!url) {
    return '/static/img/logo.png';
  }

  if (/^\/static/.test(url)) {
    return url.replace('/static', '');
  }

  const lastIndex = url.lastIndexOf('/upload');
  url = url.substring(lastIndex);

  if (/^http/.test(url)) {
    return url;
  } else {
    return process.env.VUE_APP_BASE_HOST + url;
  }
};

/**
 * 转换时间格式
 * @param {String} time 时间字符串
 * @param {String} format 格式
 */
export const toTime = (time, format) => {
  console.log(time);
  const s_time = time.toString();
  if (s_time.length == 13) {
    time = time / 1000;
  }
  return time.toTime().toStr(format);
};

/**
 * 小程序rich-text图片统一
 * @param {Sting} content 数据内容
 */
export const setRichTextImage = (content) => {
  const newContent = content
    .replace(/<img([\s\w"-=\/\.:;]+)((?:(height="[^"]+")))/gi, '<img$1')
    .replace(/<img([\s\w"-=\/\.:;]+)((?:(width="[^"]+")))/gi, '<img$1')
    .replace(/<img([\s\w"-=\/\.:;]+)((?:(style="[^"]+")))/gi, '<img$1')
    .replace(/<img([\s\w"-=\/\.:;]+)((?:(alt="[^"]+")))/gi, '<img$1')
    .replace(/<img([\s\w"-=\/\.:;]+)/gi, '<img style="width: 100%;" $1');

  return newContent;
};

/**
 * @description 转url字符串
 * @param {Object} obj 被转换的对象
 * @param {String} url 请求地址
 * @return {String} url参数格式字符串
 */
export const toUrl = (obj, url) => {
  let queryStr = '';
  for (let key in obj) {
    const value = obj[key];
    if (typeof value === 'number') {
      if (value > 0) {
        queryStr += '&' + key + '=' + obj[key];
      }
    } else if (value) {
      queryStr += '&' + key + '=' + encodeURI(value);
    }
  }
  if (url) {
    if (url.endWith('?') || url.endWith('&')) {
      return url + queryStr.replace('&', '');
    } else if (url.indexOf('?') === -1) {
      return url + queryStr.replace('&', '?');
    } else {
      return url + queryStr;
    }
  } else {
    return queryStr.replace('&', '');
  }
};

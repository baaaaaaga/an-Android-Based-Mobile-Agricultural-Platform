function addDefineProperty(tyoe, name, func) {
  Object.defineProperty(tyoe.prototype, name, {
    value: func,
    enumerable: false, // 将属性设置为不可枚举
  });
}
/* == 数字原型函数 == */
(function () {
  /**
   * @description 去尾法
   * @param {Number} len 保留长度
   * @return {Number} 数值
   */
  const numberPrototypeToFloor = function (len) {
    var n = Math.pow(10, len);
    return Math.floor(this * n) / n;
  };
  addDefineProperty(Number, 'toFloor', numberPrototypeToFloor);

  // 	Object.defineProperty(const prototype, "remove", {
  //   value(callback) {
  //     const index = this.findIndex(callback);
  //     if (index > -1) {
  //       this.splice(index, 1);
  //     }
  //     return index;
  //   },
  //   enumerable: false, // 将属性设置为不可枚举
  //   writable: true,
  //   configurable: true
  // });
  /**
   * @description 进一法
   * @param {Number} len 保留长度
   * @return {Number} 数值
   */
  const numberPrototypeToCeil = function (len) {
    var n = Math.pow(10, len);
    return Math.ceil(this * n) / n;
  };
  addDefineProperty(Number, 'toCeil', numberPrototypeToCeil);
  /**
   * @description 四舍五入法
   * @param {Number} len 保留长度
   * @return {Number} 数值
   */
  const numberPrototypeToRound = function (len) {
    var n = Math.pow(10, len);
    return Math.round(this * n) / n;
  };
  addDefineProperty(Number, 'toRound', numberPrototypeToRound);
  /**
   * @description 数值转字符串, 保留尾数长度
   * @param {Number} len 保留长度
   * @param {String} mode 保留方式
   * @return {String} 截取后字符串
   */
  const numberPrototypeGet = function (len, mode) {
    var n;
    switch (mode) {
      case 1:
      case 'toRound':
        n = this.toRound(len);
        break;
      case 2:
      case 'toCeil':
        n = this.toCeil(len);
        break;
      case 3:
      case 'toFloor':
        n = this.toFloor(len);
        break;
      default:
        n = this.toString();
        break;
    }
    return n;
  };
  addDefineProperty(Number, 'get', numberPrototypeGet);
  /**
   * @description 数值转字符串, 保留尾数长度
   * @param {Number} len 保留长度
   * @param {String} mode 保留方式
   * @return {String} 截取后字符串
   */
  const numberPrototypeToStr = function (len, mode) {
    var n = this.get(len, mode);
    var s = n.toString();
    var rs = s.indexOf('.');
    if (len > 0 && rs < 0) {
      rs = s.length;
      s += '.';
    }
    while (s.length <= rs + len) {
      s += '0';
    }
    return s;
  };
  addDefineProperty(Number, 'toStr', numberPrototypeToStr);
  /**
   * @description 转为时间类型
   * @return {Date} 时间对象
   */
  const numberPrototypeToTime = function () {
    return new Date(this * 1000);
  };

  addDefineProperty(Number, 'toTime', numberPrototypeToTime);
})();

/* == 时间原型函数 == */
(function () {
  /**
   * @description 时间格式化
   * @param {String} format 指定格式
   * @return {String} 时间格式字符串
   */
  const datePrototypeToStr = function (format) {
    var o = {
      'M+': this.getMonth() + 1,
      'd+': this.getDate(),
      'h+': this.getHours(),
      'm+': this.getMinutes(),
      's+': this.getSeconds(),
      'q+': Math.floor((this.getMonth() + 3) / 3),
      S: this.getMilliseconds(),
    };
    if (/(y+)/.test(format)) {
      var x = RegExp.$1;
      format = format.replace(x, (this.getFullYear() + '').substr(4 - x.length));
    }
    for (var k in o) {
      if (new RegExp('(' + k + ')').test(format)) {
        var x = RegExp.$1;
        format = format.replace(x, x.length == 1 ? o[k] : ('00' + o[k]).substr(('' + o[k]).length));
      }
    }
    return format;
  };
  addDefineProperty(Date, 'toStr', datePrototypeToStr);
  /**
   * @description 获取当前时间戳
   * @return {Number} 返回时间戳
   */
  const datePrototypeStamp = function () {
    var timestamp = Date.parse(this);
    return timestamp / 1000;
  };
  addDefineProperty(Date, 'stamp', datePrototypeStamp);
  /**
   * @description 计算时间差(时间间隔)
   * @param {String} endTime 结束时间
   * @param {String} time_unit = [day|hours|minutes] 时间单位
   * @return {Number} 间隔时长
   */
  const datePrototypeInterval = function (endTime, time_unit) {
    var startTime = this; // startTime: 开始时间
    var stime = Date.parse(startTime);
    var etime = Date.parse(new Date(endTime));
    var usedTime = etime - stime; // 两个时间戳相差的毫秒数
    if (time_unit === 'day') {
      return Math.floor(usedTime / (1000 * 60 * 60 * 24));
    } else if (time_unit === 'hours') {
      return Math.floor(usedTime / (1000 * 60 * 60));
    } else if (time_unit === 'minutes') {
      return Math.floor(usedTime / (1000 * 60));
    } else {
      return Math.floor(usedTime / 1000);
    }
  };
  addDefineProperty(Date, 'interval', datePrototypeInterval);
  /**
   * @description 时间添加天数
   * @param {Number} days 天数
   * @return {Date} 时间对象
   */
  const datePrototypeAddDays = function (days) {
    this.setDate(this.getDate() + days);
    return this;
  };
  addDefineProperty(Date, 'addDays', datePrototypeAddDays);
  /**
   * @description 时间添加秒数
   * @param {Date} seconds 时间对象
   */
  const datePrototypeAddSeconds = function (seconds) {
    this.setSeconds(this.getSeconds() + seconds);
    return this;
  };
  addDefineProperty(Date, 'addSeconds', datePrototypeAddSeconds);
})();

/* == 字符串拓展函数 == */
(function () {
  /**
   * @description MD5加密
   * @return {String} 加密后的字符串
   */
  const stringPrototypeMd5 = function () {
    return $.md5(this + '');
  };
  addDefineProperty(String, 'md5', stringPrototypeMd5);
  /**
   * aes加密
   * @param data 待加密内容
   * @param key 必须为32位私钥
   * @returns {String}
   */
  const stringPrototypeAesEncode = function (key, iv) {
    iv = iv || '';
    var clearEncoding = 'utf8';
    var cipherEncoding = 'base64';
    var cipherChunks = [];
    var cipher = createCipheriv('aes-256-ecb', key, iv);
    cipher.setAutoPadding(true);
    cipherChunks.push(cipher.update(this + '', clearEncoding, cipherEncoding));
    cipherChunks.push(cipher.final(cipherEncoding));
    return cipherChunks.join('');
  };
  addDefineProperty(String, 'aes_encode', stringPrototypeAesEncode);
  /**
   * @description aes解密
   * @param key 必须为32位私钥
   * @returns {String}
   */
  const stringPrototypeAesDecode = function (key, iv) {
    iv = iv || '';
    var clearEncoding = 'utf8';
    var cipherEncoding = 'base64';
    var cipherChunks = [];
    var decipher = createDecipheriv('aes-256-ecb', key, iv);
    decipher.setAutoPadding(true);
    cipherChunks.push(decipher.update(this + '', cipherEncoding, clearEncoding));
    cipherChunks.push(decipher.final(clearEncoding));
    return cipherChunks.join('');
  };
  addDefineProperty(String, 'aes_decode', stringPrototypeAesDecode);
  /**
   * @description 获取字符串的拼音
   * @return {String} 拼音
   */
  const stringPrototypePinyin = function () {
    return pinyin(this).join('');
  };
  addDefineProperty(String, 'pinyin', stringPrototypePinyin);
  /**
   * @description 获取字符串的拼音
   * @return {String} 拼音
   */
  const stringPrototypePinyinS = function () {
    var arr = pinyin(this);
    var str = '';
    for (var i = 0; i < arr.length; i++) {
      var ar = arr[i];
      if (ar.length > 0) {
        var o = ar[0];
        str += o.charAt(0).toLocaleUpperCase() + o.substring(1);
      } else {
        str += ' ';
      }
    }
    return str;
  };
  addDefineProperty(String, 'pinyinS', stringPrototypePinyinS);
  /**
   * @description 将json字符串转为对象
   * @return {Object} 对象
   */
  const stringPrototypeToJson = function () {
    try {
      return JSON.parse(this);
    } catch (e) {
      console.log('json反序列化错误');
      return null;
    }
  };
  addDefineProperty(String, 'toJson', stringPrototypeToJson);
  /**
   * @description 将url字符串转为对象
   * @return {Object} 对象
   */
  const stringPrototypeToUrl = function () {
    var arr = this.split('&');
    var obj = {};
    arr.func(function (o) {
      var ar = o.split('=');
      if (ar.length > 1) {
        obj[ar[0]] = decodeURI(ar[1]);
      } else {
        obj[ar[0]] = null;
      }
    });
    return obj;
  };
  addDefineProperty(String, 'toUrl', stringPrototypeToUrl);
  /**
   * @description 将url参数转为对象
   * @return {Object} 对象
   */
  const stringPrototypeToQuery = function () {
    var str = this + '';
    var index = str.indexOf('?');
    if (index !== -1) {
      str = str.substring(index + 1);
    } else {
      return {};
    }
    return str.toUrl();
  };
  addDefineProperty(String, 'toQuery', stringPrototypeToQuery);

  /**
   * @description 删除首字符
   * @param {String} str  要删除的字符, 默认删除空字符
   * @return {String} 删除后字符串
   */
  const stringPrototypeStartTrim = function (str) {
    if (!str) {
      str = '\\s';
    } else {
      str = str.replace('$', '\\$').replace('^', '\\^').replace('(', '\\(').replace(')', '\\)');
    }
    var rx = new RegExp('(^' + str + '*)', 'g');
    return this.replace(rx, '');
  };
  addDefineProperty(String, 'startTrim', stringPrototypeStartTrim);
  /**
   * @description 删除尾字符
   * @param {String} str 要删除的字符, 默认删除空字符
   * @return {String} 删除后字符串
   */
  const stringPrototypeEndTrim = function (str) {
    if (!str) {
      str = '\\s';
    } else {
      str = str.replace('$', '\\$').replace('^', '\\^').replace('(', '\\(').replace(')', '\\)');
    }
    var rx = new RegExp('(' + str + '*$)', 'g');
    return this.replace(rx, '');
  };
  addDefineProperty(String, 'endTrim', stringPrototypeEndTrim);
  /**
   * @description 删除首尾字符
   * @param {String} str 要删除的字符, 默认删除空字符
   * @return {String} 删除后字符串
   */
  const stringPrototypeTrim = function (str) {
    if (!str) {
      str = '\\s';
    } else {
      str = str.replace('$', '\\$').replace('^', '\\^').replace('(', '\\(').replace(')', '\\)');
    }
    var rx = new RegExp('(^' + str + '*)|(' + str + '*$)', 'g');
    return this.replace(rx, '');
  };
  addDefineProperty(String, 'trim', stringPrototypeTrim);
  /**
   * @description 取文本左边
   * @param {String} str 索引的字符
   * @param {Boolean} bl 当索引字符不存在时是否保留左边
   * @return {String} 截取后的字符串
   */
  const stringPrototypeLeft = function (str, bl) {
    var i = this.indexOf(str);
    if (i == -1) {
      if (bl) {
        return this + '';
      } else {
        return '';
      }
    } else {
      return this.substring(0, i);
    }
  };
  addDefineProperty(String, 'left', stringPrototypeLeft);
  /**
   * @description 取文本右边
   * @param {String} str 索引的字符
   * @param {Boolean} bl 当索引字符不存在时是否保留右边
   * @return {String} 截取后的字符串
   */
  const stringPrototypeRight = function (str, bl) {
    var i = this.indexOf(str);
    if (i == -1) {
      if (bl) {
        return this + '';
      } else {
        return '';
      }
    } else {
      return this.substring(i + str.length);
    }
  };
  addDefineProperty(String, 'right', stringPrototypeRight);
  /**
   * @description 取文本之间
   * @param {String} str_l 索引的左边字符
   * @param {String} str_r 索引的右边字符
   * @param {Boolean} bl 当索引字符不存在时是否保留右边
   * @return {String} 截取后的字符串
   */
  const stringPrototypeBetween = function (str_l, str_r, bl) {
    var str = this.right(str_l, bl);
    return str.left(str_r, bl);
  };
  addDefineProperty(String, 'between', stringPrototypeBetween);
  /**
   * @description 替换所有字符串
   * @param {String} oldStr 被替换的字符串
   * @param {String} newStr 替换后的字符串
   * @return {String} 替换后的字符串
   */
  const stringPrototypeReplaceAll = function (oldStr, newStr) {
    var txt = this + '';
    if (!newStr) {
      newStr = '';
    }
    while (txt.indexOf(oldStr) !== -1) {
      txt = txt.replace(oldStr, newStr);
    }
    return txt;
  };
  addDefineProperty(String, 'replaceAll', stringPrototypeReplaceAll);
  /**
   * @description 验证开头字符串
   * @param {String} startStr 开头字符串
   * @return {Boolean} 验证成功返回true，失败返回false
   */
  const stringPrototypeStartWith = function (startStr) {
    var d = this.length - startStr.length;
    if (d >= 0 && this.indexOf(startStr) === 0) {
      return true;
    }
    return false;
  };
  addDefineProperty(String, 'startWith', stringPrototypeStartWith);
  /**
   * @description 验证结束字符串
   * @param {String} endStr 结尾字符串
   * @return {Boolean} 验证成功返回true，失败返回false
   */
  const stringPrototypeEndWith = function (endStr) {
    var d = this.length - endStr.length;
    if (d >= 0 && this.lastIndexOf(endStr) == d) {
      return true;
    }
    return false;
  };
  addDefineProperty(String, 'endWith', stringPrototypeEndWith);
  /**
   * @description 是否含字符串
   * @param {String} str = [word|word*|*word|*word*]字符串, 支持*号匹配, 前*表示匹配后面字符串, 后*表示匹配前面字符串, 前后*表示匹配包含字符串
   * @return {Boolean} 包含返回true, 不包含返回false
   */
  const stringPrototypeHas = function (str) {
    var o = this + '';
    if (o === str) {
      return true;
    } else if (str.startWith('*')) {
      var k = str.replaceAll('*', '');
      if (str.endWith('*')) {
        return o.indexOf(k) !== -1;
      } else {
        return o.endWith(k);
      }
    } else if (str.endWith('*')) {
      var k = str.replaceAll('*', '');
      return o.startWith(k);
    } else {
      return false;
    }
  };
  addDefineProperty(String, 'has', stringPrototypeHas);
  /**
   * @description 转为时间对象
   * @return {Date} 时间对象
   */
  const stringPrototypeToTime = function () {
    var str = this.replace('T', ' ').replace('Z', '').replaceAll('-', '/');
    return new Date(str);
  };
  addDefineProperty(String, 'toTime', stringPrototypeToTime);
  /**
   * @description 转为时间格式字符串
   * @param {String} format 转换的格式
   * @return {String} 时间格式字符串
   */
  const stringPrototypeToTimeFormat = function (format) {
    var str = this.replace('T', ' ').replace('Z', '').replaceAll('-', '/');
    return str.toTime().toStr(format);
  };
  addDefineProperty(String, 'toTimeFormat', stringPrototypeToTimeFormat);
  /**
   * @description 转为数组
   * @param {String|Regex} separator 分隔符或正则
   * @param {Number} maxLen 最大长度
   * @return {Array} 数组
   */
  const stringPrototypeToArr = function (separator, maxLen) {
    return this.split(separator, maxLen);
  };
  addDefineProperty(String, 'toArr', stringPrototypeToArr);
  /**
   * @description 转为数字
   * @param {Number} len 保留长度 ()
   * @param {String} mode 保留方式 ()
   * @return {Number} 浮点数
   */
  const stringPrototypeToNum = function (len, mode) {
    return new Number(this).get(len, mode);
  };
  addDefineProperty(String, 'toNum', stringPrototypeToNum);
  /**
   * @description 转为对象
   * @return {Object} 对象
   */
  const stringPrototypeToObj = function () {
    return eval(this + '');
  };
  addDefineProperty(String, 'toObj', stringPrototypeToObj);
  /**
   * @description 转正则表达式
   * @param {String} mode = [g|i|gi] 转换方式, g为全部, i为不区分大小写
   * @return {Regex} 返回正则对象
   */
  const stringPrototypeToRx = function (mode) {
    if (!mode) {
      mode = 'gi';
    }
    return eval('/' + this + '/' + mode);
  };
  addDefineProperty(String, 'toRx', stringPrototypeToRx);
  /**
   * @description 正则判断
   * @param {String} str 用作判断的正则
   * @param {String} mode = [g|i|gi] 转换方式, g为全部, i为不区分大小写
   * @return {Boolean} 符合正则返回true, 否则返回false
   */
  const stringPrototypeRegex = function (str, mode) {
    var rx = str.toRx(mode);
    return rx.test(this + '');
  };
  addDefineProperty(String, 'regex', stringPrototypeRegex);
  /**
   * @description 验证字符串格式
   * @param {String} format 所属格式
   * @return {Boolean} 验证通过返回true, 失败返回false
   */
  const stringPrototypeCheckFormat = function (format) {
    var bl = false;
    var value = this + '';
    var f = format.toLowerCase();
    switch (f) {
      case 'phone':
        bl = /^0?(13|14|15|16|17|18|19)[0-9]{9}$/.test(value);
        break;
      case 'email':
        bl = /^\w[-\w.+]*@([A-Za-z0-9][-A-Za-z0-9]+\.)+[A-Za-z]{2,14}$/gi.test(value);
        break;
      case 'username':
        bl = /^[a-z0-9A-Z_]+$/.test(value);
        break;
      case 'password':
        bl = /^[a-z0-9A-Z]+$/.test(value);
        break;
      case 'url':
        bl = /^((https|http|ftp|rtsp|mms)?:\/\/)[^\s]+/gi.test(value);
        break;
      case 'date':
        bl = /^\d{4}(\-|\/|\.)(0[1-9]|1[012]|[1-9])(\-|\/|\.)([12][0-9]|0[1-9]|3[01]|[1-9])$/.test(
          value
        );
        break;
      case 'time':
        bl = /^([01][0-9]|2[0-3]):([0-4][0-9]|5[0-9])(:([0-4][0-9]|5[0-9]))?$/.test(value);
        break;
      case 'datetime':
        bl =
          /^\d{4}(\-|\/|\.)(0[1-9]|1[012]|[1-9])(\-|\/|\.)([12][0-9]|0[1-9]|3[01]|[1-9]) ([01][0-9]|2[0-3]):([0-4][0-9]|5[0-9])(:([0-4][0-9]|5[0-9]))?$/.test(
            value
          );
        break;
      case 'dateiso':
        bl =
          /^\d{4}-(0[1-9]|1[012]|[1-9])-([12][0-9]|0[1-9]|3[01]|[1-9])( ([01][0-9]|2[0-3]):([0-4][0-9]|5[0-9])(:([0-4][0-9]|5[0-9]))?)?$/.test(
            value
          );
        break;
      case 'number':
        bl = /^[1-9]+[0-9]*(\.[0-9]+|[0-9]*)|0\.[0-9]+|0$/.test(value);
        break;
      case 'en':
        bl = /^[a-zA-Z]+$/.test(value);
        break;
      case 'num':
      case 'digits':
        bl = /^[0-9]+$/.test(value);
        break;
      case 'ch':
      case 'chs':
      case 'chinese':
        bl = /^[\u4e00-\u9fa5]+$/.test(value);
        break;
      default:
        console.log('输入的类型错误');
        break;
    }
    return bl;
  };
  addDefineProperty(String, 'checkFormat', stringPrototypeCheckFormat);
  /**
   * @description 编译模板
   * @param {Object} obj 对象
   * @return {String} 编译后的字符串
   */
  const stringPrototypeTpl = function (obj) {
    var text = this + '';

    function render() {
      if (obj) {
        for (var k in obj) {
          this[k] = obj[k];
        }
      }
      return eval('`' + text + '`');
    }
    return render();
  };
  addDefineProperty(String, 'tpl', stringPrototypeTpl);
})();

/* == 数组原型函数 == */
(function () {
  /**
   * @description 判断对象是否相似
   * @param {Object} obj 被判断对象
   * @param {Object} query 用作判断的对象
   * @param {Boolean} all 是否完全相同
   * @return {Boolean} 相似返回true，否则返回false
   */
  function as(obj, query, all) {
    if (obj) {
      var bl = true;
      var type = typeof obj;
      if (type !== typeof query) {
        // 如果类型不一致 则两个无相似
        bl = false;
      } else if (type === 'string' || type === 'bool' || type === 'number') {
        bl = obj === query;
      } else if (obj.constructor == Array) {
        // 如果都是数组
        var lh = obj.length;
        if (all && lh !== query.length) {
          // 要求完全一致 而长度不一致 说明不相似
          bl = false;
        } else {
          // 否则判断数组里的每个成员是否相似
          for (var i = 0; i < lh; i++) {
            if (!as(obj[i], query[i])) {
              bl = false;
              break;
            }
          }
        }
      } else {
        // 如果类型为对象
        if (
          all &&
          Object.getOwnPropertyNames(obj).length !== Object.getOwnPropertyNames(query).length
        ) {
          // 如果要求完全一致, 而属性长度不一致，则不相似
          bl = false;
        } else {
          // 否则都为对象则判断其值是否一致
          for (var k in query) {
            if (!as(obj[k], query[k], all)) {
              bl = false;
              break;
            }
          }
        }
      }
      return bl;
    } else {
      return false;
    }
  }

  /**
   * 列表转树形列表
   * @param {Array} list 列表
   * @param {String} id ID字段
   * @param {Number} value ID对应值
   * @param {String} father_id 上级ID字段
   * @param {String} sub 子类字段
   * @return {Array} 返回属性值
   */
  function toTree(list, id, value = 0, father_id = 'father_id', sub = 'sub') {
    var arr = [];
    for (var i = 0; i < list.length; i++) {
      var o = list[i];
      if (o[father_id] === value) {
        o[sub] = toTree(list, id, o[id], father_id, sub);
        arr.push(o);
      }
    }
    return arr;
  }

  function toList(list, sub = 'sub', arr = []) {
    for (var i = 0; i < list.length; i++) {
      var o = list[i];
      var lt = o[sub];
      delete o[sub];
      arr.push(o);
      if (lt && lt.length > 0) {
        toList(lt, sub, arr);
      }
    }
    return arr;
  }

  /**
   * 列表转树形列表
   * @param {String} id ID字段
   * @param {Number} value ID对应值
   * @param {String} father_id 上级ID字段
   * @param {String} sub 子类字段
   * @return {Array} 返回数组
   */
  const prototypeToTree = function (id, value = 0, father_id = 'father_id', sub = 'sub') {
    return toTree(this, id, value, father_id, sub);
  };
  addDefineProperty(Array, 'toTree', prototypeToTree);

  /**
   * 列表转树形列表
   * @param {String} sub 子类字段
   * @param {Array} arr 结果数组
   * @return {Array} 返回数组
   */
  const prototypetoList = function (sub = 'sub', arr = []) {
    return toList(this, sub, arr);
  };
  addDefineProperty(Array, 'toList', prototypetoList);

  /**
   * @description 拷贝对象
   * @param {Boolean} has 是否非空拷贝，如果含有数据才拷贝，不含数据不拷贝
   * @return {Array} 新数组
   */
  const prototypeCopy = function (has) {
    var arr_new = [];
    var arr = this;
    if (has) {
      for (var i = 0; i < arr.length; i++) {
        var o = arr[i];
        if (o) {
          arr_new[i] = o;
        }
      }
    } else {
      for (var i = 0; i < arr.length; i++) {
        arr_new[i] = arr[i];
      }
    }
    return arr_new;
  };
  addDefineProperty(Array, 'copy', prototypeCopy);
  /**
   * @description 遍历对象执行函数
   * @param {Function(Object):Boolean} func 函数名
   */
  const prototypeFunc = function (func) {
    for (var i = 0; i < this.length; i++) {
      if (func(this[i])) {
        break;
      }
    }
  };

  addDefineProperty(Array, 'func', prototypeFunc);
  /**
   * @description 数组转字符串
   * @param {String} splitStr 分隔符
   * @param {String} key 对象属性名
   * @return {String} 字符串
   */
  const prototypeToStr = function (splitStr = ',', key) {
    var arr = this;
    var str = '';
    if (key) {
      for (var i = 0; i < arr.length; i++) {
        var o = arr[i];
        if (o[key]) {
          str += splitStr + o[key];
        }
      }
    } else {
      for (var i = 0; i < arr.length; i++) {
        var o = arr[i];
        str += splitStr + o;
      }
    }
    return str.replace(splitStr, '');
  };

  addDefineProperty(Array, 'toStr', prototypeToStr);

  /**
   * @description 清空数组
   * @return {Array} 清空的数组
   */
  const prototypeClear = function () {
    this.splice(0, this.length);
    return this;
  };

  addDefineProperty(Array, 'clear', prototypeClear);
  /**
   * @description 修改数组成员
   * @param {Object} query 搜索条件
   * @param {Object} obj 修改项
   * @return {Array} 删除后的数组
   */
  const prototypeSet = function (query, obj) {
    for (var i = 0; i < this.length; i++) {
      var o = this[i];
      for (var k in query) {
        if (as(o, query)) {
          this[i] = obj;
        }
      }
    }
    return this;
  };
  addDefineProperty(Array, 'set', prototypeSet);
  /**
   * @description 数组列表取数组
   * @param {String} key 取的属性
   * @return {Array} 截取的数组
   */
  const prototypeToArr = function (key) {
    var arr = [];
    var lt = this;
    var len = lt.length;
    for (var i = 0; i < len; i++) {
      var o = lt[i];
      arr.push(o[key]);
    }
    return arr;
  };
  addDefineProperty(Array, 'toArr', prototypeToArr);
  /**
   * @description 从数组获取对象
   * @param {Object} query 查询条件
   * @param {Boolean} end 是否结束
   * @return {Object} 对象
   */
  const prototypeGet = function (query, end) {
    if (query) {
      if (end) {
        var obj;
        for (var i = 0; i < this.length; i++) {
          var o = this[i];
          if (as(o, query)) {
            obj = o;
            break;
          }
        }
        return obj;
      } else {
        var list = [];
        for (var i = 0; i < this.length; i++) {
          var o = this[i];
          if (as(o, query)) {
            list.push(o);
          }
        }
        return list;
      }
    } else {
      var list = [];
      list.addList(this);
      return list;
    }
  };
  addDefineProperty(Array, 'get', prototypeGet);
  /**
   * @description 从数组获取对象
   * @param {Object} query 查询条件
   * @return {Object} 对象
   */
  const prototypeGetObj = function (query) {
    var obj;
    if (query) {
      for (var i = 0; i < this.length; i++) {
        var o = this[i];
        if (as(o, query)) {
          obj = o;
          break;
        }
      }
    }
    return obj;
  };
  addDefineProperty(Array, 'getObj', prototypeGetObj);
  /**
   * @description 获取数组对象的属性值
   * @param {String} key 属性名
   * @param {Object} query 查询条件
   * @return {Object} 属性值
   */
  const prototypeGetVal = function (key, query) {
    var obj = this.getObj(query);
    if (obj) {
      return obj[key];
    } else {
      return null;
    }
  };
  addDefineProperty(Array, 'getVal', prototypeGetVal);
  /**
   * @description 获取符合条件的数组对象
   * @param {Object} query 查询条件
   * @return {Array} 对象数组
   */
  const prototypeGetList = function (query) {
    var arr = [];
    if (query) {
      for (var i = 0; i < this.length; i++) {
        var o = this[i];
        if (as(o, query)) {
          arr.push(o);
        }
      }
    } else {
      arr = this.copy();
    }
    return arr;
  };
  addDefineProperty(Array, 'getList', prototypeGetList);
  /**
   * @description 获取数组所有对象的属性值
   * @param {String} key 属性名
   * @param {Object} query 查询条件
   * @return {Array} 属性值数组
   */
  const prototypeGetArr = function (key, query) {
    var arr = [];
    if (query) {
      for (var i = 0; i < this.length; i++) {
        var o = this[i];
        if (as(o, query)) {
          arr.push(o[key]);
        }
      }
    } else {
      for (var i = 0; i < this.length; i++) {
        var o = this[i];
        arr.push(o[key]);
      }
    }
    return arr;
  };
  addDefineProperty(Array, 'getArr', prototypeGetArr);
  /**
   * @description 给数组对象添加属性值
   * @param {String} key 属性名
   * @param {Object} value 属性值
   * @param {Object} query 查询条件
   * @param {Boolean} end 是否中断循环,中断只添加给第一个符合条件的对象
   * @return {Array} 对象数组
   */
  const prototypeAddVal = function (key, value, query, end) {
    if (query) {
      for (var i = 0; i < this.length; i++) {
        var o = this[i];
        if (as(o, query)) {
          if (!o[key]) {
            o[key] = value;
            if (end) {
              break;
            }
          }
        }
      }
    } else {
      for (var i = 0; i < this.length; i++) {
        var o = this[i];
        if (!o[key]) {
          o[key] = value;
          if (end) {
            break;
          }
        }
      }
    }
    return this;
  };
  addDefineProperty(Array, 'addVal', prototypeAddVal);
  /**
   * @description 给数组添加对象
   * @param {Object} obj 对象
   * @param {Object} query 查询条件
   * @return {Array} 对象数组
   */
  const prototypeAddObj = function (obj, query) {
    var has = false;
    if (query) {
      for (var i = 0; i < this.length; i++) {
        if (as(this[i], query)) {
          has = true;
          break;
        }
      }
    } else {
      for (var i = 0; i < this.length; i++) {
        if (as(this[i], obj)) {
          has = true;
          break;
        }
      }
    }
    if (!has) {
      this.push(obj);
    }
    return this;
  };
  addDefineProperty(Array, 'addObj', prototypeAddObj);
  /**
   * @description 给数组添加多个对象
   * @param {Array} list 数组
   * @param {Object} query 查询条件
   * @return {Array} 对象数组
   */
  const prototypeAddList = function (list, query) {
    var len = list.length;
    for (var i = 0; i < len; i++) {
      this.addObj(list[i], query);
    }
    return this;
  };
  addDefineProperty(Array, 'addList', prototypeAddList);
  /**
   * @description 给数组添加一个对象或列表
   * @param {Object|Array} objOrList 对象或数组
   * @param {Object} query 查询条件
   * @return {Array} 对象数组
   */
  const prototypeAdd = function (objOrList, query) {
    if (Array.isArray(objOrList)) {
      this.addList(objOrList, query);
    } else {
      this.addObj(objOrList, query);
    }
    return this;
  };
  addDefineProperty(Array, 'add', prototypeAdd);
  /**
   * @description 删除数组中对象的属性
   * @param {String} key 对象属性键
   * @param {Object} query 查询条件
   * @param {Boolean} end 是否中断循环,中断只删除第一个符合条件的对象
   * @return {Array} 对象数组
   */
  const prototypeDelVal = function (key, query, end) {
    if (query) {
      if (end) {
        for (var i = 0; i < this.length; i++) {
          var o = this[i];
          if (as(o, query)) {
            delete o[key];
            break;
          }
        }
      } else {
        for (var i = 0; i < this.length; i++) {
          var o = this[i];
          if (as(o, query)) {
            delete o[key];
          }
        }
      }
    } else {
      if (end) {
        delete this[0][key];
      } else {
        for (var i = 0; i < this.length; i++) {
          var o = this[i];
          delete o[key];
        }
      }
    }
    return this;
  };
  addDefineProperty(Array, 'delVal', prototypeDelVal);
  /**
   * @description 删除数组中的对象
   * @param {Object} query 查询条件
   * @param {Boolean} end 是否中断循环,中断只删除第一个符合条件的对象
   * @return {Array} 对象数组
   */
  const prototypeDel = function (query, end) {
    var bl = false;
    if (end) {
      if (query) {
        for (var i = 0; i < this.length; i++) {
          if (as(this[i], query)) {
            this.splice(i, 1);
            break;
          }
        }
      } else {
        for (var i = 0; i < this.length; i++) {
          this.splice(i, 1);
          break;
        }
      }
    } else {
      if (query) {
        for (var i = this.length - 1; i >= 0; i--) {
          if (as(this[i], query)) {
            this.splice(i, 1);
          }
        }
      } else {
        for (var i = this.length - 1; i >= 0; i--) {
          this.splice(i, 1);
        }
      }
    }
    return this;
  };
  addDefineProperty(Array, 'del', prototypeDel);
  /**
   * @description 删除多个不同的数组成员
   * @param {Array} list 查询条件列表
   * @param {Boolean} end 是否中断循环,中断只删除第一个符合条件的对象
   * @return {Array} 对象数组
   */
  const prototypeDelList = function (list, end) {
    var len = list.length;
    for (var i = 0; i < len; i++) {
      this.del(list[i], end);
    }
    return this;
  };
  addDefineProperty(Array, 'delList', prototypeDelList);
  /**
   * @description 设置数组中对象的属性值
   * @param {String} key 属性键
   * @param {Object} value 属性值
   * @param {Object} query 查询条件
   * @param {Boolean} end 是否中断循环,中断只修改第一个符合条件的对象
   * @return {Array} 对象数组
   */
  const prototypeSetVal = function (key, value, query, end) {
    if (query) {
      for (var i = 0; i < this.length; i++) {
        if (as(this[i], query)) {
          this[i][key] = value;
          if (end) {
            break;
          }
        }
      }
    } else {
      for (var i = 0; i < this.length; i++) {
        this[i][key] = value;
        if (end) {
          break;
        }
      }
    }
    return this;
  };
  addDefineProperty(Array, 'setVal', prototypeSetVal);
  /**
   * @description 设置数组中对象的属性值
   * @param {Object} obj 对象
   * @param {Object} query 查询条件
   * @param {Boolean} end 是否中断循环,中断只修改第一个符合条件的对象
   * @return {Array} 对象数组
   */
  const prototypeSetObj = function (obj, query, end) {
    if (query) {
      for (var i = 0; i < this.length; i++) {
        var o = this[i];
        if (as(o, query)) {
          this[i] = obj;
          if (end) {
            break;
          }
        }
      }
    }
    return this;
  };
  addDefineProperty(Array, 'setObj', prototypeSetObj);
  /**
   * @description 设置数组中对象的属性值
   * @param {Array} list 对象列表
   * @param {Object} query 查询条件
   * @param {Boolean} end 是否中断循环,中断只修改第一个符合条件的对象
   * @return {Array} 对象数组
   */
  const prototypeSetList = function (list, query, end) {
    for (var i = 0; i < this.length; i++) {
      this.setObj(this[i], query, end);
    }
  };
  addDefineProperty(Array, 'setList', prototypeSetList);
  /**
   * @description 搜索符合条件的成员
   * @param {String} str 搜索关键词
   * @param {String} key 主键, 用于列表数组时
   * @return {Array} 返回符合条件的结果
   */
  const prototypeSearch = function (str, key) {
    var arr = [];
    var func;
    var k = str.replaceAll('*', '');
    if (str.startWith('*')) {
      if (str.endWith('*')) {
        if (key) {
          func = function (o) {
            if (o[key].indexOf(k) !== -1) {
              arr.push(o);
            }
          };
        } else {
          func = function (o) {
            if (o.indexOf(k) !== -1) {
              arr.push(o);
            }
          };
        }
      } else {
        if (key) {
          func = function (o) {
            if (o[key].endWith(k)) {
              arr.push(o);
            }
          };
        } else {
          func = function (o) {
            if (o.endWith(k)) {
              arr.push(o);
            }
          };
        }
      }
    } else if (str.endWith('*')) {
      if (key) {
        func = function (o) {
          if (o[key].startWith(k)) {
            arr.push(o);
          }
        };
      } else {
        func = function (o) {
          if (o.startWith(k)) {
            arr.push(o);
          }
        };
      }
    } else {
      if (key) {
        func = function (o) {
          if (o[key] === k) {
            arr.push(o);
          }
        };
      } else {
        func = function (o) {
          if (o === k) {
            arr.push(o);
          }
        };
      }
    }
    this.map(func);
    return arr;
  };
  addDefineProperty(Array, 'search', prototypeSearch);
  /**
   * @description 判断是否包含成员
   * @param {Object} query 查询条件
   * @return {Boolean} 有则返回true，没有则返回false
   */
  const prototypeHas = function (query) {
    var has = false;
    for (var i = 0; i < this.length; i++) {
      if (as(this[i], query)) {
        has = true;
        break;
      }
    }
    return has;
  };
  addDefineProperty(Array, 'has', prototypeHas);
  /**
   * @description 取含匹配项
   * @param {String} str 被匹配的字符串
   * @param {String} key 用于对象列表时查询
   * @return {Object} 返回匹配的第一项
   */
  const prototypeGetMatch = function (str, key) {
    var obj;
    if (key) {
      for (var i = 0; i < this.length; i++) {
        if (str.has(this[i][key])) {
          obj = this[i];
          break;
        }
      }
    } else {
      for (var i = 0; i < this.length; i++) {
        if (str.has(this[i])) {
          obj = this[i];
          break;
        }
      }
    }
    return obj;
  };
  addDefineProperty(Array, 'getMatch', prototypeGetMatch);
  /**
   * @description 数组转对象
   * @param {String} key 主键, 用作对象索引
   * @return {Object} 对象
   */
  const prototypeToObj = function (key) {
    var obj = {};
    this.map(function (o) {
      var name = o[key];
      if (name) {
        obj[name] = o;
      }
    });
    return obj;
  };
  addDefineProperty(Array, 'toObj', prototypeToObj);
})();

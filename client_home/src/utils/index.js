// 把数组转成对像
export function transferObj(arr) {
  const obj = {};
  arr.forEach(function (v, i) {
    obj[i] = v;
  });
  return obj;
}

// 把对像转成数组
export function transferArr(obj) {
  const arr = [];
  for (const key in obj) {
    arr.push(obj[key]);
  }
  return arr;
}

// 字符串分割成数组 str 字符串
export function splitStr(str) {
  if (str) {
    return str.split(' ')[0];
  } else {
    return false;
  }
}

// // 在事件被触发n秒后再执行回调，如果在这n秒内又被触发，则重新计时。函数防抖是某一段时间内只执行一次
// export function debounce(fun, delay) {
//   return function(args) {
//     const that = this;
//     const _args = args;
//     clearTimeout(fun.id);
//     fun.id = setTimeout(() => {
//       fun.call(that, _args);
//     }, delay);
//   };
// }

// // 规定在一个单位时间内，只能触发一次函数。如果这个单位时间内触发多次函数，只有一次生效。函数节流是间隔时间执行
// export function throttle(fn, delay) {
//   let timer = true;
//   return function(args) {
//     const that = this;
//     const _args = arguments;
//     if (!timer) {
//       return false;
//     }
//     timer = false;
//     setTimeout(() => {
//       fn.apply(that, _args);
//       timer = true;
//     }, delay);
//   };
// }

/**
 * @desc 函数防抖
 * @param func 目标函数
 * @param wait 延迟执行毫秒数
 * @param immediate true - 立即执行， false - 延迟执行
 */
export const debounce = function (func, wait = 1000, immediate = true) {
  let timer;

  return function () {
    console.log(123);
    let context = this,
      args = arguments;
    if (timer) clearTimeout(timer);
    if (immediate) {
      let callNow = !timer;
      timer = setTimeout(() => {
        timer = null;
      }, wait);
      if (callNow) func.apply(context, args);
    } else {
      timer = setTimeout(() => {
        func.apply(context, args);
      }, wait);
    }
  };
};
/**
 * @desc 函数节流
 * @param func 函数
 * @param wait 延迟执行毫秒数
 * @param type 1 使用表时间戳，在时间段开始的时候触发 2 使用表定时器，在时间段结束的时候触发
 */
export const throttle = (func, wait = 1000, type = 1) => {
  let previous = 0;
  let timeout;
  return function () {
    let context = this;
    let args = arguments;
    if (type === 1) {
      let now = Date.now();

      if (now - previous > wait) {
        func.apply(context, args);
        previous = now;
      }
    } else if (type === 2) {
      if (!timeout) {
        timeout = setTimeout(() => {
          timeout = null;
          func.apply(context, args);
        }, wait);
      }
    }
  };
};

/**
 * 获取页面路由包名路径
 * @param {*} source_table 
 * @returns 
 */
export const getRouteBasePath = (source_table) => {
  let basePath = '/pagesC/';
  if (source_table == 'forum') {
    basePath = '/pagesA/';
  }
  if (source_table == 'goods') {
    basePath = '/pagesA/';
  }

  if (source_table == 'article') {
    basePath = '/pages/';
  }

  return basePath
}
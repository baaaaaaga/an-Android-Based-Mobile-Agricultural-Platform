import store from '@/store';

function getAuth(path) {
  const userAuth = store.state.app && store.state.app.userAuth;
  const o = userAuth.find((item) => item.path === path);
  return o;
}

/**
 * 判断是否具备操作权限 鉴权
 * @param {String} action 操作名
 * @param {String} path 路径
 * @returns
 */
function checkAction(path, action) {
  if (path && path.length > 0) {
    const o = getAuth(path);
    if (!o) {
      let index = path.lastIndexOf('/');
      let path_last = path.substring(index + 1, path.length);
      if (path_last === 'edit') {
        return false;
      }
      return true;
    }
    if (['add', 'set', 'del', 'get'].indexOf(action) !== -1 && o[action] != 0) {
      return o[action];
    } else if (o.option) {
      const option = JSON.parse(o.option);
      return option[action];
    } else {
      return false;
    }
  } else {
    return false;
  }
}

/**
 * 获取路径对应操作权限 鉴权
 * @param {String} op 操作名
 */
function checkOption(path, op) {
  const o = getAuth(path);
  if (o) {
    const option = JSON.parse(o.option);
    if (option[op]) return true;
  }
  return false;
}

/**
 * 是否有显示或操作字段的权限
 * @param {String} action 操作名
 * @param {String} field 查询的字段
 * @returns
 */
function checkField(action, field) {
  const routes = getCurrentPages();
  const curRoute = routes[routes.length - 1].route; //获取当前页面路由
  const path = curRoute.replace(/pages/, '');
  const o = getAuth(path);
  let auth;
  if (o && o[action]) {
    auth = o['field_' + action];
  }
  if (auth) {
    return auth.indexOf(field) !== -1;
  }
  return false;
}

/**
 * 是否有显示或操作字段的权限
 * @param {String} action 操作名
 * @param {String} field 查询的字段
 * @param {String} path 路径
 */
function checkIndexField(action, field, path) {
  const o = getAuth(path);
  let auth;
  if (o && o[action]) {
    auth = o['field_' + action];
  }
  if (auth) {
    return auth.indexOf(field) !== -1;
  }
  return false;
}

/**
 * 获取路径对应操作权限 鉴权
 * @param {String} action 操作名
 */
function checkExam(path, action = 'get') {
  const routes = getCurrentPages();
  const curRoute = routes[routes.length - 1].route; //获取当前页面路由
  var path = curRoute.replaceAll('pages', '');
  const o = getAuth(path);
  if (o) {
    var option = JSON.parse(o.option);
    if (option[action]) return true;
  }
  return false;
}

/**
 * 是否有支付字段的权限
 */
function checkPay() {
  const routes = getCurrentPages();
  const curRoute = routes[routes.length - 1].route; //获取当前页面路由
  var path = curRoute.replaceAll('pages', '');
  const o = getAuth(path);
  if (o) {
    var option = JSON.parse(o.option);
    if (option.pay) return true;
  }
  return false;
}

/**
 * 是否有审核字段的权限
 */
function checkExamine() {
  const routes = getCurrentPages();
  const curRoute = routes[routes.length - 1].route; //获取当前页面路由
  let index = curRoute.lastIndexOf('/');
  let path_pre = curRoute.substring(0, index + 1);
  let path_last = curRoute.substring(index + 1, curRoute.length);
  path_pre = path_pre.replace('pages', '');
  path_last = path_last.replace('view', 'table').replace('edit', 'table');
  const path = path_pre + path_last;
  const o = getAuth(path);
  if (o) {
    const option = JSON.parse(o.option);
    if (option.examine) return true;
  }
  return false;
}

/**
 * 是否有审核字段的权限
 */
function checkCartPage(path) {
  const o = getAuth(path);
  if (o) {
    const option = JSON.parse(o.option);
    if (option.cart_page) return true;
  }
  return false;
}

/**
 * 注册时是否有显示或操作字段的权限
 * @param {String} action 操作名
 * @param {String} field 查询的字段
 * @param {String} path 路径
 */
function checkRegisterField(action, field, path) {
  const o = getAuth(path);
  let auth;
  if (o && o[action] != 0 && o[action] != false) {
    auth = o['field_' + action];
  }
  if (auth) {
    return auth.indexOf(field) !== -1;
  }
  return false;
}

function authRole(role) {
  const admin = '管理员';
  const roles = store.state.app && store.state.app.userGroup;
  if (role && role.length > 0) {
    return roles.some((v) => {
      return admin === v || v === role;
    });
  } else {
    return false;
  }
}

export default {
  // 验证用户是否具备某角色
  hasRole(role) {
    return authRole(role);
  },
  // 验证用户是否含有指定角色，只需包含其中一个
  hasRoleOr(roles) {
    return roles.some((item) => {
      return authRole(item);
    });
  },
  // 验证用户是否含有指定角色，必须全部拥有
  hasRoleAnd(roles) {
    return roles.every((item) => {
      return authRole(item);
    });
  },
};

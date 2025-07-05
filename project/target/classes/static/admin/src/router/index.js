import Vue from 'vue';
import VueRouter from 'vue-router';
import index from '../views/index.vue';
import login from '../views/login.vue';
import forgot from '../views/forgot.vue';
import register from '../views/register.vue';
Vue.use(VueRouter)

const routes = [
    // 主页
    {
        path: '/',
        name: 'index',
        component: index,
        meta: {
            index: 0,
            title: '首页'
        }
    },

    // 登录
    {
        path: '/login',
        name: 'login',
        component: login,
        meta: {
            index: 0,
            title: '登录'
        }
    },

            // 注册
        {
            path: '/register',
            name: 'register',
            component: register,
            meta: {
                index: 0,
                title: '注册'
            }
        },
    	
	
    // 忘记密码
    {
        path: '/forgot',
        name: "forgot",
        component: forgot,
        meta: {
            index: 0,
            title: '忘记密码'
        }
    },

    // 修改密码
    {
        path: '/user/password',
        name: "password",
        component: () => import("../views/user/password.vue"),
        meta: {
            index: 0,
            title: '修改密码'
        }
    },

    // 视频播放页
    {
        path: "/media/video",
        name: "video",
        component: () => import('../views/media/video.vue'),
        meta: {
            index: 0,
            title: "视频"
        }
    },

    // 音频播放页
    {
        path: "/media/audio",
        name: "audio",
        component: () => import('../views/media/audio.vue'),
        meta: {
            index: 0,
            title: "音频"
        }
    },

    
    
                // 轮播图路由
        {
            path: '/slides/table',
            name: 'slides_table',
            component: () => import('../views/slides/table.vue'),
            meta: {
                index: 0,
                title: '轮播图列表'
            }
        },
        {
            path: '/slides/view',
            name: 'slides_view',
            component: () => import('../views/slides/view.vue'),
            meta: {
                index: 0,
                title: '轮播图详情'
            }
        },
                    // 文章路由
            {
                path: '/article/table',
                name: 'article_table',
                component: () => import('../views/article/table.vue'),
                meta: {
                    index: 0,
                    title: '农业知识列表'
                }
            },
            {
                path: '/article/view',
                name: 'article_view',
                component: () => import('../views/article/view.vue'),
                meta: {
                    index: 0,
                    title: '农业知识详情'
                }
            },

            // 文章分类路由
            {
                path: '/article_type/table',
                name: 'article_type_table',
                component: () => import('../views/article_type/table.vue'),
                meta: {
                    index: 0,
                    title: '农业知识分类列表'
                }
            },
            {
                path: '/article_type/view',
                name: 'article_type_view',
                component: () => import('../views/article_type/view.vue'),
                meta: {
                    index: 0,
                    title: '农业知识分类详情'
                }
            },
                            
            // 留言板路由
        {
            path: '/message/table',
            name: 'message_table',
            component: () => import('../views/message/table.vue'),
            meta: {
                index: 0,
                title: '留言投诉列表'
            }
        },
        {
            path: '/message/view',
            name: 'message_view',
            component: () => import('../views/message/view.vue'),
            meta: {
                index: 0,
                title: '留言投诉详情'
            }
        },
    
            // 论坛路由
        {
            path: '/forum/table',
            name: 'forum_table',
            component: () => import('../views/forum/table.vue'),
            meta: {
                index: 0,
                title: '论坛列表'
            }
        },
        {
            path: '/forum/view',
            name: 'forum_view',
            component: () => import('../views/forum/view.vue'),
            meta: {
                index: 0,
                title: '论坛详情'
            }
        },

        // 论坛分类路由
        {
            path: '/forum_type/table',
            name: 'forum_type_table',
            component: () => import('../views/forum_type/table.vue'),
            meta: {
                index: 0,
                title: '论坛分类列表'
            }
        },
        {
            path: '/forum_type/view',
            name: 'forum_type_view',
            component: () => import('../views/forum_type/view.vue'),
            meta: {
                index: 0,
                title: '论坛分类详情'
            }
        },
    
            	            {
            path: '/goods_type/table',
            name: 'goods_type_table',
            component: () => import('../views/goods_type/table.vue'),
            meta: {
                index: 0,
                title: '商品分类列表'
            }
        },
        {
            path: '/goods_type/view',
            name: 'goods_type_view',
            component: () => import('../views/goods_type/view.vue'),
            meta: {
                index: 0,
                title: '商品分类详情'
            }
        },

        // 订单路由
        {
            path: '/order/table',
            name: 'order_table',
            component: () => import('../views/order/table.vue'),
            meta: {
                index: 0,
                title: '订单列表'
            }
        },
        {
            path: '/order/view',
            name: 'order_view',
            component: () => import('../views/order/view.vue'),
            meta: {
                index: 0,
                title: '订单详情'
            }
        },
                // 订单配送路由
        {
            path: '/logistics_delivery/table',
            name: 'logistics_delivery_table',
            component: () => import('../views/logistics_delivery/table.vue'),
            meta: {
                index: 0,
                title: '订单配送列表'
            }
        },
        {
            path: '/logistics_delivery/view',
            name: 'logistics_delivery_view',
            component: () => import('../views/logistics_delivery/view.vue'),
            meta: {
                index: 0,
                title: '订单配送详情'
            }
        },
                        {
            path: '/coupon/table', name: 'coupon_table', component: () => import('../views/coupon/table.vue'), meta: {
                index: 0, title: '优惠券列表'
            }
        },
        {
            path: '/coupon/view', name: 'coupon_view', component: () => import('../views/coupon/view.vue'), meta: {
                index: 0, title: '添加优惠券'
            }
        },
                            
            // 评论路由
        {
            path: '/comment/table',
            name: 'comment_table',
            component: () => import('../views/comment/table.vue'),
            meta: {
                index: 0,
                title: '评论列表'
            }
        },
        {
            path: '/comment/view',
            name: 'comment_view',
            component: () => import('../views/comment/view.vue'),
            meta: {
                index: 0,
                title: '评论详情'
            }
        },
        	            // 农户商家路由
        {
            path: '/farmers_merchants/table',
            name: 'farmers_merchants_table',
            component: () => import('../views/farmers_merchants/table.vue'),
            meta: {
                index: 0,
                title: '农户商家列表'
            }
        },
        {
            path: '/farmers_merchants/view',
            name: 'farmers_merchants_view',
            component: () => import('../views/farmers_merchants/view.vue'),
            meta: {
                index: 0,
                title: '农户商家详情'
            }
        },
						            // 消费者路由
        {
            path: '/consumer/table',
            name: 'consumer_table',
            component: () => import('../views/consumer/table.vue'),
            meta: {
                index: 0,
                title: '消费者列表'
            }
        },
        {
            path: '/consumer/view',
            name: 'consumer_view',
            component: () => import('../views/consumer/view.vue'),
            meta: {
                index: 0,
                title: '消费者详情'
            }
        },
						            // 农产品路由
        {
            path: '/agricultural_products/table',
            name: 'agricultural_products_table',
            component: () => import('../views/agricultural_products/table.vue'),
            meta: {
                index: 0,
                title: '农产品列表'
            }
        },
        {
            path: '/agricultural_products/view',
            name: 'agricultural_products_view',
            component: () => import('../views/agricultural_products/view.vue'),
            meta: {
                index: 0,
                title: '农产品详情'
            }
        },
						            // 产地展示路由
        {
            path: '/origin_display/table',
            name: 'origin_display_table',
            component: () => import('../views/origin_display/table.vue'),
            meta: {
                index: 0,
                title: '产地展示列表'
            }
        },
        {
            path: '/origin_display/view',
            name: 'origin_display_view',
            component: () => import('../views/origin_display/view.vue'),
            meta: {
                index: 0,
                title: '产地展示详情'
            }
        },
						            // 产地类型路由
        {
            path: '/type_of_place_of_origin/table',
            name: 'type_of_place_of_origin_table',
            component: () => import('../views/type_of_place_of_origin/table.vue'),
            meta: {
                index: 0,
                title: '产地类型列表'
            }
        },
        {
            path: '/type_of_place_of_origin/view',
            name: 'type_of_place_of_origin_view',
            component: () => import('../views/type_of_place_of_origin/view.vue'),
            meta: {
                index: 0,
                title: '产地类型详情'
            }
        },
						            // 互动咨询路由
        {
            path: '/interactive_consultation/table',
            name: 'interactive_consultation_table',
            component: () => import('../views/interactive_consultation/table.vue'),
            meta: {
                index: 0,
                title: '互动咨询列表'
            }
        },
        {
            path: '/interactive_consultation/view',
            name: 'interactive_consultation_view',
            component: () => import('../views/interactive_consultation/view.vue'),
            meta: {
                index: 0,
                title: '互动咨询详情'
            }
        },
						            // 咨询回复路由
        {
            path: '/consultation_reply/table',
            name: 'consultation_reply_table',
            component: () => import('../views/consultation_reply/table.vue'),
            meta: {
                index: 0,
                title: '咨询回复列表'
            }
        },
        {
            path: '/consultation_reply/view',
            name: 'consultation_reply_view',
            component: () => import('../views/consultation_reply/view.vue'),
            meta: {
                index: 0,
                title: '咨询回复详情'
            }
        },
						            // 生产计划路由
        {
            path: '/production_planning/table',
            name: 'production_planning_table',
            component: () => import('../views/production_planning/table.vue'),
            meta: {
                index: 0,
                title: '生产计划列表'
            }
        },
        {
            path: '/production_planning/view',
            name: 'production_planning_view',
            component: () => import('../views/production_planning/view.vue'),
            meta: {
                index: 0,
                title: '生产计划详情'
            }
        },
						            // 经验分享路由
        {
            path: '/experience_sharing/table',
            name: 'experience_sharing_table',
            component: () => import('../views/experience_sharing/table.vue'),
            meta: {
                index: 0,
                title: '经验分享列表'
            }
        },
        {
            path: '/experience_sharing/view',
            name: 'experience_sharing_view',
            component: () => import('../views/experience_sharing/view.vue'),
            meta: {
                index: 0,
                title: '经验分享详情'
            }
        },
						            // 分享类型路由
        {
            path: '/share_type/table',
            name: 'share_type_table',
            component: () => import('../views/share_type/table.vue'),
            meta: {
                index: 0,
                title: '分享类型列表'
            }
        },
        {
            path: '/share_type/view',
            name: 'share_type_view',
            component: () => import('../views/share_type/view.vue'),
            meta: {
                index: 0,
                title: '分享类型详情'
            }
        },
						    	    // 用户路由
    {
        path: '/user/table',
        name: 'user_table',
        component: () => import('../views/user/table.vue'),
        meta: {
            index: 0,
            title: '用户列表'
        }
    },
    {
        path: '/user/view',
        name: 'user_view',
        component: () => import('../views/user/view.vue'),
        meta: {
            index: 0,
            title: '用户详情'
        }
    },
    {
        path: '/user/info',
        name: 'user_info',
        component: () => import('../views/user/info.vue'),
        meta: {
            index: 0,
            title: '个人信息'
        }
    },
    // 用户组路由
    {
        path: '/user_group/table',
        name: 'user_group_table',
        component: () => import('../views/user_group/table.vue'),
        meta: {
            index: 0,
            title: '用户组列表'
        }
    },
    {
        path: '/user_group/view',
        name: 'user_group_view',
        component: () => import('../views/user_group/view.vue'),
        meta: {
            index: 0,
            title: '用户组详情'
        }
    }
]

const router = new VueRouter({
    mode: 'hash',
    base: process.env.BASE_URL,
    routes
})

router.beforeEach((to, from, next) => {
    let token = to.query.token;
    if (token) {
        $.db.set("token", token, 120);
    }
    next();
})

router.afterEach((to, from, next) => {
    let title = "农产品市场平台-admin";
    document.title = title;
})

export default router

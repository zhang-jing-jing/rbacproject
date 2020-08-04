import Vue from "vue";
import VueRouter from "vue-router";
import login from "../views/login.vue";
import manage from "../views/manage.vue"

Vue.use(VueRouter);

const routes = [
  {
    path: "/",
    name: "login",
    component: login
  },
  {
    path:'/manage',
    component:manage,
    children:[
      {
        path: "/user-manage",
        name: "userManage",
        component: () =>
          import("../views/user-manage.vue")
      },
      {
        path: "/role-manage",
        name: "roleManage",
        component: () =>
          import("../views/role-manage.vue")
      },
      {
        path: "/permission-manage",
        name: "permissionManage",
        component: () =>
          import("../views/permission-manage.vue")
      },
    ]
  }
];

const router = new VueRouter({
  mode: "history",
  base: process.env.BASE_URL,
  routes
});

export default router;

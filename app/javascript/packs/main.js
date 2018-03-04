import Vue from 'vue/dist/vue.esm'

import ElementUI from 'element-ui'
import locale from 'element-ui/lib/locale/lang/ja'
import 'element-ui/lib/theme-chalk/index.css'

import 'font-awesome/css/font-awesome.min.css'

//import Header from '../components/header.vue'
//import Hello from 'home/hello.vue'
import App from './App'

import VueRouter from 'vue-router'
import routes from './router'

//APIのモック
import Mock from './mock'
Mock.bootstrap();


Vue.use(ElementUI, {locale})

Vue.use(VueRouter)
const router = new VueRouter({
  routes,
  scrollBehavior (to, from, savedPosition) {
    // 戻る、進むの遷移時にスクロール位置をキープ
    if (savedPosition) {
      return savedPosition
    } else {
      return { x: 0, y: 0 }
    }
  }
})

//セッションチェック
router.beforeEach((to, from, next) => {
  //NProgress.start();
  if (to.path == '/login') {
    sessionStorage.removeItem('user');
  }
  let user = JSON.parse(sessionStorage.getItem('user'));
  if (!user && to.path != '/login') {
    next({ path: '/login' })
  } else {
    next()
  }
})

//Vue の起動時のプロダクションのヒントが表示しない
Vue.config.productionTip = false


new Vue({
  //el: '#app',
  //template: '<App/>',
  router,
  // store,
  //components: { App }
  render: h => h(App)
}).$mount('#app')